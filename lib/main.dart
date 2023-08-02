
import 'package:dr_abdelhameed/provider/user_provider.dart';
import 'package:dr_abdelhameed/screens/user/sign_in.dart';
import 'package:dr_abdelhameed/screens/wellcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:dr_abdelhameed/constants/snackbar';

// required for onCreate parameter

//----------------------------------

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyCIjjmRHYA5DtyfkjDF8umxK6tBiG0F3X8",
            appId: "1:868900990570:web:b6222c7d7d4f1ab333a413",
            // new key
            measurementId: "G-G2WTX7XBY1",
            messagingSenderId: "868900990570",
            projectId: "dr-abdelhameed",
            authDomain: "dr-abdelhameed.firebaseapp.com",
            storageBucket: "dr-abdelhameed.appspot.com"));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}





//-------------------------------------------

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return UserProvider();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Education App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Poppins',
          textTheme: const TextTheme(
            titleLarge: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
            bodyLarge: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
            bodyMedium: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            displayMedium: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: Colors.black,
            ),
          ),
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.white,
              ));
            } else if (snapshot.hasError) {
              return showSnackBar(context, "Something went wrong");
            } else if (snapshot.hasData) {
              return const WelcomeScreen();
            } else {
              return const Login();
            }
          },
        ),
      ),
    );
  }
}
