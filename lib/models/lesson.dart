import 'package:cloud_firestore/cloud_firestore.dart';

class Lesson {
  String name;
  String url;
  String lessonId;
  String sybjectType;
  String classNumber;
  String dataType;
  int duration;
  List watchingList;

  List wishlist;
  DateTime datePublished;

  Lesson({
        required this.dataType,

    required this.datePublished,
    required this.classNumber,
    required this.sybjectType,
    required this.url,
    required this.lessonId,
    required this.wishlist,
    required this.duration,
    required this.watchingList,
    required this.name,
  });

  Map<String, dynamic> convertToMap() {
    return {
      'data_type':dataType,
      'sybjectType': sybjectType,
      'wishlist': wishlist,

      'classNumber': classNumber,
      'duration': duration,
      'watchingList': watchingList,
      'name': name,
      'lessonId': lessonId,
      'url': url,
      'datePublished': datePublished,
    };
  }

  // function that convert "DocumentSnapshot" to a lesson
// function that takes "DocumentSnapshot" and return a lesson

  static convertSnap2Model(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Lesson(
      dataType:snapshot['data_type'],
      classNumber: snapshot["classNumber"],
      sybjectType: snapshot["sybjectType"],
      name: snapshot["name"],
      lessonId: snapshot["lessonId"],
      url: snapshot["url"],
      duration: snapshot["duration"],
      datePublished: snapshot["datePublished"],
      wishlist: snapshot["wishlist"],
      watchingList: snapshot["watchingList"],
    );
  }
}
