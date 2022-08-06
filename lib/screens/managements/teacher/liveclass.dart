import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:qbox_admin/models/live_video_model.dart';
import 'package:qbox_admin/screens/golive/golive.dart';
import 'package:qbox_admin/widgets/bottom_material_button.dart';
import 'package:qbox_admin/widgets/pop_up_text_field.dart';

class TeacherSideLiveClassPage extends StatefulWidget {
  const TeacherSideLiveClassPage({Key? key}) : super(key: key);

  @override
  State<TeacherSideLiveClassPage> createState() =>
      _TeacherSideLiveClassPageState();
}

class _TeacherSideLiveClassPageState extends State<TeacherSideLiveClassPage> {
  final _titleController = TextEditingController();
  final _categoryController = TextEditingController();
  final _courseController = TextEditingController();
  final _cidController = TextEditingController();
  final _chapterController = TextEditingController();
  final _scheduleDateController = TextEditingController();
  final _endDateController = TextEditingController();
  final GlobalKey<FormState> _liveVideoFormKey = GlobalKey<FormState>();
  final freeVideoRef = FirebaseStorage.instance.ref();
  late String videoFileName;
  double progress = 0.0;
  String? errorMessage;
  @override
  void initState() {
    getUserEmail();
    super.initState();
  }

  String userEmail = "";
  getUserEmail() async {
    User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      userEmail = user!.email!;
    });
  }

  setStartTime() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        String newDate = f.format(picked);
        print(newDate);
        setState(() {
          _scheduleDateController.text =
              "$newDate ${pickedTime.hour}:${pickedTime.minute}:00";
        });
      } else {
        Fluttertoast.showToast(msg: "Date & Time not selected is not selected");
      }
    }
  }

  var f = DateFormat('yyyy-MM-dd');
  setEndTime() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        setState(() {
          String newDate = f.format(picked);
          print(newDate);
          _endDateController.text =
              "$newDate ${pickedTime.hour}:${pickedTime.minute}:00";
        });
      } else {
        Fluttertoast.showToast(msg: "Date & Time not selected is not selected");
      }
    }
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
              'Live Videos',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width / 32,
              ),
            ),
            const Divider(
              color: Colors.amberAccent,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.width * (1 / 153.6),
                ),
                child: ListView(
                  padding: EdgeInsets.all(
                      MediaQuery.of(context).size.width * (1 / 153.6)),
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          bottom:
                              MediaQuery.of(context).size.width * (1 / 153.6)),
                      child: ExpansionTile(
                        backgroundColor: Colors.white,
                        title: const Text('Upcoming'),
                        children: [
                          Divider(
                            color: Theme.of(context).primaryColor,
                          ),
                          SingleChildScrollView(
                            child: StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('liveVideos')
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
                                  return snapshot.hasData
                                      ? ListView(
                                          shrinkWrap: true,
                                          physics:
                                              const ClampingScrollPhysics(),
                                          children: snapshot.data!.docs
                                              .map((DocumentSnapshot document) {
                                            Map<String, dynamic> data =
                                                document.data()!
                                                    as Map<String, dynamic>;
                                            DateTime endTime =
                                                DateTime.parse(data['endDate']);
                                            DateTime now = DateTime.now();
                                            if (DateTime(
                                                        endTime.year,
                                                        endTime.month,
                                                        endTime.day,
                                                        endTime.hour,
                                                        endTime.minute,
                                                        endTime.second)
                                                    .difference(DateTime(
                                                        now.year,
                                                        now.month,
                                                        now.day,
                                                        now.hour,
                                                        now.second))
                                                    .inSeconds >=
                                                0) {
                                              return ListTile(
                                                title: ListTile(
                                                  title: Text(data['title']),
                                                  subtitle: Row(
                                                    children: [
                                                      Text(
                                                          'category : ${data['category']} - course : ${data['course']}')
                                                    ],
                                                  ),
                                                  trailing: Text(
                                                      'Schedule Date : ${data['scheduleDate']}'),
                                                ),
                                                leading: IconButton(
                                                  onPressed: () {
                                                    var collection =
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'liveVideos');
                                                    collection
                                                        .doc(document.id)
                                                        .update({'live': true})
                                                        .then((_) =>
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            JoinMeeting(
                                                                              nameText: userEmail,
                                                                              roomText: document.id,
                                                                              subjectText: data['course'],
                                                                            ))))
                                                        .catchError((error) =>
                                                            print(
                                                                'Failed: $error'));
                                                  },
                                                  icon: const Icon(Icons
                                                      .play_circle_outline_rounded),
                                                ),
                                                // trailing: MaterialButton(
                                                //   color: Colors.amber,
                                                //   onPressed: () {},
                                                //   child: const Text('Edit'),
                                                // ),
                                              );
                                            } else {
                                              return Container();
                                            }
                                          }).toList(),
                                        )
                                      : const Center(
                                          child: Text('No Live Videos'),
                                        );
                                }),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          bottom:
                              MediaQuery.of(context).size.width * (1 / 153.6)),
                      child: ExpansionTile(
                        backgroundColor: Colors.white,
                        title: const Text('Completed'),
                        children: [
                          Divider(
                            color: Theme.of(context).primaryColor,
                          ),
                          SingleChildScrollView(
                            child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('liveVideos')
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
                                return ListView(
                                  shrinkWrap: true,
                                  physics: const ClampingScrollPhysics(),
                                  children: snapshot.data!.docs
                                      .map((DocumentSnapshot document) {
                                    Map<String, dynamic> data = document.data()!
                                        as Map<String, dynamic>;
                                    DateTime endTime =
                                        DateTime.parse(data['endDate']);
                                    DateTime now = DateTime.now();
                                    if (DateTime(
                                                endTime.year,
                                                endTime.month,
                                                endTime.day,
                                                endTime.hour,
                                                endTime.minute,
                                                endTime.second)
                                            .difference(DateTime(
                                                now.year,
                                                now.month,
                                                now.day,
                                                now.hour,
                                                now.second))
                                            .inSeconds <
                                        0) {
                                      return ListTile(
                                        title: ListTile(
                                          title: Text(data['title']),
                                          subtitle: Row(
                                            children: [
                                              Text(
                                                  'category : ${data['category']} - course : ${data['course']}')
                                            ],
                                          ),
                                          trailing: Text(
                                              'Schedule Date : ${data['scheduleDate']}'),
                                        ),
                                      );
                                    } else {
                                      return Container();
                                    }
                                  }).toList(),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: BottomMaterialButton(
                text: 'Schedule Video',
                popUpChild: Form(
                  key: _liveVideoFormKey,
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
                        widthRatio: 1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Field cannot be empty");
                          }
                          return null;
                        },
                      ),
                      PopUpTextField(
                        controller: _courseController,
                        hint: 'WEB DEVELOPMENT',
                        label: 'Course Name',
                        widthRatio: 1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Field cannot be empty");
                          }
                          return null;
                        },
                      ),
                      PopUpTextField(
                        controller: _cidController,
                        hint: 'Enter the COURSE ID',
                        label: 'CID',
                        widthRatio: 1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Field cannot be empty");
                          }
                          return null;
                        },
                      ),
                      PopUpTextField(
                        controller: _chapterController,
                        hint: 'Chapter Name',
                        label: 'Chapter',
                        widthRatio: 1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Field cannot be empty");
                          }
                          return null;
                        },
                      ),
                      PopUpTextField(
                        controller: _scheduleDateController,
                        hint: 'YYYY-MM-DD hh:mm:ss',
                        label: 'Schedule Date & Time',
                        widthRatio: 1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Field cannot be empty");
                          }
                          return null;
                        },
                      ),
                      PopUpTextField(
                        controller: _endDateController,
                        hint: 'YYYY-MM-DD hh:mm:ss',
                        label: 'Excepted End Date&Time',
                        widthRatio: 1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Field cannot be empty");
                          }
                          return null;
                        },
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
                      onPressed: setStartTime,
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.width / 76.8),
                      child: Text(
                        'Start Time',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 86,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.amberAccent,
                    elevation: 4,
                    type: MaterialType.button,
                    child: MaterialButton(
                      onPressed: setEndTime,
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.width / 76.8),
                      child: Text(
                        'End Time',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 86,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.amberAccent,
                    elevation: 4,
                    type: MaterialType.button,
                    child: MaterialButton(
                      onPressed: () async {
                        if (_liveVideoFormKey.currentState!.validate()) {
                          try {
                            await FirebaseFirestore.instance
                                .collection('liveVideos')
                                .doc()
                                .set(LiveVideoModel(
                                        title: _titleController.text.trim(),
                                        category:
                                            _categoryController.text.trim(),
                                        course: _courseController.text.trim(),
                                        cid: _cidController.text.trim(),
                                        scheduleDate:
                                            _scheduleDateController.text.trim(),
                                        endDate: _endDateController.text.trim(),
                                        chapter: _chapterController.text.trim(),
                                        isLive: false)
                                    .toJson())
                                .then((value) => print("Video Added"))
                                .catchError((error) =>
                                    print("Failed to add Video: $error"));
                          } on FirebaseAuthException catch (error) {
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
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
