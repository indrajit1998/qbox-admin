import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'bio_data.dart';

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
  bool isLoading = false;
  @override
  void initState() {
    setState(() {
      isLoading = true;
    });
    getData();
    super.initState();
    setState(() {
      isLoading = false;
    });
  }

  Map<String, dynamic> data = {};
  Map<String, dynamic> accountDetailsMap = {};
  Map<String, dynamic> infoToShowStudentMap = {};
 // Map<String, dynamic> biodataMap = {};
  getData() async {
    var userEmail = FirebaseAuth.instance.currentUser!.email;
    FirebaseFirestore.instance
        .collection('teachers')
        .doc(userEmail)
        .get()
        .then((value) {
      setState(() {
        data = value.data()!;
      });
    });
    FirebaseFirestore.instance
        .collection('teachers')
        .doc(userEmail)
        .collection("accountDetail")
        .get()
        .then((value) {
      setState(() {
        accountDetailsMap = value.docs[0].data();
      });
    });
    FirebaseFirestore.instance
        .collection('teachers')
        .doc(userEmail)
        .collection("informationToShowStudent")
        .get()
        .then((value) {
      setState(() {
        infoToShowStudentMap = value.docs[0].data();
      });
    });
    // FirebaseFirestore.instance
    //     .collection('teachers')
    //     .doc(userEmail)
    //     .collection("biodata")
    //     .get()
    //     .then((value) {
    //   setState(() {
    //     biodataMap = value.docs[0].data();
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      profile(context, data),
      accountDetails(context, accountDetailsMap),
      const BioData(),
      infoToShowStudent(context, infoToShowStudentMap),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teacher Profile'),
      ),
      body: isLoading
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

// Widget biodata(BuildContext context, Map<String, dynamic> data) {
//
//   return SingleChildScrollView(
//     child: Form(
//       child: Column(
//         children: [
//           Text(
//             "BIODATA",
//             style: TextStyle(
//               fontSize: MediaQuery.of(context).size.width / 80,
//             ),
//           ),
//            ListTile(
//               title: TextFormField(
//             decoration: InputDecoration(
//               border: OutlineInputBorder(),
//               label: Text('Teacher Name'),
//             ),
//           )),
//            ListTile(
//               title: TextFormField(
//             decoration: InputDecoration(
//               border: OutlineInputBorder(),
//               label: Text('Course Catogary'),
//             ),
//           )),
//            ListTile(
//               title: TextFormField(
//             decoration: InputDecoration(
//               border: OutlineInputBorder(),
//               label: Text('Teacher Name'),
//             ),
//           )),
//            ListTile(
//               title: TextFormField(
//             decoration: InputDecoration(
//               border: OutlineInputBorder(),
//               label: Text('Subject Based'),
//             ),
//           )),
//            ListTile(
//               title: TextFormField(
//             decoration: InputDecoration(
//               border: OutlineInputBorder(),
//               label: Text('Password'),
//             ),
//           )),
//            ListTile(
//               title: TextFormField(
//             decoration: InputDecoration(
//               border: OutlineInputBorder(),
//               label: Text('Email Address'),
//             ),
//           )),
//            ListTile(
//               title: TextFormField(
//             decoration: InputDecoration(
//               border: OutlineInputBorder(),
//               label: Text('Email OTP'),
//             ),
//           )),
//            ListTile(
//               title: TextFormField(
//             decoration: InputDecoration(
//               border: OutlineInputBorder(),
//               label: Text('Phone Number'),
//             ),
//           )),
//            ListTile(
//               title: TextFormField(
//             decoration: InputDecoration(
//               border: OutlineInputBorder(),
//               label: Text('Phone OTP'),
//             ),
//           )),
//            ListTile(
//               title: TextFormField(
//             decoration: InputDecoration(
//               border: OutlineInputBorder(),
//               label: Text('Address'),
//             ),
//           )),
//            ListTile(
//               title: TextFormField(
//             decoration: InputDecoration(
//               border: OutlineInputBorder(),
//               label: Text('Voter Card Number'),
//             ),
//           )),
//            ListTile(
//               title: TextFormField(
//             decoration: InputDecoration(
//               border: OutlineInputBorder(),
//               label: Text('Aadhar Card Number'),
//             ),
//           )),
//           const ListTile(
//               title: TextField(
//             decoration: InputDecoration(
//               border: OutlineInputBorder(),
//               label: Text('Bank Account Number'),
//             ),
//           )),
//            ListTile(
//               title: TextFormField(
//             decoration: InputDecoration(
//               border: OutlineInputBorder(),
//               label: Text('IFSC Code'),
//             ),
//           )),
//           ElevatedButton(onPressed: () {}, child: const Text("Edit")),
//         ],
//       ),
//     ),
//   );
// }

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
