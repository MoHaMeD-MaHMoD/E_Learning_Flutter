// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_abdelhameed/constants/color.dart';
import 'package:dr_abdelhameed/models/lesson.dart';
import 'package:dr_abdelhameed/provider/user_provider.dart';
import 'package:dr_abdelhameed/widgets/lesson_card.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatefulWidget {
  String subjectTybe;
  String dataType;

  String classNumber = "1";
  final String title;

  DetailsScreen({
    super.key,
    required this.title,
    required this.dataType,
    required this.subjectTybe,
  });
  @override
  // ignore: library_private_types_in_public_api
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  void initState() {
    super.initState();

    switch (widget.title) {
      case "First Class":
        widget.classNumber = "1";
        break;
      case "Second Class":
        widget.classNumber = "2";
        break;
      case "Third Class":
        widget.classNumber = "3";
        break;
    }
  }

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
                          '${widget.subjectTybe}  ${widget.title}',
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                      Positioned(
                        left: 0,
                        child: CustomIconButton(
                          height: 35,
                          width: 35,
                          onTap: () => Navigator.pop(context),
                          child: const Icon(Icons.arrow_back),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),

                const Text(
                  "Created by Dr. / Abdul Hamid Al-Agouza",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
                //--------------------------------------------

                ((userDataFromDB!.classtType == widget.classNumber &&
                            userDataFromDB.subjectType.contains(widget.subjectTybe) ) ||
                        userDataFromDB.email == 'drabdelhamidalagoza@gmail.com')
                    ? (widget.dataType == 'Video')
                        ? StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection(
                                    widget.subjectTybe + widget.classNumber)
                                .where("data_type", isEqualTo: 'Video')
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return const Text('Something went wrong');
                              }

                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
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
                                    Map<String, dynamic> data = document.data()!
                                        as Map<String, dynamic>;
                                    return LessonCard(
                                      lesson: Lesson(
                                          dataType: data['data_type'],
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
                          )
                        : StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection(
                                    widget.subjectTybe + widget.classNumber)
                                .where("data_type", isEqualTo: 'PDF')
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return const Text('Something went wrong');
                              }

                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
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
                                    Map<String, dynamic> data = document.data()!
                                        as Map<String, dynamic>;
                                    return LessonCard(
                                      lesson: Lesson(
                                          dataType: data['data_type'],
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
                          )
                    : const Center(
                        child: Text("Access Desnied : You Are not Subscribe"))

                //----------------------------------------------
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomIconButton extends StatelessWidget {
  final Widget child;
  final double height;
  final double width;
  final Color? color;
  final VoidCallback onTap;

  const CustomIconButton({
    Key? key,
    required this.child,
    required this.height,
    required this.width,
    this.color = Colors.white,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.1),
            blurRadius: 2.0,
            spreadRadius: .05,
          ), //BoxShadow
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Center(child: child),
      ),
    );
  }
}
