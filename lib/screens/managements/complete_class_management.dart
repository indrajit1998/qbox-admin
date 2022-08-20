import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompleteClassManagement extends StatefulWidget {
  const CompleteClassManagement({Key? key}) : super(key: key);

  @override
  State<CompleteClassManagement> createState() =>
      _CompleteClassManagementState();
}

class _CompleteClassManagementState extends State<CompleteClassManagement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(Get.width * (1 / 153.6)),
        child: Column(
          children: [
            Text(
              'Completed Class',
              style: TextStyle(
                fontSize: Get.width / 32,
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
                  bottom: Get.width * (1 / 153.6),
                ),
                child: ListView(
                  padding: EdgeInsets.all(Get.width * (1 / 153.6)),
                  children: [
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('liveVideos')
                            .where('live', isEqualTo: false)
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
                          return Column(
                            children: [
                              Table(
                                children: const [
                                  TableRow(
                                    children: [
                                      Text('Category'),
                                      Text('Course'),
                                      Text('Batch Name'),
                                      Text('Chapter Name'),
                                      Text('Title'),
                                      Text('Download'),
                                    ],
                                  ),
                                ],
                              ),
                              Table(
                                defaultVerticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                children: snapshot.data!.docs
                                    .map((DocumentSnapshot document) {
                                  Map<String, dynamic> data =
                                      document.data()! as Map<String, dynamic>;

                                  return TableRow(
                                    decoration: BoxDecoration(
                                      color: const Color(0XFFC4C4C4),
                                      border: Border.all(
                                        width: 2.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                    children: [
                                      Text(' ${data['category']}'),
                                      Text(data['course']),
                                      Text(data['batch'] ?? ""),
                                      Text(data['chapter']),
                                      Text(data['title']),
                                      const Text(""),
                                    ],
                                  );
                                }).toList(),
                              ),
                            ],
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
