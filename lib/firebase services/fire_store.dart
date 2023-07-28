import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_abdelhameed/constants/snackbar';
import 'package:dr_abdelhameed/firebase%20services/storage.dart';
import 'package:dr_abdelhameed/models/lesson.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  deleteLesson({
    required collec,
    required docss,
    required context,
  }) async {
    await FirebaseFirestore.instance.collection(collec).doc(docss).delete();
  }

  addLesson(
      {required description,
      required sybjectType,
      required classNumber,
      required dataType,
      required duration,
      required context,
      required videoPath,
      required videoName,
      required folderName}) async {
    try {
      String videoURL = await getVideoURL(
          videoPath: videoPath, videoName: videoName, folderName: folderName);
      CollectionReference lessons =
          FirebaseFirestore.instance.collection(sybjectType + classNumber);
      String newId = const Uuid().v1();

      Lesson lessonData = Lesson(
        dataType: dataType,
        datePublished: DateTime.now(),
        name: description,
        wishlist: [],
        watchingList: [],
        lessonId: newId,
        duration: duration,
        url: videoURL,
        classNumber: classNumber,
        sybjectType: sybjectType,
      );

      lessons
          .doc(newId)
          .set(lessonData.convertToMap())
          .then((value) => showSnackBar(context, "Lesson Added"))
          .catchError((error) =>
              showSnackBar(context, "Failed to add Lesson: $error "));
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, "ERROR ${e.code}");
    } catch (e) {
      showSnackBar(context, "ERROR :  $e ");
    }
  }

  addToWatchingList(
      {required sybjectType, required classNumber, required lessonId}) async {
    await FirebaseFirestore.instance
        .collection(sybjectType + classNumber)
        .doc(lessonId)
        .update({
      "watchingList":
          FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid])
    });
  }

  addToWishList(
      {required sybjectType, required classNumber, required lessonId}) async {
    await FirebaseFirestore.instance
        .collection(sybjectType + classNumber)
        .doc(lessonId)
        .update({
      "wishlist":
          FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid])
    });
  }

  removeFromWishList(
      {required lessonName, required classNumber, required lessonId}) async {
    await FirebaseFirestore.instance
        .collection(lessonName + classNumber)
        .doc(lessonId)
        .update({
      "wishlist":
          FieldValue.arrayRemove([FirebaseAuth.instance.currentUser!.uid])
    });
  }

  toggleLike({required Map postData}) async {
    try {
      if (postData["likes"].contains(FirebaseAuth.instance.currentUser!.uid)) {
        await FirebaseFirestore.instance
            .collection("posts")
            .doc(postData["postId"])
            .update({
          "likes":
              FieldValue.arrayRemove([FirebaseAuth.instance.currentUser!.uid])
        });
      } else {
        await FirebaseFirestore.instance
            .collection("posts")
            .doc(postData["postId"])
            .update({
          "likes":
              FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid])
        });
      }
    } catch (e) {
      log('log: $e');
    }
  }
}
