import 'package:flutter/material.dart';
import 'package:posrem_webapp/database/firebase_database.dart';

class DetailuserProvider  extends ChangeNotifier{
  Map<String, dynamic>? usersDetails;
  bool isLoading = false;

  Future<void> fetchDetailUser(String userId) async{
    isLoading = true;
    notifyListeners();

    try {
      usersDetails = await DatabaseServices().fetchUserById(userId);
    } catch (e) {
      usersDetails = null;
    } finally {
      isLoading = false;
      notifyListeners(); 
    }
  }

}