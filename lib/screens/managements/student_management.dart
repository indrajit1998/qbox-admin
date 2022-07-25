import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class StudentManagement extends StatefulWidget {
  const StudentManagement({Key? key}) : super(key: key);

  @override
  State<StudentManagement> createState() => _StudentManagementState();
}

class _StudentManagementState extends State<StudentManagement> {
  int i = 1;

  // Future<String> getUserImagePath(String userEmail, String fileName) async {
  //   final userRef = FirebaseStorage.instance.ref();
  //   String urlPath = 'users/$userEmail/UserProfile/$fileName';
  //   final userProfileUrl = await userRef.child(urlPath).getDownloadURL();
  //   return userProfileUrl == Null ? '' : userProfileUrl;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding:
            EdgeInsets.all(MediaQuery.of(context).size.width * (1 / 153.6)),
        child: Column(
          children: [
            Text(
              'Students',
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
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('users')
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
                              Map<String, dynamic> data =
                                  document.data()! as Map<String, dynamic>;

                              return ListTile(
                                  leading: Text('${i++}'),
                                  title: Text(data['firstName'] +
                                      ' ' +
                                      data['lastName']),
                                  subtitle: Text(
                                    data['email'],
                                  ),
                                  trailing: FutureBuilder(
                                    // future: getUserImagePath(data['email'],
                                    //     data['profileImageName']),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasError) {
                                        print(
                                            'Something went wrong!+ ${snapshot.error}');
                                        return const Icon(
                                          Icons.person,
                                        );
                                      }
                                      if (snapshot.connectionState ==
                                              ConnectionState.done &&
                                          snapshot.hasData) {
                                        return CircleAvatar(
                                          backgroundImage: NetworkImage(
                                            snapshot.data.toString(),
                                          ),
                                        );
                                      }
                                      return const Icon(
                                        Icons.person,
                                      );
                                    },
                                  ));
                            }).toList(),
                          );
                        }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
