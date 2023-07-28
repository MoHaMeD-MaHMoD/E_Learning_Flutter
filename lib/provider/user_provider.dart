import 'package:dr_abdelhameed/firebase%20services/auth.dart';
import 'package:dr_abdelhameed/models/userData.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  UserData? _userData;
  UserData? get getUser => _userData;

  refreshUser() async {
    UserData userData = await AuthUser().getUserDetails();
    _userData = userData;
    notifyListeners();
  }
}
