import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TeacherSideCoursePage extends StatefulWidget {
  const TeacherSideCoursePage({Key? key}) : super(key: key);

  @override
  State<TeacherSideCoursePage> createState() => _TeacherSideCoursePageState();
}

class _TeacherSideCoursePageState extends State<TeacherSideCoursePage> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  List<Map<String, dynamic>> data = [];

  List courses = [];
  List cid = [];
  getData() async {
    var email = FirebaseAuth.instance.currentUser!.email;

    FirebaseFirestore.instance
        .collection('batches')
        .where('teachers', arrayContains: "teachers/$email")
        .get()
        .then((value) {
      for (var i = 0; i < value.size; i++) {
        setState(() {
          data.add(value.docs[i].data());
        });
      }
    });
  }

  cleanData() async {
    for (var i = 0; i < data.length; i++) {
      setState(() {
        courses.add(data[i]['courseName']);
        cid.add(data[i]['cid']);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    cleanData();
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Assigned Courses',
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width / 32,
            ),
          ),
          const Divider(
            color: Colors.amberAccent,
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: courses.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(courses[index]),
                subtitle: SelectableText(cid[index]),
              );
            },
          ),
        ],
      ),
    ));
  }
}
