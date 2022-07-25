import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qbox_admin/models/level_up_series_model.dart';
import 'package:qbox_admin/screens/level_up_question_adding_screen.dart';
import 'package:qbox_admin/widgets/bottom_material_button.dart';
import 'package:qbox_admin/widgets/level_up_horizontal_card.dart';
import 'package:qbox_admin/widgets/pop_up_text_field.dart';

class FullLengthTestManagement extends StatefulWidget {
  const FullLengthTestManagement({Key? key}) : super(key: key);

  @override
  State<FullLengthTestManagement> createState() =>
      _FullLengthTestManagementState();
}

class _FullLengthTestManagementState extends State<FullLengthTestManagement> {
  final GlobalKey<FormState> _fullLengthTestFormKey = GlobalKey<FormState>();
  final _testNameController = TextEditingController();
  final _courseController = TextEditingController();
  final _categoryController = TextEditingController();
  final _paperSetController = TextEditingController();
  final _durationController = TextEditingController();
  final _examTimeController = TextEditingController();
  bool download = false;

  List<LevelUpTestModel> fullLengthModelList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding:
            EdgeInsets.all(MediaQuery.of(context).size.width * (1 / 153.6)),
        child: Column(
          children: [
            Text(
              'Tests',
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
                    MediaQuery.of(context).size.width * (1 / 153.6),
                  ),
                  children: [
                    ExpansionTile(
                      backgroundColor: Colors.white,
                      title: const Text('Upcoming'),
                      children: [
                        Divider(
                          color: Theme.of(context).primaryColor,
                        ),
                        SingleChildScrollView(
                          child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('fullLengthTest')
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
                                return Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  alignment: WrapAlignment.center,
                                  runSpacing: 10,
                                  spacing: 10,
                                  children: snapshot.data!.docs
                                      .map((DocumentSnapshot document) {
                                    Map<String, dynamic> data = document.data()!
                                        as Map<String, dynamic>;
                                    DateTime endTime =
                                        DateTime.parse(data['examTime']);
                                    DateTime now = DateTime.now();
                                    if (DateTime(
                                                endTime.year,
                                                endTime.month,
                                                endTime.day,
                                                endTime.hour,
                                                endTime.minute,
                                                endTime.second)
                                            .difference(DateTime(
                                                now.year,
                                                now.month,
                                                now.day,
                                                now.hour,
                                                now.second))
                                            .inSeconds >=
                                        0) {
                                      LevelUpTestModel model =
                                          LevelUpTestModel.fromJson(data);
                                      fullLengthModelList.add(model);
                                      return LevelUpHorizontalCard(
                                        model: model,
                                      );
                                    } else {
                                      return Container();
                                    }
                                  }).toList(),
                                );
                              }),
                        ),
                      ],
                    ),
                    ExpansionTile(
                      backgroundColor: Colors.white,
                      title: const Text('completed'),
                      children: [
                        Divider(
                          color: Theme.of(context).primaryColor,
                        ),
                        SingleChildScrollView(
                          child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('fullLengthTest')
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
                                return Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  alignment: WrapAlignment.center,
                                  runSpacing: 10,
                                  spacing: 10,
                                  children: snapshot.data!.docs
                                      .map((DocumentSnapshot document) {
                                    Map<String, dynamic> data = document.data()!
                                        as Map<String, dynamic>;
                                    DateTime endTime =
                                        DateTime.parse(data['examTime']);
                                    DateTime now = DateTime.now();
                                    if (DateTime(
                                                endTime.year,
                                                endTime.month,
                                                endTime.day,
                                                endTime.hour,
                                                endTime.minute,
                                                endTime.second)
                                            .difference(DateTime(
                                                now.year,
                                                now.month,
                                                now.day,
                                                now.hour,
                                                now.second))
                                            .inSeconds <
                                        0) {
                                      LevelUpTestModel model =
                                          LevelUpTestModel.fromJson(data);
                                      fullLengthModelList.add(model);
                                      return LevelUpHorizontalCard(
                                        model: model,
                                      );
                                    } else {
                                      return Container();
                                    }
                                  }).toList(),
                                );
                              }),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: BottomMaterialButton(
                text: 'Add Test',
                popUpChild: Form(
                  key: _fullLengthTestFormKey,
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      const Divider(
                        color: Colors.amber,
                      ),
                      PopUpTextField(
                        controller: _testNameController,
                        hint: '',
                        label: 'Test Name',
                        widthRatio: 2,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Field cannot be empty");
                          }
                          return null;
                        },
                      ),
                      PopUpTextField(
                        controller: _categoryController,
                        hint: 'web',
                        label: 'Category',
                        widthRatio: 2,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Field cannot be empty");
                          }
                          return null;
                        },
                      ),
                      PopUpTextField(
                        controller: _courseController,
                        hint: 'B.Tech',
                        label: 'Course',
                        widthRatio: 2,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Field cannot be empty");
                          }
                          return null;
                        },
                      ),
                      PopUpTextField(
                        controller: _paperSetController,
                        hint: 'Set 1',
                        label: 'Paper Set',
                        widthRatio: 1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Field cannot be empty");
                          }
                          return null;
                        },
                      ),
                      PopUpTextField(
                        controller: _durationController,
                        hint: '90 minutes',
                        label: 'Duration',
                        widthRatio: 1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Field cannot be empty");
                          }
                          return null;
                        },
                      ),
                      PopUpTextField(
                        controller: _examTimeController,
                        hint: '2022-07-08 19:30:00',
                        label: 'Exam Date',
                        widthRatio: 1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Field cannot be empty");
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                popUpactions: [
                  Material(
                    color: Colors.amberAccent,
                    elevation: 4,
                    type: MaterialType.button,
                    child: MaterialButton(
                      onPressed: () {
                        if (_fullLengthTestFormKey.currentState!.validate()) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LevelUpQuestionAddingScreen(
                                category: _categoryController.text.trim(),
                                course: _courseController.text.trim(),
                                chapter: "",
                                subject: "",
                                testName: _testNameController.text.trim(),
                                duration:
                                    int.parse(_durationController.text.trim()),
                                paperSet:
                                    int.parse(_paperSetController.text.trim()),
                                examTime: _examTimeController.text.trim(),
                                collectionName: "fullLengthTest",
                              ),
                            ),
                          );
                        }
                      },
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.width / 76.8),
                      child: Text(
                        'Next',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 86,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
