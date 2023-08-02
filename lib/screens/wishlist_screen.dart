import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_abdelhameed/constants/color.dart';
import 'package:dr_abdelhameed/models/lesson.dart';
import 'package:dr_abdelhameed/provider/user_provider.dart';
import 'package:dr_abdelhameed/widgets/lesson_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  Widget build(BuildContext context) {
    final userDataFromDB = Provider.of<UserProvider>(context).getUser;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IntrinsicHeight(
                  child: Stack(
                    children: [
                      Align(
                        child: Text(
                          'Wishlist Page',
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),

                Text(
                  "Lessons Liked By ${userDataFromDB!.userName}",
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    color: kPrimaryColor,
                    fontSize: 16,
                  ),
                ),
                //--------------------------------------------
                const Text(
                  "Physics",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: kpink,
                    fontSize: 16,
                  ),
                ),

                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("Physics${userDataFromDB.classtType}")
                      .where('wishlist', arrayContains: userDataFromDB.uid)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: kPrimaryLight,
                        ),
                      );
                    }

                    return Expanded(
                      child: ListView(
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                          Map<String, dynamic> data =
                              document.data()! as Map<String, dynamic>;
                          return LessonCard(
                            lesson: Lesson(
                                dataType: data['data_type'],
                                videoName: data['videoName'],
                                datePublished: DateTime.now(),
                                classNumber: data['classNumber'],
                                sybjectType: data['sybjectType'],
                                url: data['url'],
                                lessonId: data['lessonId'],
                                watchingList: data['watchingList'],
                                wishlist: data['wishlist'],
                                duration: data['duration'],
                                name: data['name']),
                            itemCount: snapshot.data!.docs.length,
                          );
                        }).toList(),
                      ),
                    );
                  },
                ),

                //------------------------------
                const Text(
                  "Chemistry",
                  style: TextStyle(
                    color: korange,
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),

                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("Chemistry${userDataFromDB.classtType}")
                      .where('wishlist', arrayContains: userDataFromDB.uid)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: kPrimaryLight,
                        ),
                      );
                    }

                    return Expanded(
                      child: ListView(
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                          Map<String, dynamic> data =
                              document.data()! as Map<String, dynamic>;
                          return LessonCard(
                            lesson: Lesson(
                                dataType: data['data_type'],
                                videoName: data['videoName'],
                                datePublished: DateTime.now(),
                                classNumber: data['classNumber'],
                                sybjectType: data['sybjectType'],
                                url: data['url'],
                                lessonId: data['lessonId'],
                                watchingList: data['watchingList'],
                                wishlist: data['wishlist'],
                                duration: data['duration'],
                                name: data['name']),
                            itemCount: snapshot.data!.docs.length,
                          );
                        }).toList(),
                      ),
                    );
                  },
                ),

                //-----------------------------
                const Text(
                  "Biology",
                  style: TextStyle(
                    color: kblue,
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("Biology${userDataFromDB.classtType}")
                      .where('wishlist', arrayContains: userDataFromDB.uid)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: kPrimaryLight,
                        ),
                      );
                    }

                    return Expanded(
                      child: ListView(
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                          Map<String, dynamic> data =
                              document.data()! as Map<String, dynamic>;
                          return LessonCard(
                            lesson: Lesson(
                                dataType: data['data_type'],
                                datePublished: DateTime.now(),
                                classNumber: data['classNumber'],
                                sybjectType: data['sybjectType'],
                                videoName: data['videoName'], 
                                url: data['url'],
                                lessonId: data['lessonId'],
                                watchingList: data['watchingList'],
                                wishlist: data['wishlist'],
                                duration: data['duration'],
                                name: data['name']),
                            itemCount: snapshot.data!.docs.length,
                          );
                        }).toList(),
                      ),
                    );
                  },
                )

                // StreamBuilder<QuerySnapshot>(
                //   stream: FirebaseFirestore.instance
                //       .collection(userDataFromDB.subjectType +
                //           userDataFromDB.classtType)
                //       .where('wishlist', arrayContains: userDataFromDB.uid)
                //       .snapshots(),
                //   builder: (BuildContext context,
                //       AsyncSnapshot<QuerySnapshot> snapshot) {
                //     if (snapshot.hasError) {
                //       return const Text('Something went wrong');
                //     }

                //     if (snapshot.connectionState == ConnectionState.waiting) {
                //       return const Center(
                //         child: CircularProgressIndicator(
                //           color: kPrimaryLight,
                //         ),
                //       );
                //     }

                //     return Expanded(
                //       child: ListView(
                //         children: snapshot.data!.docs
                //             .map((DocumentSnapshot document) {
                //           Map<String, dynamic> data =
                //               document.data()! as Map<String, dynamic>;
                //           return LessonCard(
                //             lesson: Lesson(
                //                 dataType: data['data_type'],
                //                 datePublished: DateTime.now(),
                //                 classNumber: data['classNumber'],
                //                 sybjectType: data['sybjectType'],
                //                 url: data['url'],
                //                 lessonId: data['lessonId'],
                //                 watchingList: data['watchingList'],
                //                 wishlist: data['wishlist'],
                //                 duration: data['duration'],
                //                 name: data['name']),
                //             itemCount: snapshot.data!.docs.length,
                //           );
                //         }).toList(),
                //       ),
                //     );
                //   },
                // )

                //----------------------------------------------
              ],
            ),
          ),
        ),
      ),
    );
  }
}
