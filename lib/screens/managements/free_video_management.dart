import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qbox_admin/models/free_videos_model.dart';
import 'package:qbox_admin/widgets/bottom_material_button.dart';
import 'package:qbox_admin/widgets/home_display_screen.dart';
import 'package:qbox_admin/widgets/pop_up_text_field.dart';

class FreeVideoManagement extends StatefulWidget {
  const FreeVideoManagement({Key? key}) : super(key: key);

  @override
  State<FreeVideoManagement> createState() => _FreeVideoManagementState();
}

class _FreeVideoManagementState extends State<FreeVideoManagement> {
  bool isUploaded = false;
  final _titleController = TextEditingController();
  final _categoryController = TextEditingController();
  final _courseController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _subjectController = TextEditingController();
  final _chapterController = TextEditingController();
  final GlobalKey<FormState> _freeVideoFormKey = GlobalKey<FormState>();
  final freeVideoRef = FirebaseStorage.instance.ref();
  late String imageFileName;
  late String videoFileName;
  double progress = 0.0;
  String? errorMessage;
  String? downloadURL;
  Future getData() async {
    try {
      await displayImg();
      return downloadURL;
    } catch (e) {
      print('not getData');
      return null;
    }
  }

  Future<void> displayImg() async {
    downloadURL = await FirebaseStorage.instance
        .ref()
        .child("/freeVideos/images")
        .getDownloadURL();
    print(downloadURL.toString());
  }

  Future uploadFile(String type) async {
    String metaDataString = "image";
    if (type == "videos") {
      metaDataString = "video";
    }
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      Uint8List? file = result.files.first.bytes;
      String fileName = result.files.first.name;
      UploadTask task = FirebaseStorage.instance
          .ref()
          .child("/freeVideos/$type/$fileName")
          .putData(
              file!,
              SettableMetadata(
                contentType: metaDataString,
              ));
      task.snapshotEvents.listen((event) {
        setState(() {
          progress = ((event.bytesTransferred.toDouble() /
                      event.totalBytes.toDouble()) *
                  100)
              .roundToDouble();
          if (progress <= 10) {
            event.ref.getDownloadURL().then((downloadUrl) {
              return Fluttertoast.showToast(
                webShowClose: true,
                msg: "$type   Loading..... ",
                toastLength: Toast.LENGTH_LONG,
                timeInSecForIosWeb: 7,
              );
            });
          } else if (progress == 100) {
            event.ref.getDownloadURL().then((downloadUrl) {
              if (type == 'images') {
                imageFileName = downloadUrl.toString();
              } else if (type == 'videos') {
                videoFileName = downloadUrl.toString();
                //  log('message');ss
              }
              return Fluttertoast.showToast(msg: "$type Added Successfully");
            });
          } else {
            const CircularProgressIndicator();
          }
        });
      });
    }
  }

  Map timeDifference(DateTime uploaded, DateTime now) {
    Map values = {};
    uploaded = DateTime(uploaded.year, uploaded.month, uploaded.day,
        uploaded.hour, uploaded.minute, uploaded.second);
    now = DateTime(
        now.year, now.month, now.day, now.hour, now.minute, now.second);
    if (now.difference(uploaded).inMinutes < 60) {
      values[''] = now.difference(uploaded).inMinutes;
      values[" "] = "min";
      return values;
    } else if (now.difference(uploaded).inHours < 24) {
      values[''] = now.difference(uploaded).inHours;
      values[" "] = "hours";
      return values;
    } else if (now.difference(uploaded).inDays < 365) {
      values[""] = now.difference(uploaded).inDays;
      values[" "] = "days";
      return values;
    }
    values[""] = (now.difference(uploaded).inDays / 365).round();
    values[" "] = "years";
    return values;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding:
            EdgeInsets.all(MediaQuery.of(context).size.width * (1 / 153.6)),
        child: Column(
          children: [
            Text(
              'Free Videos',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width / 32,
              ),
            ),
            const Divider(
              color: Colors.amberAccent,
            ),
            Expanded(
              child: Container(
                height: double.infinity,
                margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.width * (1 / 153.6),
                ),
                child: SingleChildScrollView(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('videos')
                          .where("uploadedTeacherEmail",
                              isEqualTo: FirebaseAuth
                                  .instance.currentUser!.email
                                  .toString())
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return const Text('Something went wrong!');
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        return Wrap(
                          // spacing: 20,
                          // runSpacing: 15,
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.start,
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                            Map<String, dynamic> data =
                                document.data()! as Map<String, dynamic>;
                            Map timeDifferenceValue = timeDifference(
                                DateTime.parse(data['uploadDate']),
                                DateTime.now());
                            return HomeDisplayScreen(
                              videoLink: data['videoLink'],
                              imageUrl: data['imageUrl'].toString(),
                              uploadDate: timeDifferenceValue,
                              title: data['title'],
                              likes: data['likes'],
                              category: data['category'],
                              chapter: data['chapter'],
                              subject: data['subject'],
                              description: data['description'],
                            );
                          }).toList(),
                        );
                      }),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: BottomMaterialButton(
                text: 'Add New Video',
                popUpChild: Form(
                  key: _freeVideoFormKey,
                  child: Wrap(
                    children: [
                      const Divider(
                        color: Colors.amber,
                      ),
                      PopUpTextField(
                        controller: _titleController,
                        hint: 'WEB DEVELOPMENT | PART-1 ',
                        label: 'Title',
                        widthRatio: 2,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Field cannot be empty");
                          }
                          return null;
                        },
                      ),
                      PopUpTextField(
                          controller: _categoryController,
                          hint: 'Web',
                          label: 'Category',
                          widthRatio: 1),
                      PopUpTextField(
                          controller: _courseController,
                          hint: 'HTML',
                          label: 'Course Name',
                          widthRatio: 1),
                      PopUpTextField(
                          controller: _chapterController,
                          hint: 'Chapter',
                          label: 'Chapter',
                          widthRatio: 1),
                      PopUpTextField(
                          controller: _subjectController,
                          hint: 'Subject',
                          label: 'Subject',
                          widthRatio: 1),
                      PopUpTextField(
                        controller: _descriptionController,
                        hint: 'Description ',
                        label: 'Description',
                        widthRatio: 3,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Field cannot be empty");
                          }
                          return null;
                        },
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.height *
                                (20 / 792)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Material(
                              type: MaterialType.button,
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(50),
                              child: MaterialButton(
                                padding: const EdgeInsets.all(20),
                                onPressed: () async {
                                  await uploadFile('images');
                                },
                                child: const Text('Pick Image'),
                              ),
                            ),
                            Material(
                              type: MaterialType.button,
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(50),
                              child: MaterialButton(
                                padding: const EdgeInsets.all(20),
                                onPressed: () async {
                                  await uploadFile('videos');
                                },
                                child: Text('Pick Video'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      LinearProgressIndicator(
                        value: progress / 100,
                      ),
                    ],
                  ),
                ),
                popUpactions: [
                  Material(
                    color: Colors.amberAccent,
                    elevation: 4,
                    type: MaterialType.button,
                    child: MaterialButton(
                        onPressed: () async {
                          if (_freeVideoFormKey.currentState!.validate() &&
                              imageFileName.isNotEmpty &&
                              videoFileName.isNotEmpty) {
                            try {
                              DateTime currentTime = DateTime.now();
                              await FirebaseFirestore.instance
                                  .collection('videos')
                                  .doc()
                                  .set(FreeVideoModel(
                                    title: _titleController.text.trim(),
                                    category: _categoryController.text.trim(),
                                    course: _courseController.text.trim(),
                                    description:
                                        _descriptionController.text.trim(),
                                    chapter: _chapterController.text.trim(),
                                    subject: _subjectController.text.trim(),
                                    likes: 20,
                                    comment: 300,
                                    download: 500,
                                    imageUrl: imageFileName,
                                    videoLink: videoFileName,
                                    uploadDate: currentTime.toString(),
                                    uploadedTeacherEmail: FirebaseAuth
                                        .instance.currentUser!.email
                                        .toString(),
                                  ).toJson())
                                  .then((value) {
                                setState(() {
                                  isUploaded = false;
                                });
                              }).catchError((error) =>
                                      print("Failed to add Video: $error"));
                            } on FirebaseAuthException catch (error) {
                              const Center(child: CircularProgressIndicator());

                              setState(() {
                                isUploaded == false;
                              });
                              switch (error.code) {
                                default:
                                  errorMessage =
                                      "An undefined Error happened.+$error";
                              }

                              Fluttertoast.showToast(msg: errorMessage!);
                            }
                            Fluttertoast.showToast(
                                msg: "Free Video Added Successfully");
                            if (!mounted) {
                              return;
                            }
                            Navigator.of(context, rootNavigator: true).pop();
                          }
                        },
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width / 76.8),
                        child: Text(
                          'Add Video',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width / 86,
                            color: Colors.black,
                          ),
                        )),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
