import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BioData extends StatefulWidget {
  BioData({Key? key}) : super(key: key);

  @override
  State<BioData> createState() => _BioDataState();
}

class _BioDataState extends State<BioData> {
  Map<String, dynamic> biodataMap = {};
  final _formKey = GlobalKey<FormState>();
  String _teacherName = '';
  String _courseCategory = '';
  String _subjectBased = '';
  String _password = '';
  String _emailaddress = '';
  String _emailOtp = '';
  String _phoneNumber = '';
  String _phoneOtp = '';
  String _address = '';
  String _voterCardNo = '';
  String _adharCardNo = '';
  String _bankAccountNo = '';
  String _ifscCode = '';
  bool _isLoading = false;
  var _userEmail;

  List<GroupEducationControllers> _lstGroupContollers = [];
  List<GroupExtraQualControllers> _lstExtraQualControllers = [];
  List<TextField> _exams = [];
  List<TextField> _institutes = [];
  List<TextField> _boards = [];
  List<TextField> _passingYears = [];
  List<TextField> _grades = [];
  List<TextField> _percentage = [];
  List<TextField> _nameOfCompany = [];
  List<TextField> _fromDate = [];
  List<TextField> _expMonth = [];
  List<TextField> _designation = [];

  int curEducationRow = 1;
  int curExtraQualRow = 1;

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<void> getData() async {
    // print('inide getData');

    _userEmail = FirebaseAuth.instance.currentUser!.email;
    setState(() {
      _isLoading = true;
    });
    try{
      final docUser = await FirebaseFirestore.instance
          .collection('teachers')
          .doc(_userEmail)
          .collection('biodata')
          .doc(_userEmail)
          .get();

      if (docUser.exists && docUser.data()!.isNotEmpty) {
        biodataMap = docUser.data()!;
        _teacherName = biodataMap['name'];
        _courseCategory = biodataMap['courseCategory'];
        _subjectBased = biodataMap['subjectBased'];
        _address = biodataMap['address'];
        _password = biodataMap['password'];
        _emailaddress = biodataMap['emailAddress'];
        _bankAccountNo = biodataMap['bankAccountNumber'];
        _adharCardNo = biodataMap['aadharCardNumber'];
        _ifscCode = biodataMap['ifscCode'];
        _voterCardNo = biodataMap['voterCardNumber'];
        _emailOtp = biodataMap['emailOtp'];
        _phoneOtp = biodataMap['phoneOtp'];
        _phoneNumber = biodataMap['phoneNumber'];

        List<dynamic> educationQualificationlst =biodataMap['educationQualification'];
        List<dynamic> extraQualificationlst = biodataMap['extraQualification'];
        curEducationRow = educationQualificationlst.length;
        curExtraQualRow = extraQualificationlst.length;

        for (int i = 0; i < curEducationRow; i++) {
          GroupEducationControllers group = GroupEducationControllers();
          group.percentageController.text =
          educationQualificationlst[i]['percentage'];
          group.gradeController.text = educationQualificationlst[i]['grade'];
          group.passignYearController.text =
          educationQualificationlst[i]['yearOfPassing'];
          group.boardController.text = educationQualificationlst[i]['board'];
          group.institutionController.text =
          educationQualificationlst[i]['instituteName'];
          group.examController.text = educationQualificationlst[i]['exam'];
          _lstGroupContollers.add(group);
        }
        print('lst length is ${_lstGroupContollers.length}');
        for (int i = 0; i < curExtraQualRow; i++) {
          GroupExtraQualControllers extraGroup = GroupExtraQualControllers();
          extraGroup.designationController.text =
          extraQualificationlst[i]['designation'];
          extraGroup.expMonthController.text =
          extraQualificationlst[i]['expMonth'];
          extraGroup.fromDateController.text =
          extraQualificationlst[i]['fromDate'];
          extraGroup.companyNameController.text =
          extraQualificationlst[i]['companyName'];
          _lstExtraQualControllers.add(extraGroup);
        }
      }
    }on FirebaseAuthException catch(error){
      Fluttertoast.showToast(msg: '$error');
      print('error at getData method');
    }


    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _saveForm() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      print('not valid');
      return;
    }

    _formKey.currentState!.save();

    //validation check
    for (int i = 0; i < curEducationRow; i++) {
      if (_lstGroupContollers[i].passignYearController.text.isEmpty ||
          _lstGroupContollers[i].gradeController.text.isEmpty ||
          _lstGroupContollers[i].percentageController.text.isEmpty ||
          _lstGroupContollers[i].boardController.text.isEmpty ||
          _lstGroupContollers[i].institutionController.text.isEmpty ||
          _lstGroupContollers[i].examController.text.isEmpty){
        Fluttertoast.showToast(msg:'Education Qualification is Required');
        return;}
    }
    //validation check
    for (int i = 0; i < curExtraQualRow; i++) {
      GroupExtraQualControllers tmpController = _lstExtraQualControllers[i];
      for (int i = 0; i < curExtraQualRow; i++) {
        if (tmpController.designationController.text.isEmpty ||
            tmpController.expMonthController.text.isEmpty ||
            tmpController.fromDateController.text.isEmpty ||
            tmpController.companyNameController.text.isEmpty){
          Fluttertoast.showToast(msg: 'Extra Qualification is required');
          return;
        }
      }
    }
    setState(() {
      _isLoading = true;
    });

    List<Map<String, dynamic>> tmpEduList = [];
    for (int i = 0; i < curEducationRow; i++) {
      GroupEducationControllers tmpEduController = _lstGroupContollers[i];
      tmpEduList.add({
        'exam': '${tmpEduController.examController.text}',
        'instituteName': '${tmpEduController.institutionController.text}',
        'board': '${tmpEduController.boardController.text}',
        'yearOfPassing': '${tmpEduController.passignYearController.text}',
        'grade': '${tmpEduController.gradeController.text}',
        'percentage': '${tmpEduController.percentageController.text}'
      });
    }

    List<Map<String, dynamic>> tmpExtraQualList = [];
    for (int i = 0; i < curExtraQualRow; i++) {
      GroupExtraQualControllers tmpExtraQualController =
          _lstExtraQualControllers[i];
      tmpExtraQualList.add({
        'companyName': '${tmpExtraQualController.companyNameController.text}',
        'fromDate': '${tmpExtraQualController.fromDateController.text}',
        'expMonth': '${tmpExtraQualController.expMonthController.text}',
        'designation': '${tmpExtraQualController.designationController.text}'
      });
    }
    final json = {
      'name': _teacherName,
      'courseCategory': _courseCategory,
      'subjectBased': _subjectBased,
      'password': _password,
      'emailAddress': _emailaddress,
      'emailOtp': _emailOtp,
      'phoneNumber': _phoneNumber,
      'phoneOtp': _phoneOtp,
      'address': _address,
      'voterCardNumber': _voterCardNo,
      'aadharCardNumber': _adharCardNo,
      'bankAccountNumber': _bankAccountNo,
      'ifscCode': _ifscCode,
      'educationQualification': tmpEduList,
      'extraQualification': tmpExtraQualList
    };

    try {
      final _setdocUser = await FirebaseFirestore.instance
          .collection('teachers')
          .doc(_userEmail)
          .collection('biodata')
          .doc(_userEmail)
          .get();

      if (!_setdocUser.exists) {
        final _docUser = await FirebaseFirestore.instance
            .collection('teachers')
            .doc(_userEmail)
            .collection('biodata')
            .doc(_userEmail);

        await _docUser.set(json);
      } else {
        final setdocUser = await FirebaseFirestore.instance
            .collection('teachers')
            .doc(_userEmail)
            .collection('biodata')
            .doc(_userEmail);
        await setdocUser.update(json);
      }
    } on FirebaseAuthException catch (error) {
      Fluttertoast.showToast(msg:' ${error}');
      print('error at save Form method');
    }

    setState(() {
      _isLoading = false;
    });
  }

  TextField _generateTextField(TextEditingController textController) {
    return TextField(
      controller: textController,
    );
  }
  List<Widget> getEduList(int index){
    return [
      Padding(
        padding: EdgeInsets.only(left: 2.5),
        child: _exams[index],
      ),
      Padding(
        padding: EdgeInsets.only(left: 2.5),
        child: _institutes[index],
      ),
      Padding(
        padding: EdgeInsets.only(left: 2.5),
        child: _grades[index],
      ),
      Padding(
        padding: EdgeInsets.only(left: 2.5),
        child: _passingYears[index],
      ),
      Padding(
        padding: EdgeInsets.only(left: 2.5),
        child: _percentage[index],
      ),
      Padding(
        padding: EdgeInsets.only(left: 2.5),
        child: _boards[index],
      ),
    ];
  }
  List<Widget> getListOfEducationTextField(int index) {


    if(index<_lstGroupContollers.length&& index<_exams.length)return getEduList(index);
    print(' lstGroupControllerLenght=${_lstGroupContollers.length} and examsLength=${_exams.length}');
    if (_lstGroupContollers.length == index) {

      GroupEducationControllers group = GroupEducationControllers();
      _lstGroupContollers.add(group);
    }

    final examField = _generateTextField(_lstGroupContollers[index].examController);
    final institutionField = _generateTextField(_lstGroupContollers[index].institutionController);
    final boardField = _generateTextField(_lstGroupContollers[index].boardController);
    final percentageField = _generateTextField(_lstGroupContollers[index].percentageController);
    final gradeField = _generateTextField(_lstGroupContollers[index].gradeController);
    final passingYearField = _generateTextField(_lstGroupContollers[index].passignYearController);


         _exams.add(examField);
         _boards.add(boardField);
         _grades.add(gradeField);
         _institutes.add(institutionField);
         _passingYears.add(passingYearField);
         _percentage.add(percentageField);
      return getEduList(index);

  }

  List<Widget> getExtraQualList(int index){
    return [
      Padding(
        padding: EdgeInsets.only(left: 2.5),
        child: _nameOfCompany[index],
      ),
      Padding(
        padding: EdgeInsets.only(left: 2.5),
        child: _fromDate[index],
      ),
      Padding(
        padding: EdgeInsets.only(left: 2.5),
        child: _expMonth[index],
      ),
      Padding(padding: EdgeInsets.only(left: 2.5), child: _designation[index],),
    ];
  }

  List<Widget> getListOfExtraQualTextField(int index) {


    if(index<_lstExtraQualControllers.length && index<_nameOfCompany.length)return getExtraQualList(index);

    print(' extraQualLenght=${_lstExtraQualControllers.length} and designationLEngth=${_designation.length}');
    if(_lstExtraQualControllers.length==index){
      GroupExtraQualControllers group=GroupExtraQualControllers();
      _lstExtraQualControllers.add(group);
    }
    final nameOfCompanyField = _generateTextField(_lstExtraQualControllers[index].companyNameController);
    final fromDateField = _generateTextField(_lstExtraQualControllers[index].fromDateController);
    final expMonthField = _generateTextField(_lstExtraQualControllers[index].expMonthController);
    final designationField = _generateTextField(_lstExtraQualControllers[index].designationController);


      _nameOfCompany.add(nameOfCompanyField);
      _expMonth.add(expMonthField);
      _designation.add(designationField);
      _fromDate.add(fromDateField);

   return getExtraQualList(index);
  }

  TableRow _buildEducationRows(int i) {
    return TableRow(children: [
      ...getListOfEducationTextField(i),
      Container(
        child: Row(
          children: [
            IconButton(onPressed: () {}, icon: Icon(Icons.upload)),
          ],
        ),
      ),
    ]);
  }

  TableRow _buildExtraQualRows(int i) {
    return TableRow(children: [
      ...getListOfExtraQualTextField(i),
      Container(
        child: Row(
          children: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.upload)),
          ],
        ),
      ),
      Container(
        child: Row(
          children: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.upload)),
          ],
        ),
      )
    ]);
  }

  _buildHeaderRow(List<String> headerList) {
    return TableRow(
        children: headerList
            .map((e) => Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Center(
                      child: Text(
                    e,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  )),
                ))
            .toList());
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            primary: false,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Text(
                      "BIODATA",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 65,
                      ),
                    ),
                  ),
                  ListTile(
                      title: TextFormField(
                    initialValue: _teacherName,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('Teacher Name'),
                    ),
                    onSaved: (value) {
                      _teacherName = value!;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Name ';
                      }
                      return null;
                    },
                  )),
                  ListTile(
                      title: TextFormField(
                    initialValue: _courseCategory,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('Course Catogary'),
                    ),
                    onSaved: (value) {
                      _courseCategory = value!;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Course Category';
                      }
                      return null;
                    },
                  )),
                  ListTile(
                      title: TextFormField(
                    initialValue: _subjectBased,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('Subject Based'),
                    ),
                    onSaved: (value) {
                      _subjectBased = value!;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Subject Based';
                      }
                      return null;
                    },
                  )),
                  ListTile(
                      title: TextFormField(
                    initialValue: _password,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('Password'),
                    ),
                    onSaved: (value) {
                      _password = value!;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Password ';
                      }
                      return null;
                    },
                  )),
                  ListTile(
                      title: TextFormField(
                    initialValue: _emailaddress,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('Email Address'),
                    ),
                    onSaved: (value) {
                      _emailaddress = value!;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Email Address';
                      }
                      return null;
                    },
                  )),
                  ListTile(
                      title: TextFormField(
                    initialValue: _emailOtp,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('Email OTP'),
                    ),
                    onSaved: (value) {
                      _emailOtp = value!;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Email Otp ';
                      }
                      return null;
                    },
                  )),
                  ListTile(
                      title: TextFormField(
                    initialValue: _phoneNumber,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('Phone Number'),
                    ),
                    onSaved: (value) {
                      _phoneNumber = value!;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Phone ';
                      }
                      return null;
                    },
                  )),
                  ListTile(
                      title: TextFormField(
                    initialValue: _phoneOtp,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('Phone OTP'),
                    ),
                    onSaved: (value) {
                      _phoneOtp = value!;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Phone OTP';
                      }
                      return null;
                    },
                  )),
                  ListTile(
                      title: TextFormField(
                    initialValue: _address,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('Address'),
                    ),
                    onSaved: (value) {
                      _address = value!;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Address';
                      }
                      return null;
                    },
                  )),
                  ListTile(
                      title: TextFormField(
                    initialValue: _voterCardNo,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('Voter Card Number'),
                    ),
                    onSaved: (value) {
                      _voterCardNo = value!;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Voter Card Number';
                      }
                      return null;
                    },
                  )),
                  ListTile(
                      title: TextFormField(
                    initialValue: _adharCardNo,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('Aadhar Card Number'),
                    ),
                    onSaved: (value) {
                      _adharCardNo = value!;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Aadhaar Card Number';
                      }
                      return null;
                    },
                  )),
                  ListTile(
                      title: TextFormField(
                    initialValue: _bankAccountNo,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('Bank Account Number'),
                    ),
                    onSaved: (value) {
                      _bankAccountNo = value!;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Bank Account Number';
                      }
                      return null;
                    },
                  )),
                  ListTile(
                      title: TextFormField(
                    initialValue: _ifscCode,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('IFSC Code'),
                    ),
                    onSaved: (value) {
                      _ifscCode = value!;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Ifsc Code';
                      }
                      return null;
                    },
                  )),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 4),
                            child: Text(
                              'Education Qualification',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 19),
                            ),
                          ),
                          Table(
                            border: TableBorder.all(),
                            // columnWidths: {
                            //   0:FractionColumnWidth(0.08),
                            //   1:FractionColumnWidth(0.20),
                            //   2:FractionColumnWidth(0.20),
                            //   3:FractionColumnWidth(0.15),
                            //   4:FractionColumnWidth(0.08),
                            //   5:FractionColumnWidth(0.08),
                            //   6:FractionColumnWidth(0.21)
                            // },
                            children: [
                              _buildHeaderRow([
                                'Exam',
                                'Name Of Institution',
                                'Board',
                                'Passing Year',
                                'grade',
                                'Percentage',
                                'Upload Document',
                              ]),
                              for (int i = 0; i < curEducationRow; i++)
                                _buildEducationRows(i),
                            ],
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 7),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        curEducationRow += 1;
                                      });
                                    },
                                    child: Text('Add Qualication'),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 7),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (curEducationRow >= 2) {
                                        setState(() {
                                          _boards.removeAt(curEducationRow - 1);
                                          _percentage
                                              .removeAt(curEducationRow - 1);
                                          _passingYears
                                              .removeAt(curEducationRow - 1);
                                          _grades.removeAt(curEducationRow - 1);
                                          _institutes
                                              .removeAt(curEducationRow - 1);
                                          _exams.removeAt(curEducationRow - 1);
                                          _lstGroupContollers
                                              .removeAt(curEducationRow - 1);
                                          curEducationRow -= 1;
                                        });
                                      }
                                    },
                                    child: const Text('Delete Qualification'),
                                  ),
                                ),
                              ]),
                          const SizedBox(
                            height: 13,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 3),
                            child: Text(
                              'Extra Qualification',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 19),
                            ),
                          ),
                          Table(
                            border: TableBorder.all(),
                            // columnWidths: {
                            //   0:FractionColumnWidth(0.08),
                            //   1:FractionColumnWidth(0.20),
                            //   2:FractionColumnWidth(0.20),
                            //   3:FractionColumnWidth(0.15),
                            //   4:FractionColumnWidth(0.08),
                            //   5:FractionColumnWidth(0.08),
                            //   6:FractionColumnWidth(0.21)
                            // },
                            children: [
                              _buildHeaderRow([
                                'Name Of Company',
                                'From date',
                                'Exp. in months',
                                'Designation',
                                'Last Monthly slip upload',
                                'Experience Certificate',
                              ]),
                              for (int i = 0; i < curExtraQualRow; i++)
                                _buildExtraQualRows(i),
                            ],
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 7),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        curExtraQualRow += 1;
                                      });
                                    },
                                    child: const Text('Add Qualification'),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 7),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (curExtraQualRow >= 2) {
                                        setState(() {
                                          _nameOfCompany
                                              .removeAt(curExtraQualRow - 1);
                                          _fromDate
                                              .removeAt(curExtraQualRow - 1);
                                          _expMonth
                                              .removeAt(curExtraQualRow - 1);
                                          _designation
                                              .removeAt(curExtraQualRow - 1);
                                          _lstExtraQualControllers
                                              .removeAt(curExtraQualRow - 1);
                                          curExtraQualRow -= 1;
                                        });
                                      }
                                    },
                                    child: const Text('Delete Qualification'),
                                  ),
                                ),
                              ]),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  ElevatedButton(
                    onPressed: _saveForm,
                    child: const Text("                 Save                "),
                    style: ElevatedButton.styleFrom(primary: Colors.green[400]),
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                ],
              ),
            ),
          );
  }
}

class GroupEducationControllers {
  TextEditingController examController = TextEditingController();
  TextEditingController institutionController = TextEditingController();
  TextEditingController boardController = TextEditingController();
  TextEditingController passignYearController = TextEditingController();
  TextEditingController gradeController = TextEditingController();
  TextEditingController percentageController = TextEditingController();

  void dispose() {
    examController.dispose();
    institutionController.dispose();
    boardController.dispose();
    passignYearController.dispose();
    gradeController.dispose();
    percentageController.dispose();
  }
}

class GroupExtraQualControllers {
  TextEditingController companyNameController = TextEditingController();
  TextEditingController fromDateController = TextEditingController();
  TextEditingController expMonthController = TextEditingController();
  TextEditingController designationController = TextEditingController();

  void dispose() {
    companyNameController.dispose();
    fromDateController.dispose();
    expMonthController.dispose();
    designationController.dispose();
  }
}
