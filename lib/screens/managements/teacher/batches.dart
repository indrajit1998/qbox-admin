import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TeacherSideBatchePage extends StatefulWidget {
  const TeacherSideBatchePage({Key? key}) : super(key: key);

  @override
  State<TeacherSideBatchePage> createState() => _TeacherSideBatchePageState();
}

class _TeacherSideBatchePageState extends State<TeacherSideBatchePage> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  List _teacherAdded = [];
  Map<String, dynamic> batchesData = {};
  getData() async {
    FirebaseFirestore.instance.collection('batches').get().then((value) {
      for (var element in value.docs) {
        Map<String, dynamic> data = element.data();
        setState(() {
          batchesData = data;
        });

        data['teachers']?.forEach((element) {
          setState(() {
            _teacherAdded.add(element);
          });
        });
      }
    });
  }

  String batchName = "";
  String courseName = "";
  List subjects = [];

  DocumentReference? reference;
  searchTeacherName() async {
    var email = FirebaseAuth.instance.currentUser!.email;
    for (var element in _teacherAdded) {
      element.get().then((value) {
        Map<String, dynamic> data = value.data();
        if (data['email'] == email) {
          setState(() {
            batchName = batchesData['batchName'];
            courseName = batchesData['courseName'];
            subjects = batchesData['subjects'];
            print(batchesData['subjects'].toString());
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    searchTeacherName();
    print(subjects);
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Assigned Subjects',
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width / 32,
          ),
        ),
        const Divider(
          color: Colors.amberAccent,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 1.2,
          child: ListView.builder(
            itemCount: subjects.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(subjects[index]),
              );
            },
          ),
        ),
      ],
    ));
  }
}
