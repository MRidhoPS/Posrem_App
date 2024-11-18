import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices {
  final db = FirebaseFirestore.instance;


  void createUser(String name, String marital) async {
    final userDocRef = db.collection('users').doc();

    // Create user document with initial values and null data
    final userData = {
      'name': name,
      'marital': marital,
      'data': null, // Initialize data as null
    };

    await userDocRef
        .set(userData)
        .onError((e, _) => print("Error creating user document: $e"));
  }

  void addMonthlyData(String bmi, String bmiDesc, String id) async {
    final userDocRef = db.collection('users').doc(id);

    // Generate a unique ID based on the current timestamp for more reliable uniqueness
    final newEntryId = 'entry_${DateTime.now().millisecondsSinceEpoch}';

    // Create the new monthly data entry
    final newEntry = {
      'bmi': bmi,
      'bmiDesc': bmiDesc,
      'createdAt': Timestamp.now()
    };

    // Use a transaction to safely check and update data
    try {
      await db.runTransaction((transaction) async {
        final userSnapshot = await transaction.get(userDocRef);

        if (userSnapshot.exists) {
          final userData = userSnapshot.data() as Map<String, dynamic>;

          // Check if 'data' is null, and initialize it as an empty map if needed
          if (userData['data'] == null) {
            transaction.update(userDocRef, {
              'data': {newEntryId: newEntry}
            });
          } else {
            // Append the new entry under a unique key
            transaction.update(userDocRef, {'data.$newEntryId': newEntry});
          }
        } else {
          print("User document does not exist.");
        }
      });
    } catch (e, stackTrace) {
      print("Error during transaction: $e");
      print("Stack trace: $stackTrace");
    }
  }

  Future<List<Map<String, dynamic>>> fetchAllUser() async{
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('users').get();

    List<Map<String, dynamic>> jsonData = querySnapshot.docs.map((doc){
      return {
        'id': doc.id,
        ...doc.data() as Map<String, dynamic>};
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


