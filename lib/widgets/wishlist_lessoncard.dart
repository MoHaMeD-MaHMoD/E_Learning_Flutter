import 'package:dr_abdelhameed/constants/icons.dart';
import 'package:dr_abdelhameed/firebase%20services/fire_store.dart';
import 'package:dr_abdelhameed/models/lesson.dart';
import 'package:dr_abdelhameed/screens/media_shower.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WishListLessonCard extends StatelessWidget {
  final Lesson lesson;
  const WishListLessonCard({super.key, required this.lesson, required int itemCount});

  @override
  Widget build(BuildContext context) {
 

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Row(
        children: [

          InkWell(
            onTap: () async {
              FirestoreMethods().addToWatchingList(
                  classNumber: lesson.classNumber,
                  lessonId: lesson.lessonId,
                  sybjectType: lesson.sybjectType);

              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => VideoShow(
                          url: lesson.url, dataType: lesson.dataType,
                        )),
              );
            },
            child: Image.asset(
              icPlayNext,
              height: 45,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  lesson.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  lesson.duration.toString(),
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          lesson.wishlist.contains(FirebaseAuth.instance.currentUser!.uid)
              ? InkWell(
                  onTap: () async {
                    FirestoreMethods().removeFromWishList(
                        classNumber: lesson.classNumber,
                        lessonId: lesson.lessonId,
                        lessonName: lesson.sybjectType);
                  },
                  child: Image.asset(
                    icWishlist,
                    height: 30,
                  ),
                )
              : InkWell(
                  onTap: () async {
                    FirestoreMethods().addToWishList(
                        classNumber: lesson.classNumber,
                        lessonId: lesson.lessonId,
                        sybjectType: lesson.sybjectType);
                  },
                  child: Image.asset(
                    icWishlistOutlined,
                    height: 30,
                  ),
                ),
          const SizedBox(
            width: 8,
          ),
          lesson.watchingList.contains(FirebaseAuth.instance.currentUser!.uid)
              ? Image.asset(
                  icDone,
                  height: 30,
                )
              : Image.asset(
                  icLock,
                  height: 30,
                ),
        ],
      ),
    );
  }
}
