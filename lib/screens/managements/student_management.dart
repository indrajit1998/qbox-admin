import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

// class StudentManagement extends StatefulWidget {
//   const StudentManagement({Key? key}) : super(key: key);
//
//   @override
//   State<StudentManagement> createState() => _StudentManagementState();
// }
//
// class _StudentManagementState extends State<StudentManagement> {
//   int i = 1;
//
//   // Future<String> getUserImagePath(String userEmail, String fileName) async {
//   //   final userRef = FirebaseStorage.instance.ref();
//   //   String urlPath = 'users/$userEmail/UserProfile/$fileName';
//   //   final userProfileUrl = await userRef.child(urlPath).getDownloadURL();
//   //   return userProfileUrl == Null ? '' : userProfileUrl;
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         padding:
//             EdgeInsets.all(MediaQuery.of(context).size.width * (1 / 153.6)),
//         child: Column(
//           children: [
//             Text(
//               'Students',
//               style: TextStyle(
//                 fontSize: MediaQuery.of(context).size.width / 32,
//               ),
//             ),
//             const Divider(
//               color: Colors.amberAccent,
//             ),
//             Expanded(
//               child: Container(
//                 width: double.infinity,
//                 height: double.infinity,
//                 margin: EdgeInsets.only(
//                   bottom: MediaQuery.of(context).size.width * (1 / 153.6),
//                 ),
//                 child: ListView(
//                   padding: EdgeInsets.all(
//                       MediaQuery.of(context).size.width * (1 / 153.6)),
//                   children: [
//                     StreamBuilder(
//                         stream: FirebaseFirestore.instance
//                             .collection('users')
//                             .snapshots(),
//                         builder: (BuildContext context,
//                             AsyncSnapshot<QuerySnapshot> snapshot) {
//                           if (snapshot.hasError) {
//                             return const Text('Something went wrong!');
//                           }
//                           if (snapshot.connectionState ==
//                               ConnectionState.waiting) {
//                             return const Center(
//                                 child: CircularProgressIndicator());
//                           }
//                           return ListView(
//                             shrinkWrap: true,
//                             physics: const ClampingScrollPhysics(),
//                             children: snapshot.data!.docs
//                                 .map((DocumentSnapshot document) {
//                               Map<String, dynamic> data =
//                                   document.data()! as Map<String, dynamic>;
//
//                               return ListTile(
//                                   leading: Text('${i++}'),
//                                   title: Text(data['firstName'] +
//                                       ' ' +
//                                       data['phone']),
//                                   // subtitle: Text(
//                                   //   data['email'],
//                                   // ),
//                                   subtitle: Column(children: [...data['selectedCourse'].map((e)=>Text('${e['courseName']}')).toList()],),
//                                   trailing: FutureBuilder(
//                                     // future: getUserImagePath(data['email'],
//                                     //     data['profileImageName']),
//                                     builder: (context, snapshot) {
//                                       if (snapshot.hasError) {
//                                         print(
//                                             'Something went wrong!+ ${snapshot.error}');
//                                         return const Icon(
//                                           Icons.person,
//                                         );
//                                       }
//                                       if (snapshot.connectionState ==
//                                               ConnectionState.done &&
//                                           snapshot.hasData) {
//                                         return CircleAvatar(
//                                           backgroundImage: NetworkImage(
//                                             snapshot.data.toString(),
//                                           ),
//                                         );
//                                       }
//                                       return const Icon(
//                                         Icons.person,
//                                       );
//                                     },
//                                   ));
//                             }).toList(),
//                           );
//                         }),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class StudentManagement extends StatefulWidget {
  const StudentManagement({Key? key}) : super(key: key);

  @override
  State<StudentManagement> createState() => _StudentManagementState();
}

class _StudentManagementState extends State<StudentManagement> {
  //TextEditingController _fromDateController = TextEditingController();
  //TextEditingController _toDateController = TextEditingController();
  DateTime? _startDate;
  DateTime? _toDate;

  //   Future<String> getUserImagePath(String userEmail, String fileName) async {
  //   final userRef = FirebaseStorage.instance.ref();
  //   String urlPath = 'users/$userEmail/UserProfile/$fileName';
  //   final userProfileUrl = await userRef.child(urlPath).getDownloadURL();
  //   return userProfileUrl == Null ? '' : userProfileUrl;
  // }

  void _presentDatePicker(String isStart) {

    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: isStart=='start'?DateTime(2000):_startDate!,  //Add check that toDate always after startDate
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        isStart == 'start' ? _startDate = pickedDate : _toDate = pickedDate;
      });
    });
  }

  Widget getTableList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,

      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('users').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something is wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData) {
              return SingleChildScrollView(
                primary: false,
                child: Theme(
                  data: Theme.of(context).copyWith(dividerColor: Colors.white),
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('Image')),
                      DataColumn(
                        label: Text('Name'),
                      ),
                      DataColumn(
                        label: Text('Email'),
                      ),
                      DataColumn(
                        label: Text('Number'),
                      ),
                      DataColumn(
                        label: Text('SignUp Date'),
                      ),
                      DataColumn(
                        label: Text('Course'),
                      ),
                    ],
                    rows: snapshot.data!.docs
                        .map((rowData) => DataRow(
                                color: MaterialStateColor.resolveWith(
                                    (states) => Colors.black12),
                                cells: <DataCell>[
                                  DataCell(FutureBuilder(
                                    //  future: getUserImagePath(data['email'],
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
                                  )),
                                  DataCell(Text(
                                      '${rowData['firstName']} ${rowData['lastName']}')),
                                  DataCell(Text(rowData['email'])),
                                  DataCell(Text(rowData['phone'])),
                                  DataCell(Text(rowData['dateOfJoin'])),
                                  DataCell(
                                    SingleChildScrollView(
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ...rowData['selectedCourse']
                                                .map((e) =>
                                                    Text('${e['courseName']}'))
                                                .toList(),
                                          ]),
                                    ),
                                    placeholder: true,
                                  )
                                ]))
                        .toList(),
                  ),
                ),
              );
            }
            return const Text('No Student data');
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        padding:
            EdgeInsets.all(MediaQuery.of(context).size.width * (1 / 152.6)),
        child: Column(
          children: [
            Text(
              'Students Data',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width / 37,
              ),
            ),
            const Divider(
              color: Colors.amberAccent,
            ),
            Container(
                width: double.infinity,
                height: screenHeight / 3.2,
                padding: EdgeInsets.all(screenwidth * (1 / 95)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('From',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            GestureDetector(
                              onTap: () {

                                _presentDatePicker('start');
                              },
                              child: Container(
                                width: screenwidth / 4.7,
                                height: screenHeight / 17,
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.symmetric(vertical: 5),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey)),
                                child: Text(_startDate == null
                                    ? ''
                                    : _startDate.toString().replaceAll('00:00:00.000', '')),
                              ),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'To',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            GestureDetector(
                              onTap: () => _presentDatePicker('to'),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                width: screenwidth / 4.7,
                                height: screenHeight / 17,
                                margin: EdgeInsets.symmetric(vertical: 5),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey)),
                                child: Text(_toDate == null
                                    ? ''
                                    : _toDate
                                        .toString()
                                        .replaceAll('00:00:00.000', '')),
                              ),
                            )
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: Text('Download Excel'),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.amber,
                              padding: EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 55)),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Show Result'),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.amber,
                          padding: EdgeInsets.symmetric(
                              vertical: 16, horizontal: 55)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 3),
                      child: Text(
                        'Daily Data',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Divider(color: Colors.grey),
                  ],
                )),
            Expanded(
              child: Container(
                child: getTableList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
