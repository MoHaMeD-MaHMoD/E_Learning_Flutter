import 'package:dr_abdelhameed/constants/color.dart';
import 'package:dr_abdelhameed/screens/details_screen.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PdfORVideoWidget extends StatelessWidget {
  String subjectTybe;
  final String classNumber;
  PdfORVideoWidget(
      {required this.classNumber, required this.subjectTybe, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 3, 133, 194),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IntrinsicHeight(
                  child: Stack(
                    children: [
                      Align(
                        child: Text(' Materials',
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(color: Colors.white)),
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
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.width * .80,
                    child: ElevatedButton.icon(
                      icon: const Icon(
                        Icons.video_collection,
                        color: Colors.white,
                        size: 55,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailsScreen(
                                      dataType: 'Video',
                                      classNumber: classNumber,
                                      subjectTybe: subjectTybe,
                                    )));
                      },
                      label: const Text(
                        "Videos",
                        style: TextStyle(fontSize: 44, color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kpink,
                        fixedSize: const Size(208, 43),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.width * .80,
                    child: ElevatedButton.icon(
                      icon: const Icon(
                        Icons.file_open,
                        color: Colors.white,
                        size: 55,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailsScreen(
                                      dataType: 'PDF',
                                      subjectTybe: subjectTybe,
                                      classNumber: classNumber,
                                    )));
                      },
                      label: const Text(
                        "Files",
                        style: TextStyle(fontSize: 44, color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: korange,
                        fixedSize: const Size(208, 43),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
