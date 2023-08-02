// import 'dart:io';

// import 'package:firebase_storage/firebase_storage.dart';

// // Function to get img url

// getVideoURL({
//   required String videoName,
//   required File videoPath,
//   required String folderName,
// }) async {
//   // Upload image to firebase storage
//   final storageRef = FirebaseStorage.instance.ref("$folderName/$videoName");
//   // use this code if u are using flutter web
//   UploadTask uploadTask = storageRef.putFile(videoPath);

//   uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) {
    
//     switch (taskSnapshot.state) {
//       case TaskState.running:
//         final progress =
//             100 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
//         print("upload id $progress completed");
//         break;
//       case TaskState.paused:
//         print("upload is paused");
//         break;

//       case TaskState.canceled:
//         print("upload is canceled");
//         break;

//       case TaskState.error:
//         print("ERROR while upload ");
//         break;

//       case TaskState.success:
//         print("video uploaded in Success");
//         break;
//     }
//   });

//   TaskSnapshot snap = await uploadTask;
//   // Get img url
//   String urll = await snap.ref.getDownloadURL();

//   return urll;
// }
