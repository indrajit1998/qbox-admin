import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qbox_admin/models/category_model.dart';
import 'package:qbox_admin/widgets/bottom_material_button.dart';
import 'package:qbox_admin/widgets/pop_up_text_field.dart';

class CourseManagement extends StatefulWidget {
  const CourseManagement({Key? key}) : super(key: key);

  @override
  State<CourseManagement> createState() => _CourseManagementState();
}

class _CourseManagementState extends State<CourseManagement> {
  final _formKey = GlobalKey<FormState>();
  final _courseFormKey = GlobalKey<FormState>();
  final _courseEditingFormKey = GlobalKey<FormState>();
  String? errorMessage;
  List categoryModelsList = [];

  final _categoryController = TextEditingController();
  final _courseController = TextEditingController();
  final _oneMonthFeeController = TextEditingController();
  final _sixMonthFeeController = TextEditingController();
  final _oneYearFeeController = TextEditingController();
  final _twoYearFeeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding:
            EdgeInsets.all(MediaQuery.of(context).size.width * (1 / 153.6)),
        child: Column(
          children: [
            Text(
              'Courses',
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
                        .collection('cat')
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
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                          Map<String, dynamic> data =
                              document.data()! as Map<String, dynamic>;
                          CategoryModel model = CategoryModel.fromJson(data);
                          categoryModelsList.add(model);
                          List<Courses>? courses = model.courses;
                          return ExpansionTile(
                            backgroundColor: Colors.white,
                            title: ListTile(
                              title: Text(
                                model.title.toString().toUpperCase(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              trailing: IconButton(
                                  onPressed: () async {
                                    final title = document.id;
                                    await FirebaseFirestore.instance
                                        .collection("cat")
                                        .doc(title)
                                        .delete()
                                        .then(
                                          (doc) => print("Category deleted"),
                                          onError: (e) => print(
                                              "Error updating document $e"),
                                        );
                                  },
                                  icon: const Icon(
                                    Icons.delete_outline_rounded,
                                    color: Colors.redAccent,
                                  )),
                              leading: IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Center(
                                          child: SingleChildScrollView(
                                            child: StatefulBuilder(builder:
                                                (BuildContext context,
                                                    StateSetter setState) {
                                              return AlertDialog(
                                                title: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Text('Add Course'),
                                                    IconButton(
                                                        onPressed: () {
                                                          Navigator.of(context,
                                                                  rootNavigator:
                                                                      true)
                                                              .pop();
                                                        },
                                                        icon: const Icon(Icons
                                                            .close_rounded))
                                                  ],
                                                ),
                                                contentPadding: EdgeInsets.all(
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        (2 / 153.6)),
                                                content: Form(
                                                  key: _courseFormKey,
                                                  child: SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            (700 / 1563),
                                                    child: Wrap(
                                                      children: [
                                                        const Divider(
                                                          color: Colors.amber,
                                                        ),
                                                        PopUpTextField(
                                                          controller:
                                                              _courseController,
                                                          hint: 'Course Name',
                                                          label: 'Course Name',
                                                          widthRatio: 2,
                                                          validator: (value) {
                                                            if (value!
                                                                .isEmpty) {
                                                              return ("Field cannot be empty");
                                                            }
                                                            return null;
                                                          },
                                                        ),
                                                        PopUpTextField(
                                                          controller:
                                                              _oneMonthFeeController,
                                                          hint: 'Rs.3000',
                                                          label:
                                                              'Course Payment for 1 Month',
                                                          widthRatio: 1,
                                                          validator: (value) {
                                                            if (value!
                                                                .isEmpty) {
                                                              return ("Field cannot be empty");
                                                            }
                                                            return null;
                                                          },
                                                        ),
                                                        PopUpTextField(
                                                          controller:
                                                              _sixMonthFeeController,
                                                          hint: 'Rs.3000',
                                                          label:
                                                              'Course Payment for 6 Month',
                                                          widthRatio: 1,
                                                          validator: (value) {
                                                            if (value!
                                                                .isEmpty) {
                                                              return ("Field cannot be empty");
                                                            }
                                                            return null;
                                                          },
                                                        ),
                                                        PopUpTextField(
                                                          controller:
                                                              _oneYearFeeController,
                                                          hint: 'Rs.24000',
                                                          label:
                                                              'Course Payment for 1 Year',
                                                          widthRatio: 1,
                                                          validator: (value) {
                                                            if (value!
                                                                .isEmpty) {
                                                              return ("Field cannot be empty");
                                                            }
                                                            return null;
                                                          },
                                                        ),
                                                        PopUpTextField(
                                                          controller:
                                                              _twoYearFeeController,
                                                          hint: 'Rs.24000',
                                                          label:
                                                              'Course Payment for 2 Years',
                                                          widthRatio: 1,
                                                          validator: (value) {
                                                            if (value!
                                                                .isEmpty) {
                                                              return ("Field cannot be empty");
                                                            }
                                                            return null;
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                actions: [
                                                  Material(
                                                    color: Colors.amberAccent,
                                                    elevation: 4,
                                                    type: MaterialType.button,
                                                    child: MaterialButton(
                                                      onPressed: () async {
                                                        if (_courseFormKey
                                                            .currentState!
                                                            .validate()) {
                                                          final title =
                                                              document.id;
                                                          try {
                                                            await FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'cat')
                                                                .doc(title)
                                                                .update({
                                                                  "courses.${_courseController.text.trim().toLowerCase()}":
                                                                      {
                                                                    "courseName":
                                                                        _courseController
                                                                            .text
                                                                            .trim(),
                                                                    "batches":
                                                                        [],
                                                                    "payment": {
                                                                      "1month": _oneMonthFeeController
                                                                          .text
                                                                          .trim(),
                                                                      "6month": _oneMonthFeeController
                                                                          .text
                                                                          .trim(),
                                                                      "12month": _oneMonthFeeController
                                                                          .text
                                                                          .trim(),
                                                                      "24months": _oneMonthFeeController
                                                                          .text
                                                                          .trim(),
                                                                    }
                                                                  }
                                                                })
                                                                .then((value) =>
                                                                    print(
                                                                        "Course Added"))
                                                                .catchError(
                                                                    (error) =>
                                                                        print(
                                                                            "Failed to add Course: $error"));
                                                          } on FirebaseAuthException catch (error) {
                                                            switch (
                                                                error.code) {
                                                              default:
                                                                errorMessage =
                                                                    "An undefined Error happened.+$error";
                                                            }
                                                            Fluttertoast.showToast(
                                                                msg:
                                                                    errorMessage!);
                                                          }
                                                          Fluttertoast.showToast(
                                                              msg:
                                                                  "Course Added Successfully");
                                                          if (!mounted) return;
                                                          Navigator.of(context,
                                                                  rootNavigator:
                                                                      true)
                                                              .pop();
                                                        }
                                                      },
                                                      padding: EdgeInsets.all(
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              76.8),
                                                      child: Text(
                                                        'Add Course',
                                                        style: TextStyle(
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              86,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            }),
                                          ),
                                        );
                                      });
                                },
                                icon: const Icon(Icons.add_circle_outline),
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
                              if (courses != null)
                                for (Courses course in courses)
                                  ListTile(
                                    title: Text(course.courseName!),
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Center(
                                              child: SingleChildScrollView(
                                                child: StatefulBuilder(builder:
                                                    (BuildContext context,
                                                        StateSetter setState) {
                                                  return AlertDialog(
                                                    title: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                            course.courseName!),
                                                        IconButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context,
                                                                      rootNavigator:
                                                                          true)
                                                                  .pop();
                                                            },
                                                            icon: const Icon(Icons
                                                                .close_rounded))
                                                      ],
                                                    ),
                                                    contentPadding:
                                                        EdgeInsets.all(
                                                            MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                (2 / 153.6)),
                                                    content: Form(
                                                      key:
                                                          _courseEditingFormKey,
                                                      child: SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            (700 / 1563),
                                                        child: Wrap(
                                                          children: [
                                                            const Divider(
                                                              color:
                                                                  Colors.amber,
                                                            ),
                                                            PopUpTextField(
                                                              controller:
                                                                  _courseController,
                                                              hint: course
                                                                  .courseName!,
                                                              label:
                                                                  'Course Name',
                                                              widthRatio: 2,
                                                              validator:
                                                                  (value) {
                                                                if (value!
                                                                    .isEmpty) {
                                                                  return ("Field cannot be empty");
                                                                }
                                                                return null;
                                                              },
                                                            ),
                                                            PopUpTextField(
                                                              controller:
                                                                  _oneMonthFeeController,
                                                              hint: course
                                                                  .payment!
                                                                  .s1month!,
                                                              label:
                                                                  'Course Payment for 1 Month',
                                                              widthRatio: 1,
                                                              validator:
                                                                  (value) {
                                                                if (value!
                                                                    .isEmpty) {
                                                                  return ("Field cannot be empty");
                                                                }
                                                                return null;
                                                              },
                                                            ),
                                                            PopUpTextField(
                                                              controller:
                                                                  _sixMonthFeeController,
                                                              hint: course
                                                                  .payment!
                                                                  .s6month!,
                                                              label:
                                                                  'Course Payment for 6 Month',
                                                              widthRatio: 1,
                                                              validator:
                                                                  (value) {
                                                                if (value!
                                                                    .isEmpty) {
                                                                  return ("Field cannot be empty");
                                                                }
                                                                return null;
                                                              },
                                                            ),
                                                            PopUpTextField(
                                                              controller:
                                                                  _oneYearFeeController,
                                                              hint: course
                                                                  .payment!
                                                                  .s12month!,
                                                              label:
                                                                  'Course Payment for 1 Year',
                                                              widthRatio: 1,
                                                              validator:
                                                                  (value) {
                                                                if (value!
                                                                    .isEmpty) {
                                                                  return ("Field cannot be empty");
                                                                }
                                                                return null;
                                                              },
                                                            ),
                                                            PopUpTextField(
                                                              controller:
                                                                  _twoYearFeeController,
                                                              hint: course
                                                                  .payment!
                                                                  .s24months!,
                                                              label:
                                                                  'Course Payment for 2 Years',
                                                              widthRatio: 1,
                                                              validator:
                                                                  (value) {
                                                                if (value!
                                                                    .isEmpty) {
                                                                  return ("Field cannot be empty");
                                                                }
                                                                return null;
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    actions: [
                                                      Material(
                                                        color: Colors.redAccent,
                                                        elevation: 4,
                                                        type:
                                                            MaterialType.button,
                                                        child: MaterialButton(
                                                          onPressed: () async {
                                                            final title =
                                                                document.id;
                                                            try {
                                                              await FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'cat')
                                                                  .doc(title)
                                                                  .update({
                                                                    "courses.${course.courseName!.toLowerCase()}":
                                                                        FieldValue
                                                                            .delete()
                                                                  })
                                                                  .then((value) =>
                                                                      print(
                                                                          "Course Deleted"))
                                                                  .catchError(
                                                                      (error) =>
                                                                          print(
                                                                              "Failed to delete Course: $error"));
                                                            } on FirebaseAuthException catch (error) {
                                                              switch (
                                                                  error.code) {
                                                                default:
                                                                  errorMessage =
                                                                      "An undefined Error happened.+$error";
                                                              }
                                                              Fluttertoast
                                                                  .showToast(
                                                                      msg:
                                                                          errorMessage!);
                                                            }
                                                            Fluttertoast.showToast(
                                                                msg:
                                                                    "Course deleted Successfully");
                                                            if (!mounted) {
                                                              return;
                                                            }
                                                            Navigator.of(
                                                                    context,
                                                                    rootNavigator:
                                                                        true)
                                                                .pop();
                                                          },
                                                          padding: EdgeInsets
                                                              .all(MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  76.8),
                                                          child: Text(
                                                            'Delete Course',
                                                            style: TextStyle(
                                                              fontSize: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  86,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Material(
                                                        color:
                                                            Colors.amberAccent,
                                                        elevation: 4,
                                                        type:
                                                            MaterialType.button,
                                                        child: MaterialButton(
                                                          onPressed: () async {
                                                            if (_courseEditingFormKey
                                                                .currentState!
                                                                .validate()) {
                                                              final title =
                                                                  document.id;
                                                              try {
                                                                await FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'cat')
                                                                    .doc(title)
                                                                    .update({
                                                                      "courses.${_courseController.text.trim().toLowerCase()}":
                                                                          {
                                                                        "courseName": _courseController
                                                                            .text
                                                                            .trim(),
                                                                        "batches":
                                                                            [],
                                                                        "payment":
                                                                            {
                                                                          "1month": _oneMonthFeeController
                                                                              .text
                                                                              .trim(),
                                                                          "6month": _oneMonthFeeController
                                                                              .text
                                                                              .trim(),
                                                                          "12month": _oneMonthFeeController
                                                                              .text
                                                                              .trim(),
                                                                          "24months": _oneMonthFeeController
                                                                              .text
                                                                              .trim(),
                                                                        }
                                                                      }
                                                                    })
                                                                    .then((value) =>
                                                                        print(
                                                                            "Course updated"))
                                                                    .catchError(
                                                                        (error) =>
                                                                            print("Failed to update Course: $error"));
                                                              } on FirebaseAuthException catch (error) {
                                                                switch (error
                                                                    .code) {
                                                                  default:
                                                                    errorMessage =
                                                                        "An undefined Error happened.+$error";
                                                                }
                                                                Fluttertoast
                                                                    .showToast(
                                                                        msg:
                                                                            errorMessage!);
                                                              }
                                                              Fluttertoast
                                                                  .showToast(
                                                                      msg:
                                                                          "Course updated Successfully");
                                                              if (!mounted) {
                                                                return;
                                                              }
                                                              Navigator.of(
                                                                      context,
                                                                      rootNavigator:
                                                                          true)
                                                                  .pop();
                                                            }
                                                          },
                                                          padding: EdgeInsets
                                                              .all(MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  76.8),
                                                          child: Text(
                                                            'Updated Course',
                                                            style: TextStyle(
                                                              fontSize: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  86,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                }),
                                              ),
                                            );
                                          });
                                    },
                                  ),
                            ],
                          );
                        }).toList(),
                      );
                    }),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                BottomMaterialButton(
                  text: 'Add Category',
                  popUpChild: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Divider(
                          color: Colors.amber,
                        ),
                        PopUpTextField(
                          hint: 'Title',
                          label: 'Title',
                          widthRatio: 2,
                          controller: _categoryController,
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
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final title =
                                _categoryController.text.trim().toLowerCase();
                            try {
                              await FirebaseFirestore.instance
                                  .collection('cat')
                                  .doc(title)
                                  .set({"title": title, "courses": {}})
                                  .then((value) => print("Category Added"))
                                  .catchError((error) =>
                                      print("Failed to add category: $error"));
                            } on FirebaseAuthException catch (error) {
                              switch (error.code) {
                                default:
                                  errorMessage =
                                      "An undefined Error happened.+$error";
                              }
                              Fluttertoast.showToast(msg: errorMessage!);
                            }
                            if (!mounted) return;
                            Navigator.of(context, rootNavigator: true).pop();
                          }
                        },
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width / 76.8),
                        child: Text(
                          'Add Category',
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
