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

  List<Map<String, dynamic>> data = [];
  List subjects = [];
  List batches = [];
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

  List keys = [];
  List values = [];
  cleanData() async {
    for (var i = 0; i < data.length; i++) {
      setState(() {
        subjects.add(data[i]['subjects']);
        batches.add(data[i]['batchName']);
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
            'Assigned Batches',
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width / 32,
            ),
          ),
          const Divider(
            color: Colors.amberAccent,
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: subjects.length,
            itemBuilder: (context, index) {
              return ListTile(
                  title: Text(batches[index]),
                  subtitle: Text(subjects[index]
                      .toString()
                      .replaceAll("[", "")
                      .replaceAll("]", "")));
            },
          ),
        ],
      ),
    ));
  }
}
