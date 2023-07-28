import 'dart:io';
import 'dart:math';
import 'package:numberpicker/numberpicker.dart';
import 'package:path/path.dart' show basename;

import 'package:dr_abdelhameed/constants/color.dart';
import 'package:dr_abdelhameed/firebase%20services/fire_store.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class VideoSelector extends StatefulWidget {
  const VideoSelector({super.key});

  @override
  State<VideoSelector> createState() => _VideoSelectorState();
}

class _VideoSelectorState extends State<VideoSelector> {
  List<String> dataTypeItemsList = ['Video', 'PDF'];
  String? selecteddataTypeItemsList = 'Video';
  List<String> subjectItemsList = ['Physics', 'Chemistry', 'biology'];
  String? selectedSubjectItemsList = 'Physics';
  List<String> classItemsList = ['1', '2', '3'];
  String? selectedClassItemsList = '1';

  final desController = TextEditingController();
  bool isLoading = false;
  File? galleryFile;
  String? videoName;
  XFile? xfilePick;

  final picker = ImagePicker();
  int _currentValue = 3;

  @override
  void dispose() {
    desController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // display image selected from gallery
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery and Camera Access'),
        backgroundColor: kPrimaryColor,
        actions: const [],
      ),
      body: Builder(
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 32,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(kpink)),
                  child: const Text('Select a Lesson'),
                  onPressed: () {
                    _showPicker(context: context);
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                SizedBox(
                  child: galleryFile == null
                      ? const Center(child: Text('Sorry nothing selected!!'))
                      : const Center(
                          child: Text(
                          "Lesson Is ready to upLoad",
                          style: TextStyle(color: Colors.green),
                        )),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
                  child: TextField(
                    // controller: descriptionController,
                    maxLines: 1,
                    controller: desController,
                    decoration: const InputDecoration(
                        hintText: "write a caption...",
                        border: InputBorder.none),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                  child: Row(
                    children: [
                      const Text(
                        "Lesson Type",
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(
                        width: 11,
                      ),
                      DropdownButton<String>(
                          value: selecteddataTypeItemsList,
                          items: dataTypeItemsList
                              .map((item) => DropdownMenuItem(
                                  value: item,
                                  child: Text(item,
                                      style: const TextStyle(fontSize: 18))))
                              .toList(),
                          onChanged: (item) =>
                              setState(() => selecteddataTypeItemsList = item)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      (selecteddataTypeItemsList == dataTypeItemsList[0])
                          ? const Text('Video Duration in Min',
                              style: TextStyle(fontSize: 18))
                          : const Text('PDF Sheets Numbers',
                              style: TextStyle(fontSize: 18)),
                      NumberPicker(
                        itemWidth: 44,
                        axis: Axis.horizontal,
                        value: _currentValue,
                        minValue: 1,
                        maxValue: 100,
                        onChanged: (value) =>
                            setState(() => _currentValue = value),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                  child: Row(
                    children: [
                      const Text(
                        "Subject Type",
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(
                        width: 11,
                      ),
                      DropdownButton<String>(
                          value: selectedSubjectItemsList,
                          items: subjectItemsList
                              .map((item) => DropdownMenuItem(
                                  value: item,
                                  child: Text(item,
                                      style: const TextStyle(fontSize: 18))))
                              .toList(),
                          onChanged: (item) =>
                              setState(() => selectedSubjectItemsList = item)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Row(
                    children: [
                      const Text(
                        "Class Number",
                        style: TextStyle(fontSize: 18),
                      ),
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
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextButton(
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });

                        videoName = basename(galleryFile!.path);
                        int random = Random().nextInt(9999999);
                        videoName = "$random$videoName";

                        await FirestoreMethods().addLesson(
                            dataType: selecteddataTypeItemsList,
                            videoPath: galleryFile,
                            description: desController.text,
                            context: context,
                            videoName: videoName,
                            folderName: selecteddataTypeItemsList,
                            classNumber: selectedClassItemsList,
                            sybjectType: selectedSubjectItemsList,
                            duration: _currentValue);

                        setState(() {
                          desController.clear();
                          isLoading = false;
                        });
                      },
                      child: isLoading
                          ? const CircularProgressIndicator(
                              color: kPrimaryColor,
                            )
                          : const Text(
                              "Upload",
                              style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold),
                            )),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  void _showPicker({
    required BuildContext context,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () async{
                    final pickedFile = await picker.pickMedia();
                    xfilePick = pickedFile;
                    setState(
                      () {
                        if (xfilePick != null) {
                          galleryFile = File(pickedFile!.path);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              // is this context <<<
                              const SnackBar(
                                  content: Text('Nothing is selected')));
                        }
                      },
                    );
                  

                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  getVideo(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

 Future getVideo(
    ImageSource img,
  ) async {
    final pickedFile = await picker.pickVideo(
        source: img,
        preferredCameraDevice: CameraDevice.front,
        maxDuration: const Duration(minutes: 10));
    xfilePick = pickedFile;
    setState(
      () {
        if (xfilePick != null) {
          galleryFile = File(pickedFile!.path);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(// is this context <<<
              const SnackBar(content: Text('Nothing is selected')));
        }
      },
    );
  }
}

/*
  final pickedFile = await picker.pickVideo(
        source: img,
        preferredCameraDevice: CameraDevice.front,
        maxDuration: const Duration(minutes: 10));
*/
