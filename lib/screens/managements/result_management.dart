import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qbox_admin/utilities/dimensions.dart';

class ResultManagement extends StatefulWidget {
  const ResultManagement({Key? key}) : super(key: key);

  @override
  State<ResultManagement> createState() => _ResultManagementState();
}

class _ResultManagementState extends State<ResultManagement> {
  final TextEditingController _chapterTextController = TextEditingController();
  String? _chapterCourse;
  String? _chapterCategory;
  String? _chapterBatch;

  BoxDecoration decoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(5.0),
    border: Border.all(
      color: Colors.black12,
      style: BorderStyle.solid,
      width: 0.80,
    ),
  );

  Widget _getDropdownTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(Get.width * (1 / 153.6)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Result',
              style: TextStyle(
                fontSize: Get.width / 45,
              ),
            ),
            const Divider(
              color: Colors.amberAccent,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _getDropdownTitle('Category'),
                      Container(
                        height: 50,
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        decoration: decoration,
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('cat')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                child: CupertinoActivityIndicator(),
                              );
                            }
                            return Container(
                              height: 150,
                              width: Dimensions.width10 * 10,
                              padding: const EdgeInsets.all(15),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  icon: const Visibility(
                                    visible: true,
                                    child: Icon(Icons.keyboard_arrow_down),
                                  ),
                                  value: _chapterCategory,
                                  // isDense: true,
                                  items: snapshot.data!.docs
                                      .map((DocumentSnapshot doc) {
                                    Map<String, dynamic> data =
                                        doc.data() as Map<String, dynamic>;
                                    return DropdownMenuItem<String>(
                                      value: data['title'],
                                      child: Text(data['title']),
                                    );
                                  }).toList(),
                                  hint: const Text("Choose Category"),
                                  onChanged: (value) {
                                    setState(() {
                                      _chapterCategory = value as String?;
                                    });
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _getDropdownTitle('Course'),
                      Container(
                        height: 50,
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        decoration: decoration,
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('PTM')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                child: CupertinoActivityIndicator(),
                              );
                            }

                            return Container(
                              height: 150,
                              width: Dimensions.width10 * 10,
                              padding: const EdgeInsets.all(15),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  icon: const Visibility(
                                    visible: true,
                                    child: Icon(Icons.keyboard_arrow_down),
                                  ),
                                  value: _chapterCourse,
                                  // isDense: true,
                                  items: snapshot.data!.docs
                                      .map((DocumentSnapshot doc) {
                                    Map<String, dynamic> data =
                                        doc.data() as Map<String, dynamic>;
                                    return DropdownMenuItem<String>(
                                        value: data['course'],
                                        child: Text(data['course']));
                                  }).toList(),
                                  hint: const Text("Choose Course"),
                                  onChanged: (value) {
                                    setState(() {
                                      _chapterCourse = value as String?;
                                    });
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _getDropdownTitle('Batch Name'),
                      Container(
                        height: 50,
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        decoration: decoration,
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('PTM')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                child: CupertinoActivityIndicator(),
                              );
                            }
                            return Container(
                              height: 150,
                              width: Dimensions.width10 * 10,
                              padding: const EdgeInsets.all(15),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  icon: const Visibility(
                                    visible: true,
                                    child: Icon(Icons.keyboard_arrow_down),
                                  ),
                                  value: _chapterBatch,
                                  items: snapshot.data!.docs
                                      .map((DocumentSnapshot doc) {
                                    Map<String, dynamic> data =
                                        doc.data() as Map<String, dynamic>;
                                    return DropdownMenuItem<String>(
                                      value: data['batch'],
                                      child: Text(data['batch']),
                                    );
                                  }).toList(),
                                  hint: const Text("Batch Name"),
                                  onChanged: (value) {
                                    setState(() {
                                      _chapterBatch = value as String?;
                                    });
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _getDropdownTitle('Chapter'),
                      Container(
                        height: 50,
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        decoration: decoration,
                        child: Container(
                          height: 150,
                          width: Dimensions.width10 * 10,
                          padding: const EdgeInsets.all(15),
                          child: TextFormField(
                            controller: _chapterTextController,
                            decoration: const InputDecoration(
                              labelText: 'Chapter',
                              border: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Spacer(),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(
                      Dimensions.width10 * 8,
                      Dimensions.height10 * 5,
                    ),
                    primary: Colors.amber,
                    elevation: 0,
                  ),
                  child: const Text('Show Result'),
                ),
                const SizedBox(width: 30),
              ],
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
                                defaultVerticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                children: const [
                                  TableRow(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Text('Category'),
                                      ),
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
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(' ${data['category']}'),
                                      ),
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
