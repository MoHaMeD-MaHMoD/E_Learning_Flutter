import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_abdelhameed/constants/snackbar';
import 'package:dr_abdelhameed/models/userData.dart';
import 'package:dr_abdelhameed/screens/wellcome_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthUser {
  register({
    required subjectType,
    required classtType,
    required name,
    required emailAddress,
    required password,
    required context,
  }) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      final user = credential.user;

      await user?.updateDisplayName(name);

      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      UserData userr = UserData(
          subjectType: subjectType,
          classtType: classtType,
          email: emailAddress,
          password: password,
          uid: credential.user!.uid,
          userName: name,
          numberOfOnlineDevices: 1);

      users
          .doc(credential.user!.uid)
          .set(userr.convertToMap())
          .then((value) => showSnackBar(context, "User Added "))
          .catchError(
              (error) => showSnackBar(context, "Failed to add user:  $error "));
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, "ERROR ${e.code}");
    } catch (e) {
      showSnackBar(context, "ERROR :  $e ");
    }
  }

  signIn({required emaill, required passwordd, required context}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emaill, password: passwordd);

      if (FirebaseAuth.instance.currentUser!.uid !=
          "2lwjNX5uQ1TP621kr7XZQ0MeZ8E2") {
        FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get()
            .then((DocumentSnapshot documentSnapshot) {
          if (documentSnapshot['numberOfOnlineDevices'] > 0) {
            showSnackBar(context, "another user login");
            logOut();
          } else {
            FirebaseFirestore.instance
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .update({
              "numberOfOnlineDevices":
                  documentSnapshot['numberOfOnlineDevices'] + 1
            });

            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const WelcomeScreen()),
                (r) => false);
          }
        });
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const WelcomeScreen()),
            (r) => false);
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, "ERRoooooooooOR :  ${e.code} ");
    } catch (e) {
      showSnackBar(context, "ERROR :  $e ");
    }
  }

  logOut() async {
    await FirebaseAuth.instance.signOut();
  }

  deleteUser({
    required docss,
    required context,
  }) async {
    await FirebaseFirestore.instance.collection('users').doc(docss).delete();
  }

  // functoin to get user details from Firestore (Database)
  Future<UserData> getUserDetails() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    return UserData.convertSnap2Model(snap);
  }
}



