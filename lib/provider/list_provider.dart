import 'package:flutter/material.dart';
import 'package:posrem_webapp/database/firebase_database.dart';

class ListProvider extends ChangeNotifier{
  final DatabaseServices _databaseServices = DatabaseServices();
  List<Map<String, dynamic>> _users = [];
  bool _isLoading = false;
  String? _error;

  List<Map<String, dynamic>> get users => _users;
  bool get isLoading => _isLoading;
  String? get error => _error;

  ListProvider(){
    fethAllUser();
  }

  Future<void> fethAllUser() async{
    _isLoading = true;
    notifyListeners();

    try {
      _users = await _databaseServices.fetchAllUser();
      _error = null;
    } catch (e) {
      _error = e.toString();
      _users = [];
    }

    _isLoading = false;
    notifyListeners();
  }
}