import 'dart:core';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:qbox_admin/models/admin_ptm_model.dart';
import 'package:qbox_admin/models/category_model.dart';

class ParentTeacherMeeting extends StatefulWidget {
  const ParentTeacherMeeting({Key? key}) : super(key: key);

  @override
  State<ParentTeacherMeeting> createState() => _ParentTeacherMeetingState();
}

class _ParentTeacherMeetingState extends State<ParentTeacherMeeting> {
  bool _isCreateMeeting = false;
  bool _isLinkValidate = false;
  bool _isDateValidate = false;
  bool _isTimeValidate = false;
  bool _isLoading = false;
  bool _isDeleteLoading=false;
  bool _isEdit = false;
  String? errorMessage;
  List<String?> allCourse = [];
  List<String?> batchList = [];
  List<String?> _category = [];
  Map<String, dynamic>? _editData;
  String? _selectCourse;

  String? _selectCategory;

  String? _selectBatch;

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<void> getData() async {
    final querysnapshot =
        await FirebaseFirestore.instance.collection('cat').get();

    for (var docSnap in querysnapshot.docs) {
      CategoryModel model = CategoryModel.fromJson(docSnap.data());
      model.courses?.forEach((element) {
        allCourse.add(element.courseName);

        for (int j = 0; j < element.batches!.length; j++) {
          batchList.add(element.batches?.elementAt(j));
        }
      });
    }
    querysnapshot.docs.forEach((document) {
      _category.add(document.id);
    });
    // _selectCategory = _category.elementAt(0);
    // _selectCourse = allCourse.elementAt(0);
    // _selectBatch = batchList.elementAt(0);

    setState(() {});
  }

  TextEditingController _meetingLinkController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

  Future<void> _launchUrl(Uri _url) async {
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }

  Widget getTextField(String title, TextEditingController controller,
      String hintText, bool valid) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 31),
            child: Text(title)),
        Container(
          width: MediaQuery.of(context).size.width * (1 / 4),
          height: MediaQuery.of(context).size.height * (1 / 15),
          margin: const EdgeInsets.symmetric(horizontal: 31),
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
          decoration:
              BoxDecoration(border: Border.all(color: Colors.black, width: 1)),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
                errorText: valid ? 'Field Must beFill' : null),
          ),
        ),
      ],
    );
  }

  Widget getDropDownOptions(String title, List item, String? selection) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 31),
            child: Text(title)),
        Container(
          width: MediaQuery.of(context).size.width * (1 / 4),
          height: MediaQuery.of(context).size.height * (1 / 15),
          margin: const EdgeInsets.symmetric(horizontal: 31),
          padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
          decoration:
              BoxDecoration(border: Border.all(color: Colors.black, width: 1)),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
                value: selection,
                isExpanded: true,
                iconSize: 35,
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black,
                ),
                onChanged: (value) {
                  setState(() {
                    //selection=value;
                    if (title == 'Category') {
                      _selectCategory = value;
                    } else if (title == 'Batch') {
                      _selectBatch = value;
                    } else {
                      _selectCourse = value;
                    }
                  });
                },
                items: item.map((item) => _buildDropMenuItem(item)).toList()),
          ),
        ),
      ],
    );
  }

  DropdownMenuItem<String> _buildDropMenuItem(String item) {
    return DropdownMenuItem(
      alignment: AlignmentDirectional.topCenter,
      value: item,
      child: Align(
          alignment: Alignment.centerLeft,
          child: Text(item, style: const TextStyle(fontSize: 20))),
    );
  }

  Future<void> edit_ptm(QueryDocumentSnapshot rowData) async {
    if (_isCreateMeeting == false) {
      _editData = rowData.data() as Map<String, dynamic>;
      if (_editData == null) return;
      setState(() {
        _isEdit = true;
        _selectCategory = _editData!['category'];
        _selectCourse = _editData!['course'];
        _selectBatch = _editData!['batch'];
        _timeController.text = _editData!['time'];
        _dateController.text = _editData!['date'];
        _meetingLinkController.text = _editData!['meetingLink'];
        _isCreateMeeting = true;
      });
    }
  }

  void delete_ptm(QueryDocumentSnapshot rowData)  {
    Map<String, dynamic> data = rowData.data() as Map<String, dynamic>;

    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Delete'),
                  IconButton(
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                      icon: const Icon(Icons.close_rounded)),
                ],
              ),
              titlePadding: const EdgeInsets.symmetric(horizontal: 14,vertical: 5),
              content: Text('Are You Sure you want to delete'),
              actions: [
                ElevatedButton(onPressed: ()async {
                  setState(() {
                    _isDeleteLoading=true;
                  });
                  await FirebaseFirestore.instance.collection('PTM').doc(rowData['id']).delete();
                  setState(() {
                    _isDeleteLoading=false;
                    Navigator.of(context).pop();
                  });
                }, child: _isDeleteLoading?Center(child:CircularProgressIndicator()):Text('Delete'))
              ],
            ));
  }

  Widget switchContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Spacer(),
            ElevatedButton(
              onPressed: () {},
              child: Text('Show Result'),
              style: ElevatedButton.styleFrom(primary: Colors.amber),
            ),
            SizedBox(width: 6),
          ],
        ),
        SizedBox(height: 3),
        Divider(
          color: Colors.amber,
        ),
        Text(
          'Upcoming Meeting',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        if (!_isCreateMeeting)
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 2.3,
            margin: EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('PTM').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something is wrong');
                }
                if (ConnectionState.waiting == snapshot.connectionState) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasData) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SingleChildScrollView(
                      child: Theme(
                        data: Theme.of(context)
                            .copyWith(dividerColor: Colors.white),
                        child: DataTable(

                            //border: TableBorder.symmetric(inside: BorderSide(width: 1.5,style: BorderStyle.solid,color: Colors.red)),
                            columns: const [
                              DataColumn(label: Text('Category')),
                              DataColumn(label: Text('Course')),
                              DataColumn(label: Text('Batch')),
                              DataColumn(label: Text('Date')),
                              DataColumn(label: Text('Time')),
                              DataColumn(label: Text('Meet Link')),
                              DataColumn(label: Text('Edit')),
                              DataColumn(label: Text('Delete')),
                            ],
                            rows: snapshot.data!.docs
                                .map((rowData) => DataRow(
                                      color: MaterialStateColor.resolveWith(
                                          (states) => Colors.black12),
                                      cells: <DataCell>[
                                        DataCell(Text(rowData['category'])),
                                        DataCell(Text(rowData['course'])),
                                        DataCell(Text(rowData['batch'])),
                                        DataCell(Text(rowData['date'])),
                                        DataCell(Text(rowData['time'])),
                                        DataCell(
                                          TextButton(
                                            onPressed: () => _launchUrl(Uri.parse(
                                                rowData['meetingLink'])),
                                            child: Text(rowData['meetingLink']),
                                            style: TextButton.styleFrom(
                                                primary: Colors.blue),
                                          ),
                                        ),
                                        DataCell(IconButton(
                                            onPressed: () => edit_ptm(rowData),
                                            icon: Icon(Icons.edit))),
                                        DataCell(IconButton(
                                            onPressed: () => delete_ptm(rowData),
                                            icon: Icon(
                                              Icons.delete,
                                              color: Theme.of(context).errorColor,
                                            )))
                                      ],
                                    ))
                                .toList()),
                      ),
                    ),
                  );
                }
                return Text('No Meeting');
              },
            ),
          )
      ],
    );
  }

  void _checkValidation() {
    if (_dateController.text.isEmpty) {
      _isDateValidate = true;
    } else {
      _isDateValidate = false;
    }

    if (_timeController.text.isEmpty) {
      _isTimeValidate = true;
    } else {
      _isTimeValidate = false;
    }

    if (_meetingLinkController.text.isEmpty) {
      _isLinkValidate = true;
    } else {
      _isLinkValidate = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * (1 / 153.6)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              _isCreateMeeting
                  ? _isEdit
                      ? 'Edit'
                      : 'Create New Meeting'
                  : 'Parent Teacher Meeting',
              style:
                  TextStyle(fontSize: MediaQuery.of(context).size.width / 34),
            ),
            if (_isCreateMeeting == true)
              IconButton(
                onPressed: () {
                  setState(() {
                    if (_isEdit) {
                      _meetingLinkController.clear();
                      _timeController.clear();
                      _dateController.clear();
                      _isEdit = false;
                    }
                    _isCreateMeeting = false;
                  });
                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.amber,
                ),
                hoverColor: Colors.transparent,
              )
          ]),
          const Divider(
            color: Colors.amberAccent,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.5, horizontal: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                getDropDownOptions('Category', _category, _selectCategory),
                getDropDownOptions('Course', allCourse, _selectCourse),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.5, horizontal: 6.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getDropDownOptions('Batch', batchList, _selectBatch),
                  if (_isCreateMeeting == true)
                    getTextField('Meet Link', _meetingLinkController,
                        'Paste Link', _isLinkValidate),
                ]),
          ),
          if (_isCreateMeeting == true)
            Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 1.5, horizontal: 6.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      getTextField('Date', _dateController, 'DD-MM-YYYY',
                          _isDateValidate),
                      getTextField(
                          'Time', _timeController, 'hh:mm:ss', _isTimeValidate),
                    ])),
          if (_isCreateMeeting == false) switchContent(),
          Container(
            child: Expanded(
              child: Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_isEdit) {
                      setState(() {
                        _isLoading = true;
                      });
                      await FirebaseFirestore.instance
                          .collection('PTM')
                          .doc(_editData!['id'])
                          .update(PTMmodel(
                                  id: _editData!['id'],
                                  category: _selectCategory,
                                  course: _selectCourse,
                                  date: _dateController.text.trim(),
                                  batch: _selectBatch,
                                  meetingLink:
                                      _meetingLinkController.text.trim(),
                                  time: _timeController.text.trim())
                              .toJson());

                      setState(() {
                        _isLoading = false;
                        _isEdit = false;
                        _isCreateMeeting = false;
                      });
                    } else if (_isCreateMeeting == true) {
                      _checkValidation();
                      if (!_isLinkValidate &&
                          !_isTimeValidate &&
                          !_isDateValidate) {
                        setState(() {
                          _isLoading = true;
                        });

                        try {
                          final document = FirebaseFirestore.instance
                              .collection('PTM')
                              .doc();

                          await document
                              .set(PTMmodel(
                                      id: document.id,
                                      category: _selectCategory,
                                      course: _selectCourse,
                                      date: _dateController.text.trim(),
                                      batch: _selectBatch,
                                      meetingLink:
                                          _meetingLinkController.text.trim(),
                                      time: _timeController.text.trim())
                                  .toJson())
                              .then((value) => print('Meeting Added'))
                              .catchError((error) {
                            Fluttertoast.showToast(msg: error);
                          });
                        } on FirebaseAuthException catch (error) {
                          switch (error.code) {
                            default:
                              errorMessage =
                                  "An undefined Error happened.+$error";
                          }
                          Fluttertoast.showToast(msg: errorMessage!);
                        }
                        setState(() {
                          _meetingLinkController.clear();
                          _timeController.clear();
                          _dateController.clear();
                          _isCreateMeeting = false;
                          _isLoading = false;
                        });

                        //Add logic to create admin_ptm_model
                      }
                    } else {
                      setState(() {
                        _isCreateMeeting = true;
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(primary: Colors.amber),
                  child: _isLoading
                      ? CircularProgressIndicator(
                          color: Colors.black,
                        )
                      : Text(_isCreateMeeting
                          ? _isEdit
                              ? 'Edit'
                              : 'Create New Meeting'
                          : 'Add Meeting'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
