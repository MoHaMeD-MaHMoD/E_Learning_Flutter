import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_abdelhameed/firebase%20services/auth.dart';
import 'package:flutter/material.dart';

class AllUser extends StatefulWidget {
  const AllUser({super.key});

  @override
  State<AllUser> createState() => _AllUserState();
}

class _AllUserState extends State<AllUser> {
  showmodel({required docsss,required contextt}) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          children: [
            SimpleDialogOption(
              onPressed: () async {
                
          AuthUser()
                          .deleteUser(docss: docsss, context: contextt, );
                Navigator.of(context).pop();
              },
              padding: const EdgeInsets.all(20),
              child: const Text(
                "are you sure ✋",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            SimpleDialogOption(
              onPressed: () async {
                Navigator.of(context).pop();
              },
              padding: const EdgeInsets.all(20),
              child: const Text(
                "Cancel",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }


          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return ListTile(
                leading: IconButton(
                    onPressed: () {
                      showmodel(docsss: data['uid'], contextt: context);
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    )),
                title: Text(data['user_name']),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${data['email']}'),
                    Text('password ${data['passwoed']}'),
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}




/*
 FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('users')
          .get(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return Expanded(
            child: Padding(
              padding: widthScreen > 600
                  ? const EdgeInsets.all(66.0)
                  : const EdgeInsets.all(3.0),
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 1,
                      mainAxisSpacing: 1),
                  itemCount: 2,
                  itemBuilder: (BuildContext context, int index) {
                    return Text("ahmed");
                  }),
            ),
          );
        }

        return const CircularProgressIndicator(
          color: Colors.white,
        );
      },
    ),
*/