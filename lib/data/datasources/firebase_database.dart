import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices {
  final db = FirebaseFirestore.instance;

  void createUser(
    String name,
    String gender,
    String born,
    String religion,
    String address,
    String education,
    String phoneNum,
  ) async {
    final userDocRef = db.collection('users').doc();

    // Create user document with initial values and null data
    final userData = {
      'name': name,
      'gender': gender,
      'born': born,
      'religion': religion,
      'address': address,
      'education': education,
      'phoneNum': phoneNum,
      'data': null, // Initialize data as null
    };

    await userDocRef
        .set(userData)
        .onError((e, _) => print("Error creating user document: $e"));
  }

  // void addMonthlyData(
  //   String id,
  //   String tb,
  //   String bb,
  //   String td,
  //   String lila,
  //   String lp,
  //   String bmi,
  //   String bmiDesc,
  // ) async {
  //   final userDocRef = db.collection('users').doc(id);
  //   final newEntryId = 'entry_${DateTime.now().millisecondsSinceEpoch}';

  //   try {
  //     await db.runTransaction((transaction) async {
  //       final userSnapshot = await transaction.get(userDocRef);

  //       if (userSnapshot.exists) {
  //         final userData = userSnapshot.data() as Map<String, dynamic>;
  //         Map<String, dynamic> userDataEntries = userData['data'] ?? {};
  //         int currentCounter = userData['dataCounter'] ?? 0;

  //         currentCounter++;
  //         final newEntry = {
  //           'idData': currentCounter,
  //           'tb': tb,
  //           'bb': bb,
  //           'td': td,
  //           'lila': lila,
  //           'lp': lp,
  //           'bmi': bmi,
  //           'bmiDesc': bmiDesc,
  //           'createdAt': Timestamp.now(),
  //         };

  //         userDataEntries[newEntryId] = newEntry;
  //         transaction.update(userDocRef, {
  //           'data': userDataEntries,
  //           'dataCounter': currentCounter, // Update the counter in Firestore
  //         });
  //       } else {
  //         transaction.set(userDocRef, {
  //           'data': {
  //             newEntryId: {
  //               'idData': 1,
  //               'tb': tb,
  //               'bb': bb,
  //               'td': td,
  //               'lila': lila,
  //               'lp': lp,
  //               'bmi': bmi,
  //               'bmiDesc': bmiDesc,
  //               'createdAt': Timestamp.now(),
  //             },
  //           },
  //           'dataCounter': 1, // Initialize the counter
  //         });
  //       }
  //     });
  //   } catch (e) {}
  // }

  void addMonthlyData(
    String id,
    String tb,
    String bb,
    String td,
    String lila,
    String lp,
    String bmi,
    String bmiDesc,
  ) async {
    final userDocRef = db.collection('users').doc(id);
    final year = DateTime.now().year.toString();
    final newEntryId = 'entry_${DateTime.now().millisecondsSinceEpoch}';

    try {
      await db.runTransaction((transaction) async {
        final userSnapshot = await transaction.get(userDocRef);

        if (userSnapshot.exists) {
          final userData = userSnapshot.data() as Map<String, dynamic>;
          Map<String, dynamic> yearlyData = userData['data'] ?? {};

          // Ambil data untuk tahun ini atau inisialisasi baru
          Map<String, dynamic> currentYearData =
              yearlyData[year] as Map<String, dynamic>? ?? {};

          final newEntry = {
            'tb': tb,
            'bb': bb,
            'td': td,
            'lila': lila,
            'lp': lp,
            'bmi': bmi,
            'bmiDesc': bmiDesc,
            'createdAt': Timestamp.now(),
          };

          // Tambahkan data entry baru ke tahun saat ini
          currentYearData[newEntryId] = newEntry;

          // Update struktur data berdasarkan tahun
          yearlyData[year] = currentYearData;

          transaction.update(userDocRef, {
            'data': yearlyData,
          });
        } else {
          // Jika dokumen belum ada, buat struktur baru
          transaction.set(userDocRef, {
            'data': {
              year: {
                newEntryId: {
                  'tb': tb,
                  'bb': bb,
                  'td': td,
                  'lila': lila,
                  'lp': lp,
                  'bmi': bmi,
                  'bmiDesc': bmiDesc,
                  'createdAt': Timestamp.now(),
                },
              },
            },
          });
        }
      });
    } catch (e) {
      print('Error updating monthly data: $e');
    }
  }

  Future<List<Map<String, dynamic>>> fetchAllUser() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('users').get();

    List<Map<String, dynamic>> jsonData = querySnapshot.docs.map((doc) {
      return {'id': doc.id, ...doc.data() as Map<String, dynamic>};
    }).toList();

    return jsonData;
  }

  Future<Map<String, dynamic>> fetchUserById(String userId) async {
    final doc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    if (!doc.exists) {
      throw Exception('User not found');
    }
    return {'id': doc.id, ...doc.data() as Map<String, dynamic>};
  }

  Future<Map<String, dynamic>?> searchPatientByNameAndGender(
      String name, String gender) async {
    try {
      // Query ke Firestore berdasarkan nama dan gender
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('name', isEqualTo: name)
          .where('gender', isEqualTo: gender)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Ambil data pertama dari hasil query
        return querySnapshot.docs.first.data();
      } else {
        print("Data pasien tidak ditemukan!");
        return null;
      }
    } catch (e) {
      print("Terjadi kesalahan: $e");
      return null;
    }
  }

  Future<List<String>> fetchDataYear(String userId) async {
    final doc =
        await FirebaseFirestore.instance.collection('user').doc(userId).get();

    if (!doc.exists) {
      throw Exception('User not found');
    }

    // Ambil semua tahun yang tersedia dalam "data"
    Map<String, dynamic>? data = doc.data()?['data'];

    if (data != null) {
      return data.keys
          .toList(); // Mengembalikan daftar tahun (misal: ['2025', '2024'])
    }

    throw Exception('No year data found');
  }

  Future<Map<String, dynamic>> fetchDataMonthly(String userId, String year) async{
     final doc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    if (!doc.exists) {
      throw Exception('User not found');
    }

    // Ambil data dari tahun yang dipilih
    Map<String, dynamic>? yearData = doc.data()?['data']?[year];

    if (yearData != null) {
      return yearData; // Mengembalikan semua entry bulanan dari tahun tersebut
    }

    throw Exception('No monthly data found for year $year');
  }
}
