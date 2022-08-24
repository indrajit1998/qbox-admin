import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qbox_admin/models/level_up_series_model.dart';
import 'package:qbox_admin/screens/level_up_question_adding_screen.dart';
import 'package:qbox_admin/widgets/bottom_material_button.dart';
import 'package:qbox_admin/widgets/level_up_horizontal_card.dart';
import 'package:qbox_admin/widgets/pop_up_text_field.dart';

class LevelUpManagement extends StatefulWidget {
  const LevelUpManagement({Key? key}) : super(key: key);

  @override
  State<LevelUpManagement> createState() => _LevelUpManagementState();
}

class _LevelUpManagementState extends State<LevelUpManagement> {
  TextEditingController _addLevelController=TextEditingController();
  List<String> levels=[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding:
            EdgeInsets.all(MediaQuery.of(context).size.width * (1 / 153.6)),
        child: Column(
          children: [
            Text(
              'Batches',
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
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('chapter')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong!');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return ListView(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;
                        return ExpansionTile(
                            backgroundColor: Colors.white,
                            title: ListTile(
                              title: Text(
                                data['subject'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width *
                                            (1 / 153.6)),
                                child: const Divider(
                                  color: Colors.amber,
                                ),
                              ),
                              ExpansionTile(
                                title: ListTile(
                                  title: Text(data['chapter']),
                                  trailing: IconButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    const Text(
                                                        'Add Level'),
                                                    IconButton(
                                                        onPressed: () {
                                                          Navigator.of(
                                                              context,
                                                              rootNavigator:
                                                              true)
                                                              .pop();
                                                        },
                                                        icon: const Icon(
                                                            Icons
                                                                .close_rounded))
                                                  ],
                                                ),
                                                // contentPadding: EdgeInsets
                                                //     .all(MediaQuery.of(
                                                //     context)
                                                //     .size
                                                //     .width *
                                                //     (2 / 153.6)),
                                                content: Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .start,
                                                  mainAxisSize:
                                                  MainAxisSize
                                                      .min,
                                                  children: [
                                                    const Divider(
                                                      color: Colors
                                                          .amber,
                                                    ),
                                                    TextField(
                                                      controller: _addLevelController,
                                                      decoration: InputDecoration(hintText: 'Level Name'),
                                                    ),

                                                  ],
                                                ),
                                                actions: [
                                                Material(
                                                color: Colors
                                                .amberAccent,
                                                elevation: 4,
                                                type: MaterialType
                                                    .button,
                                                child: MaterialButton(
                                                  onPressed: (){
                                                    setState(() {
                                                      levels.add(_addLevelController.text);
                                                      _addLevelController.clear();
                                                      Navigator.of(context).pop();
                                                    });
                                                  },
                                                  color: Colors
                                                      .amberAccent,
                                                  child: Text(
                                                    'Add Level',
                                                    style:
                                                    TextStyle(
                                                      fontSize:
                                                      MediaQuery.of(context).size.width /
                                                          86,
                                                      color: Colors
                                                          .black,
                                                    ),
                                                  ),
                                                )),
                                                ],
                                              );
                                            });
                                      },
                                      icon: Icon(Icons.add_circle_outline)),
                                ),
                                children: levels.map((levelName) => ListTile(
                                  leading: Text(levelName),
                                  trailing: IconButton(
                                    onPressed: () {
                                    },
                                    icon: Icon(
                                      Icons.arrow_right_alt,
                                      color: Colors.lightBlueAccent,
                                    ),
                                  ),
                                ), ).toList()
                              )
                            ]);
                      }).toList(),
                    );
                  }),
            )),
          ],
        ),
      ),
    );
  }
}
// class _LevelUpManagementState extends State<LevelUpManagement> {
//
//   String? selectedValue = null;
//   final _dropdownFormKey = GlobalKey<FormState>();
//   List<DropdownMenuItem<String>> get dropdownItems{
//   List<DropdownMenuItem<String>> menuItems = [
//     DropdownMenuItem(child: Text("20 minute"),value: "20 minutes"),
//     DropdownMenuItem(child: Text("50 minutes"),value: "50 minutes"),
//     DropdownMenuItem(child: Text("120 minutes"),value: "120 minutes"),
//     DropdownMenuItem(child: Text("2 hours"),value: "2 hour"),
//   ];
//   return menuItems;
// }
//
//   final GlobalKey<FormState> _levelUpTestFormKey = GlobalKey<FormState>();
//   final _testNameController = TextEditingController();
//   final _chapterController = TextEditingController();
//   final _subjectController = TextEditingController();
//   final _courseController = TextEditingController();
//   final _cidController = TextEditingController();
//   final _categoryController = TextEditingController();
//   final _paperSetController = TextEditingController();
//   final _durationController = TextEditingController();
//   final _examTimeController = TextEditingController();
//
//   List<LevelUpTestModel> levelUpModelList = [];
//   setDate() async {
//     DateTime? picked = await showDatePicker(
//         context: context,
//         initialDate: DateTime.now(),
//         initialDatePickerMode: DatePickerMode.day,
//         firstDate: DateTime(2015),
//         lastDate: DateTime(2101));
//     if (picked != null) {
//       setState(() {
//         _examTimeController.text = picked.toString().split(".000")[0];
//       });
//     } else {
//       Fluttertoast.showToast(msg: "Date not selected is not selected");
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         padding:
//             EdgeInsets.all(MediaQuery.of(context).size.width * (1 / 153.6)),
//         child: Column(
//           children: [
//             Text(
//               'Level Up Tests',
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
//                     MediaQuery.of(context).size.width * (1 / 153.6),
//                   ),
//                   children: [
//                     ExpansionTile(
//                       backgroundColor: Colors.white,
//                       title: const Text('Upcoming'),
//                       children: [
//                         Divider(
//                           color: Theme.of(context).primaryColor,
//                         ),
//                         SingleChildScrollView(
//                           child: StreamBuilder<QuerySnapshot>(
//                               stream: FirebaseFirestore.instance
//                                   .collection('levelUpTest')
//                                   .snapshots(),
//                               builder: (BuildContext context,
//                                   AsyncSnapshot<QuerySnapshot> snapshot) {
//                                 if (snapshot.hasError) {
//                                   return const Text('Something went wrong!');
//                                 }
//                                 if (snapshot.connectionState ==
//                                     ConnectionState.waiting) {
//                                   return const Center(
//                                       child: CircularProgressIndicator());
//                                 }
//                                 return Wrap(
//                                   crossAxisAlignment:
//                                       WrapCrossAlignment.center,
//                                   alignment: WrapAlignment.center,
//                                   runSpacing: 10,
//                                   spacing: 10,
//                                   children: snapshot.data!.docs
//                                       .map((DocumentSnapshot document) {
//                                     Map<String, dynamic> data = document
//                                         .data()! as Map<String, dynamic>;
//                                     DateTime endTime =
//                                         DateTime.parse(data['examTime']);
//                                     DateTime now = DateTime.now();
//                                     if (DateTime(
//                                                 endTime.year,
//                                                 endTime.month,
//                                                 endTime.day,
//                                                 endTime.hour,
//                                                 endTime.minute,
//                                                 endTime.second)
//                                             .difference(DateTime(
//                                                 now.year,
//                                                 now.month,
//                                                 now.day,
//                                                 now.hour,
//                                                 now.second))
//                                             .inSeconds >=
//                                         0) {
//                                       LevelUpTestModel model =
//                                           LevelUpTestModel.fromJson(data);
//                                       levelUpModelList.add(model);
//                                       return LevelUpHorizontalCard(
//                                         model: model,
//                                       );
//                                     } else {
//                                       return Container();
//                                     }
//                                   }).toList(),
//                                 );
//                               }),
//                         ),
//                       ],
//                     ),
//                     ExpansionTile(
//                       backgroundColor: Colors.white,
//                       title: const Text('completed'),
//                       children: [
//                         Divider(
//                           color: Theme.of(context).primaryColor,
//                         ),
//                         SingleChildScrollView(
//                           child: StreamBuilder<QuerySnapshot>(
//                               stream: FirebaseFirestore.instance
//                                   .collection('levelUpTest')
//                                   .snapshots(),
//                               builder: (BuildContext context,
//                                   AsyncSnapshot<QuerySnapshot> snapshot) {
//                                 if (snapshot.hasError) {
//                                   return const Text('Something went wrong!');
//                                 }
//                                 if (snapshot.connectionState ==
//                                     ConnectionState.waiting) {
//                                   return const Center(
//                                       child: CircularProgressIndicator());
//                                 }
//                                 return Wrap(
//                                   crossAxisAlignment:
//                                       WrapCrossAlignment.center,
//                                   alignment: WrapAlignment.center,
//                                   runSpacing: 10,
//                                   spacing: 10,
//                                   children: snapshot.data!.docs
//                                       .map((DocumentSnapshot document) {
//                                     Map<String, dynamic> data = document
//                                         .data()! as Map<String, dynamic>;
//                                     DateTime endTime =
//                                         DateTime.parse(data['examTime']);
//                                     DateTime now = DateTime.now();
//                                     if (DateTime(
//                                                 endTime.year,
//                                                 endTime.month,
//                                                 endTime.day,
//                                                 endTime.hour,
//                                                 endTime.minute,
//                                                 endTime.second)
//                                             .difference(DateTime(
//                                                 now.year,
//                                                 now.month,
//                                                 now.day,
//                                                 now.hour,
//                                                 now.second))
//                                             .inSeconds <
//                                         0) {
//                                       LevelUpTestModel model =
//                                           LevelUpTestModel.fromJson(data);
//                                       levelUpModelList.add(model);
//                                       return LevelUpHorizontalCard(
//                                         model: model,
//                                       );
//                                     } else {
//                                       return Container();
//                                     }
//                                   }).toList(),
//                                 );
//                               }),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Align(
//               alignment: Alignment.bottomRight,
//               child: BottomMaterialButton(
//                 text: 'Add Test',
//                 popUpChild: Form(
//                   key: _levelUpTestFormKey,
//                   child: Wrap(
//                     crossAxisAlignment: WrapCrossAlignment.center,
//                     children: [
//                       const Divider(
//                         color: Colors.amber,
//                       ),
//                       PopUpTextField(
//                         controller: _testNameController,
//                         hint: '',
//                         label: 'Test Name',
//                         widthRatio: 2,
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return ("Field cannot be empty");
//                           }
//                           return null;
//                         },
//                       ),
//                       PopUpTextField(
//                         controller: _categoryController,
//                         hint: 'web',
//                         label: 'Category',
//                         widthRatio: 1,
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return ("Field cannot be empty");
//                           }
//                           return null;
//                         },
//                       ),
//                       PopUpTextField(
//                         controller: _courseController,
//                         hint: 'B.Tech',
//                         label: 'Course',
//                         widthRatio: 1,
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return ("Field cannot be empty");
//                           }
//                           return null;
//                         },
//                       ),
//                       PopUpTextField(
//                         controller: _cidController,
//                         hint: 'Enter the respective Course ID',
//                         label: 'CID',
//                         widthRatio: 1,
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return ("Field cannot be empty");
//                           }
//                           return null;
//                         },
//                       ),
//                       PopUpTextField(
//                         controller: _chapterController,
//                         hint: 'web',
//                         label: 'Chapter Name',
//                         widthRatio: 1,
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return ("Field cannot be empty");
//                           }
//                           return null;
//                         },
//                       ),
//                       PopUpTextField(
//                         controller: _subjectController,
//                         hint: 'maths',
//                         label: 'subject',
//                         widthRatio: 2,
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return ("Field cannot be empty");
//                           }
//                           return null;
//                         },
//                       ),
//                       PopUpTextField(
//                         controller: _paperSetController,
//                         hint: 'Set 1',
//                         label: 'Paper Set',
//                         widthRatio: 2,
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return ("Field cannot be empty");
//                           }
//                           return null;
//                         },
//                       ),
//                       durationDropDown(),
//                       // PopUpTextField(
//                       //   controller: _durationController,
//                       //   hint: '90 minutes',
//                       //   label: 'Duration',
//                       //   widthRatio: 2,
//                       //   validator: (value) {
//                       //     if (value!.isEmpty) {
//                       //       return ("Field cannot be empty");
//                       //     }
//                       //     return null;
//                       //   },
//                       // ),
//
//                       InkWell(
//                         onTap: setDate,
//                         child: PopUpTextField(
//                           controller: _examTimeController,
//                           hint: '2022-07-08 19:30:00',
//                           label: 'Exam Date',
//                           widthRatio: 1,
//                           validator: (value) {
//                             if (value!.isEmpty) {
//                               return ("Field cannot be empty");
//                             }
//                             return null;
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 popUpactions: [
//                   Material(
//                     color: Colors.amberAccent,
//                     elevation: 4,
//                     type: MaterialType.button,
//                     child: MaterialButton(
//                       onPressed: () {
//                         if (_levelUpTestFormKey.currentState!.validate()) {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) =>
//                                   LevelUpQuestionAddingScreen(
//                                 category: _categoryController.text.trim(),
//                                 course: _courseController.text.trim(),
//                                 cid:_cidController.text.trim(),
//                                 chapter: _chapterController.text.trim(),
//                                 subject: _subjectController.text.trim(),
//                                 testName: _testNameController.text.trim(),
//                                 duration: int.parse(
//                                     _durationController.text.trim()),
//                                 paperSet: int.parse(
//                                     _paperSetController.text.trim()),
//                                 examTime: _examTimeController.text.trim(),
//                               ),
//                             ),
//                           );
//                         }
//                       },
//                       padding: EdgeInsets.all(
//                           MediaQuery.of(context).size.width / 76.8),
//                       child: Text(
//                         'Next',
//                         style: TextStyle(
//                           fontSize: MediaQuery.of(context).size.width / 86,
//                           color: Colors.black,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//   durationDropDown(){
//     return  Form(
//         key: _dropdownFormKey,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             DropdownButtonFormField(
//               hint: Text('Duration'),
//                decoration: InputDecoration(
//                   enabledBorder: OutlineInputBorder(
//                    borderSide: const BorderSide(
//               color: Colors.white,),
//                   borderRadius: BorderRadius.circular(12),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderSide: BorderSide(
//               color: Theme.of(context).primaryColor,
//             ),
//             borderRadius: BorderRadius.circular(12),
//           ),
//           fillColor: Colors.grey[100],
//           filled: true,
//         ),
//                 validator: (value) => value == null ? "Duration" : null,
//                 value: selectedValue,
//                 onChanged: (String? newValue) {
//                   setState(() {
//                     selectedValue = newValue!;
//                   });
//                 },
//                 items: dropdownItems),
//
//           ],
//         )
//         );
//   }
// }
