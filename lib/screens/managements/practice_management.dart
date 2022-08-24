import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qbox_admin/models/practice_model.dart';
import 'package:qbox_admin/screens/question_adding_screen.dart';
import 'package:qbox_admin/widgets/bottom_material_button.dart';
import 'package:qbox_admin/widgets/horizontal_card.dart';
import 'package:qbox_admin/widgets/pop_up_text_field.dart';

import '../question_paper_preview.dart';

class PracticeManagement extends StatefulWidget {
  const PracticeManagement({Key? key}) : super(key: key);

  @override
  State<PracticeManagement> createState() => _PracticeManagementState();
}

class _PracticeManagementState extends State<PracticeManagement> {
  final _chapterController = TextEditingController();
  final _courseController = TextEditingController();
  final _cidController = TextEditingController();
  final _categoryController = TextEditingController();
  final _subjectController = TextEditingController();

  final GlobalKey<FormState> _questionPaperDetailsFormKey =
      GlobalKey<FormState>();

  List<PracticeModel> practiceModelList = [];
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding:
            EdgeInsets.all(MediaQuery.of(context).size.width * (1 / 153.6)),
        child: Column(
          children: [
            Text(
              'DPB',
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
                child: SingleChildScrollView(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('practice')
                          .where("uploadedTeacher",
                              isEqualTo: FirebaseAuth
                                  .instance.currentUser!.email
                                  .toString())
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
                          // alignment: WrapAlignment.center,
                          // runSpacing: 10,
                          // spacing: 10,
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                            Map<String, dynamic> data =
                                document.data()! as Map<String, dynamic>;
                            PracticeModel model = PracticeModel.fromJson(data);
                            practiceModelList.add(model);
                            return Container(
                              // height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              child: Theme(
                      data: Theme.of(context).copyWith(dividerColor: Colors.white),
                      child: DataTable(

                          //border: TableBorder.symmetric(inside: BorderSide(width: 1.5,style: BorderStyle.solid,color: Colors.red)),
                          columns:  [
                              DataColumn(label: Text('Category')),
                              DataColumn(label: Text('Course Name')),
                              DataColumn(label: Text('ID')),
                              DataColumn(label: Text('Publish Date')),
                              DataColumn(label: Text('Update Date')),
                              DataColumn(label: Text('Chapter Name')),
                              DataColumn(label: Text('Subject')),
                          ],
                           rows: [
                                  DataRow(
                                    color: MaterialStateColor.resolveWith((states) => Colors.black12),
                                    cells: <DataCell>[
                                      DataCell(Text(model.category.toString())),
                                      DataCell(Text(model.course.toString())),
                                      DataCell(Text('2133443')),
                                      DataCell(Text('22-08-2022')),
                                      DataCell(Text('20-08-2022')),
                                      DataCell(Text(model.chapter.toString())),
                                      DataCell(
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text(model.subject.toString()),
                                            Spacer(),
                                            IconButton(onPressed: (){
                                               Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => QuestionPaperPreview(questionPaper: model)),
        );
                                            }, icon: Icon(Icons.arrow_right_alt, color: Colors.blue,))
                                          ],
                                        )),
                                      // DataCell(Text('icon'))
                                    ]

                                  )
                          ],
                                    )
                    ),
                            );
                            // return HorizontalCard(
                            //   model: model,
                            // );
                          }).toList(),
                        );
                      }),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                BottomMaterialButton(
                  text: 'Add Another Practice Set',
                  popUpChild: Form(
                    key: _questionPaperDetailsFormKey,
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        const Divider(
                          color: Colors.amber,
                        ),
                        PopUpTextField(
                          controller: _categoryController,
                          hint: 'Engineering',
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
                          hint: 'Jee',
                          label: 'Course Name',
                          widthRatio: 2,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ("Field cannot be empty");
                            }
                            return null;
                          },
                        ),
                        PopUpTextField(
                          controller: _cidController,
                          hint: 'Enter the Course ID',
                          label: 'ID',
                          widthRatio: 2,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ("Field cannot be empty");
                            }
                            return null;
                          },
                        ),
                        PopUpTextField(
                          controller: _chapterController,
                          hint: 'Vectors',
                          label: 'Chapter Name',
                          widthRatio: 2,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ("Field cannot be empty");
                            }
                            return null;
                          },
                        ),
                        PopUpTextField(
                          controller: _subjectController,
                          hint: 'Maths',
                          label: 'Subject',
                          widthRatio: 2,
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
                          if (_questionPaperDetailsFormKey.currentState!
                              .validate()) {
                                
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => QuestionAddingScreen(
                                        category:
                                            _categoryController.text.trim(),
                                        course: _courseController.text.trim(),
                                        chapter: _chapterController.text.trim(),
                                        cid:_cidController.text.trim(),
                                        subject: _subjectController.text.trim(),
                                      )),
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
