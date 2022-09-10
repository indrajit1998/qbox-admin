import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'bio_data.dart';
import 'package:qbox_admin/screens/auth/sign_in.dart';


class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  List<String> teacherProfile = [
    'Profile',
    'Account Details',
    'Biodata',
    'Information show to student'
  ];
  int pageIndex = 0;
  List pages=[];
  bool _isLoading = false;
  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    getData();
    Future.delayed(const Duration(seconds:2), () {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  Map<String, dynamic> data = {};
  Map<String, dynamic> accountDetailsMap = {};
  Map<String, dynamic> infoToShowStudentMap = {};

  void getPagesList() {
    pages = [
      profile(context, data),
      accountDetails(context, accountDetailsMap),
      BioData(),
      infoToShowStudent(context, infoToShowStudentMap),
    ];
  }

  Future<void> getData() async {
    var userEmail = FirebaseAuth.instance.currentUser!.email;
   await FirebaseFirestore.instance
        .collection('teachers')
        .doc(userEmail)
        .get()
        .then((value) {
      setState(() {
        data = value.data()!;
     });
    });
   await FirebaseFirestore.instance
        .collection('teachers')
        .doc(userEmail)
        .collection("accountDetail")
        .get()
        .then((value) {
      setState(() {
        accountDetailsMap = value.docs[0].data();
     });
    });
   await FirebaseFirestore.instance
        .collection('teachers')
        .doc(userEmail)
        .collection("informationToShowStudent")
        .get()
        .then((value) {
      setState(() {
        infoToShowStudentMap = value.docs[0].data();
      });
    }).then((value){
       getPagesList();
    });
  }

  void _logout(BuildContext context)async{
    Navigator.of(context).pushReplacementNamed(SignIn.routeName);
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Teacher Profile'),
        actions: [ ElevatedButton(
          onPressed: ()=>_logout(context),
          child: Text('Log Out'),
        ),]
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Row(
              children: [
                Expanded(
                    child: Container(
                  color: Colors.grey[200],
                  child: ListView.builder(
                      itemBuilder: ((context, index) {
                        return Container(
                          padding: const EdgeInsets.all(8),
                          margin: const EdgeInsets.only(bottom: 8),
                          color: Colors.grey[400],
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.blue,
                              child: Text(
                                teacherProfile[index][0].toUpperCase(),
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width / 70,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                pageIndex = index;
                              });
                            },
                            title: Text(
                              teacherProfile[index],
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width / 90,
                              ),
                            ),
                          ),
                        );
                      }),
                      itemCount: teacherProfile.length),
                )),
                Expanded(flex: 5, child: pages[pageIndex]),
              ],
            ),
    );
  }
}

Widget infoToShowStudent(BuildContext context, Map<String, dynamic> data) {
  return Column(
    children: [
      ListTile(
        title: Text(
          'Achivements:',
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width / 90,
          ),
        ),
        subtitle: Text(
          data['achivement'],
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width / 90,
          ),
        ),
      ),
      ListTile(
        title: Text(
          'Message To Student:',
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width / 90,
          ),
        ),
        subtitle: Text(
          data['messageToStudent'],
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width / 90,
          ),
        ),
      ),
      ListTile(
        title: Text(
          'Experience:',
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width / 90,
          ),
        ),
        subtitle: Text(
          data['experience'],
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width / 90,
          ),
        ),
      ),
      ListTile(
        title: Text(
          'Name:',
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width / 90,
          ),
        ),
        subtitle: Text(
          data['name'],
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width / 90,
          ),
        ),
      ),
      ListTile(
        title: Text(
          'Qualifications:',
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width / 90,
          ),
        ),
        subtitle: Text(
          data['qualification'],
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width / 90,
          ),
        ),
      ),
      ListTile(
        title: Text(
          'Working Since:',
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width / 90,
          ),
        ),
        subtitle: Text(
          data['sinceWorking'],
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width / 90,
          ),
        ),
      ),
      ListTile(
        title: Text(
          'Subjects Expertise:',
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width / 90,
          ),
        ),
        subtitle: Text(
          data['subjectExpertise']
              .toString()
              .replaceAll("[", "")
              .replaceAll("]", ""),
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width / 90,
          ),
        ),
      ),
      ListTile(
        title: Text(
          'Teaching Language:',
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width / 90,
          ),
        ),
        subtitle: Text(
          data['teachingLanguage']
              .toString()
              .replaceAll("[", "")
              .replaceAll("]", ""),
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width / 90,
          ),
        ),
      ),
    ],
  );
}

Widget accountDetails(BuildContext context, Map<String, dynamic> data) {
  return Column(
    children: [
      ListTile(
        title: Text(
          'Name:',
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width / 90,
          ),
        ),
        subtitle: Text(
          data['name'],
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width / 90,
          ),
        ),
      ),
      ListTile(
        title: Text(
          'Course Category:',
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width / 90,
          ),
        ),
        subtitle: Text(
          "${data['catCourse'].toString().split("@")[0].replaceFirst("[", "")} >> ${data['catCourse'].toString().split("@")[1].replaceAll("]", "")}",
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width / 90,
          ),
        ),
      ),
      ListTile(
        title: Text(
          'Subject:',
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width / 90,
          ),
        ),
        subtitle: Text(
          data['subjects'].toString().replaceAll("[", "").replaceAll("]", ""),
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width / 90,
          ),
        ),
      ),
      ListTile(
        title: Text(
          'Username:',
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width / 90,
          ),
        ),
        subtitle: Text(
          data['userName'],
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width / 90,
          ),
        ),
      ),
      ListTile(
        title: Text(
          'Password:',
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width / 90,
          ),
        ),
        subtitle: Text(
          data['password'],
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width / 90,
          ),
        ),
      ),
    ],
  );
}

Widget profile(BuildContext context, Map<String, dynamic> data) {
  return Column(
    children: [
      ListTile(
        title: Text(
          'First Name:',
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width / 90,
          ),
        ),
        subtitle: Text(
          data['firstName'],
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width / 90,
          ),
        ),
      ),
      ListTile(
        title: Text(
          'Last Name:',
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width / 90,
          ),
        ),
        subtitle: Text(
          data['lastName'],
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width / 90,
          ),
        ),
      ),
      ListTile(
        title: Text(
          'Phone Number:',
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width / 90,
          ),
        ),
        subtitle: Text(
          data['phoneNumber'].toString(),
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width / 90,
          ),
        ),
      ),
      ListTile(
        title: Text(
          'Email:',
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width / 90,
          ),
        ),
        subtitle: Text(
          data['email'],
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width / 90,
          ),
        ),
      ),
    ],
  );
}
