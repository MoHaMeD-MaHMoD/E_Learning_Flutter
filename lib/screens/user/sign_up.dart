import 'package:dr_abdelhameed/constants/color.dart';
import 'package:dr_abdelhameed/constants/constants.dart';
import 'package:dr_abdelhameed/firebase%20services/auth.dart';
import 'package:flutter/material.dart';

// ignore: unused_import
import 'package:path/path.dart' show basename;

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late List<String> subjectItemsList;
  bool physicscheckedValue = false;
  bool chemistrycheckedValue = false;
  bool biologycheckedValue = false;

  List<String> classItemsList = ['1', '2', '3'];
  String? selectedClassItemsList = '1';

  bool isVisable = true;

  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  onRegister() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      subjectItemsList = [];

      if (physicscheckedValue) {
        subjectItemsList.add('Physics');
      }
      if (chemistrycheckedValue) {
        subjectItemsList.add('Chemistry');
      }
      if (biologycheckedValue) {
        subjectItemsList.add('Biology');
      }

      await AuthUser().register(
        name: nameController.text,
        emailAddress: emailController.text,
        password: passwordController.text,
        context: context,
        subjectType: subjectItemsList,
        classtType: selectedClassItemsList,
      );

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text("Register"),
        elevation: 0,
        // backgroundColor: appbarGreen,
      ),
      body: Center(
        child: Padding(
          padding: widthScreen > 600
              ? EdgeInsets.symmetric(horizontal: widthScreen * .3)
              : const EdgeInsets.all(33.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                      // we return "null" when something is valid
                      // validator: (name) {
                      //   return name!.contains(RegExp(
                      //           "([a-zA-Z0-9_\s]+)"))
                      //       ? null
                      //       : "Enter a valid Name";
                      // },
                      // autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: nameController,
                      keyboardType: TextInputType.emailAddress,
                      obscureText: false,
                      decoration: decorationTextfield.copyWith(
                          hintText: "Enter Your Name ",
                          suffixIcon: const Icon(Icons.person))),
                  const SizedBox(
                    height: 22,
                  ),
                  TextFormField(
                      // we return "null" when something is valid
                      validator: (email) {
                        return email!.contains(RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))
                            ? null
                            : "Enter a valid email";
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      obscureText: false,
                      decoration: decorationTextfield.copyWith(
                          hintText: "Enter Your Email ",
                          suffixIcon: const Icon(Icons.email))),
                  const SizedBox(
                    height: 22,
                  ),
                  TextFormField(
                      // we return "null" when something is valid
                      validator: (value) {
                        return value!.length < 8
                            ? "Enter at least 8 characters"
                            : null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      obscureText: isVisable ? true : false,
                      decoration: decorationTextfield.copyWith(
                          hintText: "Enter Your Password ",
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isVisable = !isVisable;
                                });
                              },
                              icon: isVisable
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off)))),
                  const SizedBox(
                    height: 22,
                  ),
                  const Row(
                    children: [
                      Text("select Subject Type"),
                      SizedBox(
                        width: 11,
                      ),
                    ],
                  ),
                  CheckboxListTile(
                    title: const Text("Physics"),
                    value: physicscheckedValue,
                    onChanged: (newValue) {
                      setState(() {
                        physicscheckedValue = newValue!;
                      });
                    },
                    controlAffinity: ListTileControlAffinity
                        .leading, //  <-- leading Checkbox
                  ),
                  CheckboxListTile(
                    title: const Text("Chemistry"),
                    value: chemistrycheckedValue,
                    onChanged: (newValue) {
                      setState(() {
                        chemistrycheckedValue = newValue!;
                      });
                    },
                    controlAffinity: ListTileControlAffinity
                        .leading, //  <-- leading Checkbox
                  ),
                  CheckboxListTile(
                    title: const Text("Biology"),
                    value: biologycheckedValue,
                    onChanged: (newValue) {
                      setState(() {
                        biologycheckedValue = newValue!;
                      });
                    },
                    controlAffinity: ListTileControlAffinity
                        .leading, //  <-- leading Checkbox
                  ),
                  Row(
                    children: [
                      const Text("select class number"),
                      const SizedBox(
                        width: 11,
                      ),
                      DropdownButton<String>(
                          value: selectedClassItemsList,
                          items: classItemsList
                              .map((item) => DropdownMenuItem(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(fontSize: 18),
                                  )))
                              .toList(),
                          onChanged: (item) =>
                              setState(() => selectedClassItemsList = item)),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await onRegister();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(kPrimaryColor),
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(12)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            "Register",
                            style: TextStyle(fontSize: 19),
                          ),
                  ),
                  const SizedBox(
                    height: 33,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     const Text(" have an account?",
                  //         style: TextStyle(fontSize: 18)),
                  //     TextButton(
                  //         onPressed: () {
                  //           Navigator.pushReplacement(
                  //             context,
                  //             MaterialPageRoute(
                  //                 builder: (context) => const Login()),
                  //           );
                  //         },
                  //         child: const Text('sign in',
                  //             style: TextStyle(
                  //                 color: kPrimaryColor,
                  //                 fontSize: 18,
                  //                 decoration: TextDecoration.underline))),
                  //   ],
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
