import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

// Function to get img url

getVideoURL({
  required String videoName,
  required File videoPath,
  required String folderName,
}) async {
  // Upload image to firebase storage
  final storageRef = FirebaseStorage.instance.ref("$folderName/$videoName");
  // use this code if u are using flutter web
  UploadTask uploadTask = storageRef.putFile(videoPath);
  TaskSnapshot snap = await uploadTask;

  // Get img url
  String urll = await snap.ref.getDownloadURL();

  return urll;
}
