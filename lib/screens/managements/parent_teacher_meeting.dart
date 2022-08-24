import 'dart:core';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  String? errorMessage;
  List<String?> allCourse = [];
  List<String?> batchList = [];
  final List<String?> _category = [];
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
    for (var document in querysnapshot.docs) {
      _category.add(document.id);
    }
    _selectCategory = _category.elementAt(0);
    _selectCourse = allCourse.elementAt(0);
    _selectBatch = batchList.elementAt(0);

    debugPrint(_category.toString());
    debugPrint(batchList.toString());
    debugPrint(allCourse.toString());
    debugPrint(_selectBatch);
    debugPrint(_selectCourse);
    debugPrint(_selectCategory);
    setState(() {});
  }

  final TextEditingController _meetingLinkController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  Widget getTextField(String title, TextEditingController controller,
      String hintText, bool valid) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 31),
          child: Text(title),
        ),
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
              errorText: valid ? 'Field Must beFill' : null,
            ),
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
          child: Text(title),
        ),
        Container(
          width: MediaQuery.of(context).size.width * (1 / 4),
          height: MediaQuery.of(context).size.height * (1 / 15),
          margin: const EdgeInsets.symmetric(horizontal: 31),
          padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 1,
            ),
          ),
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
        child: Text(
          item,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Widget switchContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Spacer(),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(primary: Colors.amber),
              child: const Text('Show Result'),
            ),
            const SizedBox(width: 6),
          ],
        ),
        const SizedBox(height: 3),
        const Divider(
          color: Colors.amber,
        ),
        const Text(
          'Upcoming Meeting',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        if (!_isCreateMeeting)
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 2.3,
            margin: const EdgeInsets.symmetric(vertical: 8),
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
                                      DataCell(Text(rowData['meetingLink'])),
                                    ],
                                  ))
                              .toList()),
                    ),
                  );
                }
                return const Text('No Meeting');
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
    return Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * (1 / 153.6)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              _isCreateMeeting
                  ? 'Create New Meeting'
                  : 'Parent Teacher Meeting',
              style:
                  TextStyle(fontSize: MediaQuery.of(context).size.width / 32),
            ),
            if (_isCreateMeeting == true)
              IconButton(
                onPressed: () {
                  setState(() {
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
          Expanded(
            child: Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () async {
                  if (_isCreateMeeting == true) {
                    _checkValidation();
                    if (!_isLinkValidate &&
                        !_isTimeValidate &&
                        !_isDateValidate) {
                      setState(() {
                        _isLoading = true;
                      });

                      try {
                        await FirebaseFirestore.instance
                            .collection('PTM')
                            .doc(
                                '${_dateController.text} ${_timeController.text}')
                            .set(PTMmodel(
                                    category: _selectCategory,
                                    course: _selectCourse,
                                    date: _dateController.text.trim(),
                                    batch: _selectBatch,
                                    meetingLink:
                                        _meetingLinkController.text.trim(),
                                    time: _timeController.text.trim())
                                .toJson())
                            .then(
                              (value) => debugPrint('Meeting Added'),
                            )
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
                    ? const CircularProgressIndicator(
                        color: Colors.black,
                      )
                    : Text(_isCreateMeeting
                        ? 'Create New Meeting'
                        : 'Add Meeting'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
