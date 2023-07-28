import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_abdelhameed/constants/color.dart';
import 'package:dr_abdelhameed/constants/icons.dart';
import 'package:dr_abdelhameed/constants/size.dart';
import 'package:dr_abdelhameed/firebase%20services/auth.dart';
import 'package:dr_abdelhameed/provider/user_provider.dart';
import 'package:dr_abdelhameed/screens/featuerd_screen.dart';
import 'package:dr_abdelhameed/screens/upload_lesson.dart';
import 'package:dr_abdelhameed/screens/user/all_user.dart';
import 'package:dr_abdelhameed/screens/user/sign_in.dart';
import 'package:dr_abdelhameed/screens/user/sign_up.dart';
import 'package:dr_abdelhameed/screens/wishlist_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int _selectedIndex = 0;

  getDataFromDB() async {
    UserProvider userProvider = Provider.of(context, listen: false);
    await userProvider.refreshUser();
  }

  @override
  void initState() {
    super.initState();
    getDataFromDB();
  }

  static final List<Widget> _widgetOptions = <Widget>[
    const FeaturedScreen(),
    const WishlistScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            (FirebaseAuth.instance.currentUser!.email ==
                        'drabdelhamidalagoza@gmail.com' )
                ? Column(
                    children: [
                      const UserAccountsDrawerHeader(
                          decoration: BoxDecoration(
                            color: kPrimaryLight,
                            image: DecorationImage(
                                image: AssetImage("assets/icons/icon2.jpg"),
                                fit: BoxFit.fill),
                          ),
                          accountName: Text(' ',
                              //currentUser.displayName!,
                              style: TextStyle(color: Colors.amber)),
                          accountEmail: Text(
                            "", style: TextStyle(color: Colors.amber),
                            // currentUser.email!
                          )),
                      ListTile(
                          title: const Text(
                            "Add User",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          leading: const Icon(Icons.add),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Register()),
                            );
                          }),
                      ListTile(
                          title: const Text("All Users",
                              style: TextStyle(fontWeight: FontWeight.w500)),
                          leading: const Icon(Icons.people),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AllUser()),
                            );
                          }),
                      ListTile(
                          title: const Text("Upload Lesson",
                              style: TextStyle(fontWeight: FontWeight.w500)),
                          leading: const Icon(Icons.upload),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const VideoSelector(),
                                ));
                          }),
                      ListTile(
                          title: const Text("About",
                              style: TextStyle(fontWeight: FontWeight.w500)),
                          leading: const Icon(Icons.help_center),
                          onTap: () {}),
                      ListTile(
                          title: const Text("Logout",
                              style: TextStyle(fontWeight: FontWeight.w500)),
                          leading: const Icon(Icons.exit_to_app),
                          onTap: () async {
                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .get()
                                .then((DocumentSnapshot documentSnapshot) {
                              if (documentSnapshot['numberOfOnlineDevices'] >
                                  0) {
                                FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .update({
                                  "numberOfOnlineDevices": documentSnapshot[
                                          'numberOfOnlineDevices'] -
                                      1
                                });
                              }
                            });

                            await Future.delayed(const Duration(seconds: 1),
                                () {
                              AuthUser().logOut();
                            });

                            // ignore: use_build_context_synchronously
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Login()),
                            );
                          }),
                    ],
                  )
                : const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 250),
                    child: Text("Available For Admin Only",
                        style: TextStyle(
                            fontSize: 18,
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold)),
                  ),
            Container(
              margin: const EdgeInsets.only(bottom: 12),
              child: const Text("Developed by ELBeaky © 2023",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            )
          ],
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: kPrimaryColor,
          backgroundColor: Colors.white,
          elevation: 0,
          items: [
            BottomNavigationBarItem(
              activeIcon: Image.asset(
                icLearning,
                height: kBottomNavigationBarItemSize,
              ),
              icon: Image.asset(
                icLearningOutlined,
                height: kBottomNavigationBarItemSize,
              ),
              label: "My Learning",
            ),
            BottomNavigationBarItem(
              activeIcon: Image.asset(
                icWishlist,
                height: kBottomNavigationBarItemSize,
              ),
              icon: Image.asset(
                icWishlistOutlined,
                height: kBottomNavigationBarItemSize,
              ),
              label: "Wishlist",
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          }),
    );
  }
}
