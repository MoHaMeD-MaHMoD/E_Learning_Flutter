import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_abdelhameed/constants/color.dart';
import 'package:dr_abdelhameed/constants/size.dart';
import 'package:dr_abdelhameed/firebase%20services/auth.dart';
import 'package:dr_abdelhameed/models/category.dart';
import 'package:dr_abdelhameed/provider/user_provider.dart';
import 'package:dr_abdelhameed/screens/course_screen.dart';
import 'package:dr_abdelhameed/screens/pdf_video_choise.dart';
import 'package:dr_abdelhameed/screens/user/sign_in.dart';
import 'package:dr_abdelhameed/widgets/search_testfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class FeaturedScreen extends StatefulWidget {
  const FeaturedScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _FeaturedScreenState createState() => _FeaturedScreenState();
}

class _FeaturedScreenState extends State<FeaturedScreen> {
  @override
  Widget build(BuildContext context) {
    return const AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              AppBar(),
              Body(),
            ],
          ),
        ),
      ),
    );
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    categoryList.clear();
    final userDataFromDB = Provider.of<UserProvider>(context).getUser;

    if (userDataFromDB!.subjectType.contains("Physics")) {
      categoryList.add(Category(
        name: 'Physics',
        noOfCourses: 3,
        thumbnail: 'assets/icons/Physics.jpg',
      ));
    }

    if (userDataFromDB.subjectType.contains("Chemistry")) {
      categoryList.add(Category(
        name: 'Chemistry',
        noOfCourses: 3,
        thumbnail: 'assets/icons/Chemistry.jpg',
      ));
    }

    if (userDataFromDB.subjectType.contains("Biology")) {
      categoryList.add(
        Category(
          name: 'Biology',
          noOfCourses: 3,
          thumbnail: 'assets/icons/biology.jpg',
        ),
      );
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Categories",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 8,
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
            crossAxisSpacing: 20,
            mainAxisSpacing: 24,
          ),
          itemBuilder: (context, index) {
            return CategoryCard(
              category: categoryList[index],
              title: userDataFromDB.classtType,
            );
          },
          itemCount: categoryList.length,
        ),
      ],
    );
  }
}

class CategoryCard extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final title;
  final Category category;
  const CategoryCard({
    Key? key,
    required this.title,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("itle---------------$title");
    return GestureDetector(
      onTap: () {
        if (FirebaseAuth.instance.currentUser!.email ==
            'drabdelhamidalagoza@gmail.com') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CourseScreen(
                subjectTybe: category.name,
              ),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PdfORVideoWidget(
                subjectTybe: category.name,
                classNumber: title,
              ),
            ),
          );
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width * .45,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.1),
              blurRadius: 4.0,
              spreadRadius: .05,
            ), //BoxShadow
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Image.asset(
                category.thumbnail,
                height: kCategoryCardImageSize,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(category.name),
            Text(
              "${category.noOfCourses.toString()} Courses",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

class AppBar extends StatelessWidget {
  const AppBar({super.key});
  @override
  Widget build(BuildContext context) {
    DateTime realTime = DateTime.now();
    String greating = "";
    if (realTime.hour >= 1 && realTime.hour < 12) {
      greating = "Good Morning";
    } else if (realTime.hour >= 12 && realTime.hour < 17) {
      greating = "Good Afternoon";
    } else {
      greating = "Good Evening";
    }

    return Container(
      padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
      height: 200,
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.1, 0.5],
          colors: [
            Color(0xff886ff2),
            Color(0xff6849ef),
          ],
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                //${allUserDataFromDB!.name}
                //userDataFromDB!.userName

                "Hello, ${FirebaseAuth.instance.currentUser!.displayName} 😍 \n$greating",
                style: Theme.of(context).textTheme.titleLarge,
              ),

              //------------------------------
              FloatingActionButton.small(
                //<-- SEE HERE
                backgroundColor: kPrimaryLight,
                onPressed: () async {
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .get()
                      .then((DocumentSnapshot documentSnapshot) {
                    if (documentSnapshot['numberOfOnlineDevices'] > 0) {
                      FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .update({
                        "numberOfOnlineDevices":
                            documentSnapshot['numberOfOnlineDevices'] - 1
                      });
                    }
                  });

                  await Future.delayed(const Duration(seconds: 1), () {
                    AuthUser().logOut();
                  });

                  // ignore: use_build_context_synchronously
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Login()),
                  );
                },
                child: const Icon(
                  Icons.exit_to_app,
                  size: 24,
                  color: Colors.white70,
                ),
              )

              //---------------------------
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const SearchTextField()
        ],
      ),
    );
  }
}
