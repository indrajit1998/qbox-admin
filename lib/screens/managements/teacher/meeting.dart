import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qbox_admin/widgets/bottom_material_button.dart';

import '../../../widgets/pop_up_text_field.dart';

class StudentTeacherMeeting extends StatefulWidget {
  const StudentTeacherMeeting({Key? key}) : super(key: key);

  @override
  State<StudentTeacherMeeting> createState() => _StudentTeacherMeetingState();
}

class _StudentTeacherMeetingState extends State<StudentTeacherMeeting> {
  TextEditingController linkController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  @override
  void initState() {
    getEmail();
    super.initState();
  }

  String email = "";
  getEmail() async {
    setState(() {
      email = FirebaseAuth.instance.currentUser!.email!;
    });
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
                'Parents Teacher Meeting',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 32,
                ),
              ),
              const Divider(
                color: Colors.amberAccent,
              ),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("teachers")
                      .doc(email)
                      .collection('meetings')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                        Map<String, dynamic> data = snapshot.data!.docs[0].data() as Map<String, dynamic>;
                    return snapshot.hasData
                        ? ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(data['title']),
                              subtitle: Text(data['description']),
                              trailing: Text(data['date']),
                            );
                          }, itemCount: snapshot.data!.docs.length,)
                        : const Center(
                            child:  CircularProgressIndicator(),
                          );
                  }),
                  const Spacer(),
              BottomMaterialButton(
                text: 'Add Meeting',
                popUpChild: Column(children: [
                  PopUpTextField(
                    controller: titleController,
                    hint: 'Enter title',
                    label: 'Enter title',
                    widthRatio: 1,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("Field cannot be empty");
                      }
                      return null;
                    },
                  ),
                  PopUpTextField(
                    controller: descriptionController,
                    hint: 'Enter Description',
                    label: 'Enter Description',
                    widthRatio: 1,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("Field cannot be empty");
                      }
                      return null;
                    },
                  ),
                  PopUpTextField(
                    controller: linkController,
                    hint: 'Enter Link',
                    label: 'Enter Link',
                    widthRatio: 1,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("Field cannot be empty");
                      }
                      return null;
                    },
                  ),
                  Text("Time: ${dateController.text}"),
                ]),
                popUpactions: [
                  Material(
                    type: MaterialType.button,
                    color: Colors.amberAccent,
                    child: MaterialButton(
                      onPressed: setStartTime,
                      child: const Text('Set Date'),
                    ),
                  ),
                  Material(
                    type: MaterialType.button,
                    color: Colors.amberAccent,
                    child: MaterialButton(
                      onPressed: (() {
                        if (titleController.text.isNotEmpty &&
                            descriptionController.text.isNotEmpty &&
                            linkController.text.isNotEmpty &&
                            dateController.text.isNotEmpty) {
                          FirebaseFirestore.instance
                              .collection('teachers')
                              .doc(email)
                              .collection('meetings')
                              .doc()
                              .set({
                            'title': titleController.text,
                            'description': descriptionController.text,
                            'link': linkController.text,
                            'date': dateController.text,
                            'email': email,
                          });
                          Fluttertoast.showToast(
                              msg: 'Meeting Added',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.amberAccent,
                              textColor: Colors.black);
                          Navigator.pop(context);
                        } else {
                          Fluttertoast.showToast(
                              msg: 'Please fill all fields',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.amberAccent,
                              textColor: Colors.black);
                        }
                      }),
                      child: const Text('Add Meeting'),
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }

  setStartTime() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        dateController.text = picked.toString();
      });
    } else {
      Fluttertoast.showToast(msg: "Date is not selected");
    }
  }
}
