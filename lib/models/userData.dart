// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  int numberOfOnlineDevices;
  String email;
  String password;
  String userName;
  String uid;
  List  subjectType;
  String classtType;

  UserData({
    required this.numberOfOnlineDevices,
    required this.email,
    required this.password,
    required this.userName,
    required this.uid,
    required this.subjectType,
    required this.classtType,
  });

  Map<String, dynamic> convertToMap() {
    return {
      'user_name': userName,
      'email': email,
      'passwoed': password,
      'uid': uid,
      'subjectType': subjectType,
      'classtType': classtType,
      'numberOfOnlineDevices': numberOfOnlineDevices
    };
  }

  // function that convert "DocumentSnapshot" to a User
// function that takes "DocumentSnapshot" and return a User

  static convertSnap2Model(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserData(
        email: snapshot["email"],
        userName: snapshot["user_name"],
        password: snapshot["passwoed"],
        uid: snapshot["uid"],
        subjectType: snapshot["subjectType"],
        classtType: snapshot["classtType"],
        numberOfOnlineDevices: snapshot["numberOfOnlineDevices"]);
  }
}
