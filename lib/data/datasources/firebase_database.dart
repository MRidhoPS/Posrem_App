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
    final newEntryId = 'entry_${DateTime.now().millisecondsSinceEpoch}';

    try {
      await db.runTransaction((transaction) async {
        final userSnapshot = await transaction.get(userDocRef);

        if (userSnapshot.exists) {
          final userData = userSnapshot.data() as Map<String, dynamic>;
          Map<String, dynamic> userDataEntries = userData['data'] ?? {};
          int currentCounter = userData['dataCounter'] ?? 0;

          currentCounter++;
          final newEntry = {
            'idData': currentCounter,
            'tb': tb,
            'bb': bb,
            'td': td,
            'lila': lila,
            'lp': lp,
            'bmi': bmi,
            'bmiDesc': bmiDesc,
            'createdAt': Timestamp.now(),
          };

          userDataEntries[newEntryId] = newEntry;
          transaction.update(userDocRef, {
            'data': userDataEntries,
            'dataCounter': currentCounter, // Update the counter in Firestore
          });
        } else {
          transaction.set(userDocRef, {
            'data': {
              newEntryId: {
                'idData': 1,
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
            'dataCounter': 1, // Initialize the counter
          });
        }
      });
    } catch (e, stackTrace) {
      print("Error during transaction: $e");
      print("Stack trace: $stackTrace");
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
}