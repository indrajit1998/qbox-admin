import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:qbox_admin/models/batch_model.dart';
import 'package:qbox_admin/models/category_model.dart';
import 'package:qbox_admin/utilities/dimensions.dart';
import 'package:qbox_admin/widgets/pop_up_text_field.dart';

class BatchManagement extends StatefulWidget {
  const BatchManagement({Key? key}) : super(key: key);

  @override
  State<BatchManagement> createState() => _BatchManagementState();
}

class _BatchManagementState extends State<BatchManagement> {
  String? errorMessage;
  List<String> teachersList = [];
  List categoryModelsList = [];
  List batchesList = [];
  List batchIdList = [];

  final _batchController = TextEditingController();
  final GlobalKey<FormState> _batchFormKey = GlobalKey<FormState>();

  bool isLoading = false;
  @override
  void initState() {
    getTeachers();
    getBatches("JEE");

    super.initState();
  }

  void getBatches(String courseName) async {
    FirebaseFirestore.instance
        .collection('batches')
        .where("courseName", isEqualTo: courseName)
        .get()
        .then((value) {
      setState(() {
        for (var element in value.docs) {
          batchesList.add(element.data());
          batchIdList.add(element.id);
        }
      });
    });
  }

  void getTeachers() async {
    FirebaseFirestore.instance
        .collection('teachers')
        .where("role", isEqualTo: "teacher")
        .get()
        .then((value) {
      for (var element in value.docs) {
        teachersList.add("teachers/${element.data()['email']}");
      }
    });
  }

  var f = DateFormat('yyyy-MM-dd');
  setEndTime() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        String newDate = f.format(picked);
        debugPrint(newDate);
        setState(() {
          enddateController.text =
              "$newDate ${pickedTime.hour}:${pickedTime.minute}:00";
        });
      } else {
        Fluttertoast.showToast(msg: "Date & Time not selected is not selected");
      }
    }
  }

  setStartTime() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        String newDate = f.format(picked);
        debugPrint(newDate);
        setState(() {
          startdateController.text =
              "$newDate ${pickedTime.hour}:${pickedTime.minute}:00";
        });
      } else {
        Fluttertoast.showToast(msg: "Date & Time not selected is not selected");
      }
    }
  }

  TextEditingController startdateController = TextEditingController();
  TextEditingController enddateController = TextEditingController();

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
                          // debugPrint(data);
                          categoryModelsList.add(model);
                          List<Courses>? courses = model.courses;
                          return ExpansionTile(
                            backgroundColor: Colors.white,
                            title: ListTile(
                              title: Text(
                                data['title'].toUpperCase(),
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
                              for (Courses course in courses!)
                                ExpansionTile(
                                  title: ListTile(
                                    title: Text(course.courseName!),
                                    trailing: IconButton(
                                      onPressed: () {
                                        try {
                                          String teacherDropDownValue =
                                              teachersList.first;
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      (1 / 2),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      (1 / 2),
                                                  child: SingleChildScrollView(
                                                    controller:
                                                        ScrollController(),
                                                    child: StatefulBuilder(
                                                        builder: (BuildContext
                                                                context,
                                                            StateSetter
                                                                setState) {
                                                      return AlertDialog(
                                                        title: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            const Text(
                                                                'Add Batch'),
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
                                                        contentPadding: EdgeInsets
                                                            .all(MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                (2 / 153.6)),
                                                        content: SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              (700 / 1563),
                                                          child: Form(
                                                            key: _batchFormKey,
                                                            child: Column(
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
                                                                PopUpTextField(
                                                                  controller:
                                                                      _batchController,
                                                                  validator:
                                                                      (value) {
                                                                    if (value!
                                                                        .isEmpty) {
                                                                      return ("Field cannot be empty");
                                                                    }
                                                                    return null;
                                                                  },
                                                                  hint:
                                                                      'Batch S',
                                                                  label:
                                                                      'Batch Name',
                                                                  widthRatio: 2,
                                                                ),
                                                                Text(
                                                                    "Start Date: ${startdateController.text}"),
                                                                Text(
                                                                    "End Date: ${enddateController.text}"),
                                                                Container(
                                                                  margin: EdgeInsets.all(MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      (1 /
                                                                          153.6)),
                                                                  width: double
                                                                      .maxFinite,
                                                                  padding: EdgeInsets.symmetric(
                                                                      horizontal: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          (1 /
                                                                              153.6),
                                                                      vertical: MediaQuery.of(context)
                                                                              .size
                                                                              .height *
                                                                          (5 /
                                                                              792)),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            12),
                                                                    color: Colors
                                                                        .grey
                                                                        .withOpacity(
                                                                            0.15),
                                                                  ),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Text(
                                                                        'Teachers  :',
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              MediaQuery.of(context).size.width * (18 / 1536),
                                                                        ),
                                                                      ),
                                                                      DropdownButton(
                                                                        elevation:
                                                                            0,
                                                                        dropdownColor:
                                                                            Colors.white,
                                                                        focusColor:
                                                                            Colors.white,
                                                                        value:
                                                                            teacherDropDownValue,
                                                                        items: teachersList.map<
                                                                            DropdownMenuItem<
                                                                                String>>((String
                                                                            value) {
                                                                          return DropdownMenuItem<
                                                                              String>(
                                                                            value:
                                                                                value,
                                                                            child:
                                                                                Text(
                                                                              value,
                                                                              style: const TextStyle(color: Colors.black),
                                                                            ),
                                                                          );
                                                                        }).toList(),
                                                                        onChanged:
                                                                            (String?
                                                                                newValue) {
                                                                          setState(
                                                                              () {
                                                                            teacherDropDownValue =
                                                                                newValue!;
                                                                            teachersList.add(newValue);
                                                                          });
                                                                        },
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Wrap(
                                                                  direction: Axis
                                                                      .horizontal,
                                                                  alignment:
                                                                      WrapAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      WrapCrossAlignment
                                                                          .center,
                                                                  children: [
                                                                    for (String teacher
                                                                        in teachersList)
                                                                      UnconstrainedBox(
                                                                        child:
                                                                            Container(
                                                                          margin:
                                                                              EdgeInsets.all(Dimensions.padding20 / 10),
                                                                          padding:
                                                                              EdgeInsets.only(left: Dimensions.padding20 / 10),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(50),
                                                                            color:
                                                                                Colors.amberAccent,
                                                                            border:
                                                                                Border.all(color: Colors.black87),
                                                                          ),
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              Text(teacher),
                                                                              IconButton(
                                                                                onPressed: () {
                                                                                  setState(() {
                                                                                    teachersList.remove(teacher);
                                                                                  });
                                                                                },
                                                                                icon: const Icon(
                                                                                  Icons.close_rounded,
                                                                                  color: Colors.black87,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        actions: [
                                                          Material(
                                                            color: Colors
                                                                .amberAccent,
                                                            elevation: 4,
                                                            type: MaterialType
                                                                .button,
                                                            child:
                                                                MaterialButton(
                                                              color: Colors
                                                                  .amberAccent,
                                                              onPressed:
                                                                  () async {
                                                                if (_batchFormKey
                                                                    .currentState!
                                                                    .validate()) {
                                                                  setState(() {
                                                                    isLoading =
                                                                        true;
                                                                  });
                                                                  try {
                                                                    String
                                                                        title =
                                                                        _batchController
                                                                            .text
                                                                            .trim();
                                                                    await FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            'batches')
                                                                        .doc(_batchController
                                                                            .text
                                                                            .trim())
                                                                        .set(BatchModel(batchName: _batchController.text.trim(), teachers: teachersList, courseName: course.courseName!.toLowerCase(), cid: course.cid)
                                                                            .toJson())
                                                                        .then(
                                                                            (value) {
                                                                      debugPrint(
                                                                          "Batch Added");
                                                                      setState(
                                                                          () {
                                                                        isLoading =
                                                                            false;
                                                                      });
                                                                    }).catchError(
                                                                            (error) {
                                                                      debugPrint(
                                                                          "Failed to add Batch: $error");
                                                                      // ignore: invalid_return_type_for_catch_error
                                                                      return Fluttertoast
                                                                          .showToast(
                                                                              msg: error!);
                                                                    });
                                                                    getBatches(course
                                                                        .courseName!
                                                                        .toLowerCase());
                                                                    await FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            'cat')
                                                                        .doc(document
                                                                            .id)
                                                                        .update({
                                                                          "courses.${course.courseName!.toLowerCase()}":
                                                                              {
                                                                            "startDate":
                                                                                startdateController.text,
                                                                            "endDate":
                                                                                enddateController.text,
                                                                            "courseName":
                                                                                course.courseName,
                                                                            "cid":
                                                                                course.cid,
                                                                            "payment":
                                                                                {
                                                                              "1month": course.payment!.s1month,
                                                                              "6month": course.payment!.s6month,
                                                                              "12month": course.payment!.s12month,
                                                                              "24months": course.payment!.s24months,
                                                                            },
                                                                            "batches":
                                                                                batchesList
                                                                          }
                                                                        })
                                                                        .then((value) =>
                                                                            debugPrint(
                                                                                "Batch Added"))
                                                                        .catchError((error) =>
                                                                            debugPrint("Failed to add batch: $error"));
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
                                                                              "Batch Added Successfully in batches");
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
                                                              padding: EdgeInsets.all(
                                                                  MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width /
                                                                      76.8),
                                                              child: isLoading
                                                                  ? const CircularProgressIndicator(
                                                                      color: Colors
                                                                          .white,
                                                                    )
                                                                  : Text(
                                                                      'Add Batch',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            MediaQuery.of(context).size.width /
                                                                                86,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ),
                                                            ),
                                                          ),
                                                          Material(
                                                              color: Colors
                                                                  .amberAccent,
                                                              type: MaterialType
                                                                  .button,
                                                              child:
                                                                  MaterialButton(
                                                                color: Colors
                                                                    .amberAccent,
                                                                onPressed:
                                                                    setStartTime,
                                                                child:
                                                                    const Text(
                                                                  "Start Time",
                                                                ),
                                                              )),
                                                          Material(
                                                              color: Colors
                                                                  .amberAccent,
                                                              type: MaterialType
                                                                  .button,
                                                              child:
                                                                  MaterialButton(
                                                                color: Colors
                                                                    .amberAccent,
                                                                onPressed:
                                                                    setEndTime,
                                                                child:
                                                                    const Text(
                                                                  "End Time",
                                                                ),
                                                              )),
                                                        ],
                                                      );
                                                    }),
                                                  ),
                                                );
                                              });
                                        } catch (e) {
                                          debugPrint(e.toString());
                                        }
                                      },
                                      icon:
                                          const Icon(Icons.add_circle_outline),
                                    ),
                                  ),
                                  children: [
                                    if (course.batches != null &&
                                        course.batches!.isNotEmpty)
                                      for (var batch in course.batches!)
                                        ListTile(
                                          title: Text(batch),
                                          leading: IconButton(
                                            icon: const Icon(
                                              Icons.edit,
                                              color: Colors.black,
                                            ),
                                            onPressed: () {
                                              String teacherDropDownValue =
                                                  model.teachers![0];
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return Center(
                                                      child:
                                                          SingleChildScrollView(
                                                        child: StatefulBuilder(
                                                            builder: (BuildContext
                                                                    context,
                                                                StateSetter
                                                                    setState) {
                                                          return AlertDialog(
                                                            title: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                const Text(
                                                                    'Add Batch'),
                                                                IconButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.of(
                                                                              context,
                                                                              rootNavigator: true)
                                                                          .pop();
                                                                    },
                                                                    icon: const Icon(
                                                                        Icons
                                                                            .close_rounded))
                                                              ],
                                                            ),
                                                            contentPadding: EdgeInsets
                                                                .all(MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    (2 /
                                                                        153.6)),
                                                            content: SizedBox(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  (700 / 1563),
                                                              child: Form(
                                                                key:
                                                                    _batchFormKey,
                                                                child: Column(
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
                                                                    PopUpTextField(
                                                                      controller:
                                                                          _batchController,
                                                                      validator:
                                                                          (value) {
                                                                        if (value!
                                                                            .isEmpty) {
                                                                          return ("Field cannot be empty");
                                                                        }
                                                                        return null;
                                                                      },
                                                                      hint:
                                                                          'Batch S',
                                                                      label:
                                                                          'Batch Name',
                                                                      widthRatio:
                                                                          2,
                                                                    ),
                                                                    Container(
                                                                      margin: EdgeInsets.all(MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          (1 /
                                                                              153.6)),
                                                                      width: double
                                                                          .maxFinite,
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal: MediaQuery.of(context).size.width *
                                                                              (1 /
                                                                                  153.6),
                                                                          vertical:
                                                                              MediaQuery.of(context).size.height * (5 / 792)),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(12),
                                                                        color: Colors
                                                                            .grey
                                                                            .withOpacity(0.15),
                                                                      ),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Text(
                                                                            'Teachers  :',
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: MediaQuery.of(context).size.width * (18 / 1536),
                                                                            ),
                                                                          ),
                                                                          DropdownButton(
                                                                            elevation:
                                                                                0,
                                                                            dropdownColor:
                                                                                Colors.white,
                                                                            focusColor:
                                                                                Colors.white,
                                                                            value:
                                                                                teacherDropDownValue,
                                                                            items:
                                                                                model.teachers!.map((String items) {
                                                                              return DropdownMenuItem(
                                                                                value: items,
                                                                                child: Text(items),
                                                                              );
                                                                            }).toList(),
                                                                            onChanged:
                                                                                (String? newValue) {
                                                                              setState(() {
                                                                                teacherDropDownValue = newValue!;
                                                                                teachersList.add(newValue);
                                                                              });
                                                                            },
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Wrap(
                                                                      direction:
                                                                          Axis.horizontal,
                                                                      alignment:
                                                                          WrapAlignment
                                                                              .center,
                                                                      crossAxisAlignment:
                                                                          WrapCrossAlignment
                                                                              .center,
                                                                      children: [
                                                                        for (String teacher
                                                                            in teachersList)
                                                                          UnconstrainedBox(
                                                                            child:
                                                                                Container(
                                                                              margin: EdgeInsets.all(Dimensions.padding20 / 10),
                                                                              padding: EdgeInsets.only(left: Dimensions.padding20 / 10),
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(50),
                                                                                color: Colors.amberAccent,
                                                                                border: Border.all(color: Colors.black87),
                                                                              ),
                                                                              child: Row(
                                                                                children: [
                                                                                  Text(teacher),
                                                                                  IconButton(
                                                                                    onPressed: () {
                                                                                      setState(() {
                                                                                        teachersList.remove(teacher);
                                                                                      });
                                                                                    },
                                                                                    icon: const Icon(
                                                                                      Icons.close_rounded,
                                                                                      color: Colors.black87,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            actions: [
                                                              Material(
                                                                color: Colors
                                                                    .amberAccent,
                                                                elevation: 4,
                                                                type:
                                                                    MaterialType
                                                                        .button,
                                                                child:
                                                                    MaterialButton(
                                                                  onPressed:
                                                                      () async {
                                                                    if (_batchFormKey
                                                                        .currentState!
                                                                        .validate()) {
                                                                      try {
                                                                        final title =
                                                                            document.id;
                                                                        List<String>
                                                                            documentBatches =
                                                                            <String>[] +
                                                                                course.batches!;
                                                                        await FirebaseFirestore
                                                                            .instance
                                                                            .collection(
                                                                                'cat')
                                                                            .doc(
                                                                                title)
                                                                            .update({
                                                                              "courses.${course.courseName!.toLowerCase()}": {
                                                                                "courseName": course.courseName,
                                                                                "startDate": startdateController.text,
                                                                                "endDate": enddateController.text,
                                                                                "payment": {
                                                                                  "1month": course.payment!.s1month,
                                                                                  "6month": course.payment!.s6month,
                                                                                  "12month": course.payment!.s12month,
                                                                                  "24months": course.payment!.s24months,
                                                                                },
                                                                                "cid": course.cid,
                                                                                "batches": documentBatches +
                                                                                    [
                                                                                      _batchController.text.trim()
                                                                                    ]
                                                                              }
                                                                            })
                                                                            .then((value) =>
                                                                                debugPrint("Batch Added"))
                                                                            .catchError((error) => debugPrint("Failed to add batch: $error"));
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
                                                                      Fluttertoast
                                                                          .showToast(
                                                                              msg: "Batch Added Successfully");
                                                                      try {
                                                                        String
                                                                            title =
                                                                            _batchController.text.trim();
                                                                        await FirebaseFirestore
                                                                            .instance
                                                                            .collection(
                                                                                'batches')
                                                                            .doc(
                                                                                title)
                                                                            .set(BatchModel(batchName: _batchController.text.trim(), teachers: teachersList.toList())
                                                                                .toJson())
                                                                            .then((value) =>
                                                                                debugPrint("Batch Added"))
                                                                            .catchError((error) {
                                                                          debugPrint(
                                                                              "Failed to add Batch: $error");
                                                                          // ignore: invalid_return_type_for_catch_error
                                                                          return Fluttertoast.showToast(
                                                                              msg: error!);
                                                                        });
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
                                                                      Fluttertoast
                                                                          .showToast(
                                                                              msg: "Batch Added Successfully in batches");
                                                                      if (!mounted) {
                                                                        return;
                                                                      }
                                                                      Navigator.of(
                                                                              context,
                                                                              rootNavigator: true)
                                                                          .pop();
                                                                    }
                                                                  },
                                                                  padding: EdgeInsets.all(
                                                                      MediaQuery.of(context)
                                                                              .size
                                                                              .width /
                                                                          76.8),
                                                                  child: Text(
                                                                    'Add Batch',
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          MediaQuery.of(context).size.width /
                                                                              86,
                                                                      color: Colors
                                                                          .black,
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
                                          trailing: IconButton(
                                            onPressed: () async {
                                              try {
                                                final title = document.id;
                                                await FirebaseFirestore.instance
                                                    .collection('cat')
                                                    .doc(title)
                                                    .update({
                                                      "courses.${course.courseName!.toLowerCase()}":
                                                          {
                                                        "courseName":
                                                            course.courseName!,
                                                        "cid": course.cid,
                                                        "payment": {
                                                          "1month": course
                                                              .payment!.s1month,
                                                          "6month": course
                                                              .payment!.s6month,
                                                          "12month": course
                                                              .payment!
                                                              .s12month,
                                                          "24months": course
                                                              .payment!
                                                              .s24months,
                                                        },
                                                        "batches": FieldValue
                                                            .arrayRemove(
                                                                [batch])
                                                      }
                                                    })
                                                    .then((value) => debugPrint(
                                                        "Batch Added"))
                                                    .catchError((error) =>
                                                        debugPrint(
                                                            "Failed to add batch: $error"));
                                              } on FirebaseAuthException catch (error) {
                                                switch (error.code) {
                                                  default:
                                                    errorMessage =
                                                        "An undefined Error happened.+$error";
                                                }
                                                Fluttertoast.showToast(
                                                    msg: errorMessage!);
                                              }
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "Batch Added Successfully");
                                              try {
                                                String title = _batchController
                                                    .text
                                                    .trim();
                                                await FirebaseFirestore.instance
                                                    .collection('batches')
                                                    .doc(title)
                                                    .set(BatchModel(
                                                            batchName:
                                                                _batchController
                                                                    .text
                                                                    .trim(),
                                                            teachers:
                                                                teachersList
                                                                    .toList())
                                                        .toJson())
                                                    .then((value) => debugPrint(
                                                        "Batch Added"))
                                                    .catchError((error) {
                                                  debugPrint(
                                                    "Failed to add Batch: $error",
                                                  );
                                                  Fluttertoast.showToast(
                                                    msg: error!,
                                                  );
                                                });
                                              } on FirebaseAuthException catch (error) {
                                                switch (error.code) {
                                                  default:
                                                    errorMessage =
                                                        "An undefined Error happened.+$error";
                                                }
                                                Fluttertoast.showToast(
                                                    msg: errorMessage!);
                                              }
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "Batch Added Successfully in batches");
                                              if (!mounted) {
                                                return;
                                              }
                                              Navigator.of(context,
                                                      rootNavigator: true)
                                                  .pop();
                                            },
                                            icon: const Icon(
                                              Icons.delete_outline_rounded,
                                              color: Colors.redAccent,
                                            ),
                                          ),
                                        )
                                  ],
                                ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height *
                                    (10 / 792),
                              ),
                            ],
                          );
                        }).toList(),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
