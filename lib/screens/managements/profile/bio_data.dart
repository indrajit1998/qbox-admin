import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  var _userEmail;

  bool _isLoading = false;

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<void> getData() async {
    print('inide getData');
    _userEmail = FirebaseAuth.instance.currentUser!.email;
    setState(() {
      _isLoading=true;
    });
    final docUser = await FirebaseFirestore.instance
        .collection('teachers')
        .doc(_userEmail).collection('biodata').doc(_userEmail).get();

    if (docUser.exists &&docUser.data()!.isNotEmpty) {

      biodataMap = docUser.data()!;
      print('inside exists con ${biodataMap}');
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

      print('phone no.$_phoneNumber');

    }
    setState(() {
      _isLoading=false;
    });
    // FirebaseFirestore.instance
    //     .collection('teachers')
    //     .doc(_userEmail)
    //     .collection("biodata").doc(_userEmail)
    //     .get()
    //     .then((value) {
    //   setState(() {
    //
    //     biodataMap = value.data()!;
    //     print(biodataMap);
    //   });
    // });
  }

  Future<void> _saveForm() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      print('not valid');
      return;
    }

    _formKey.currentState!.save();

    setState(() {
      _isLoading = true;
    });
    final _setdocUser = await FirebaseFirestore.instance
        .collection('teachers')
        .doc(_userEmail).collection('biodata').doc(_userEmail).get();
    if (!_setdocUser.exists) {
      final _docUser = FirebaseFirestore.instance
          .collection('teachers')
          .doc(_userEmail)
          .collection('biodata')
          .doc(_userEmail);
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
        'ifscCode': _ifscCode
      };

      await _docUser.set(json);
    } else {
      final setdocUser = FirebaseFirestore.instance
          .collection('teachers')
          .doc(_userEmail)
          .collection('biodata')
          .doc(_userEmail);
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
        'ifscCode': _ifscCode
      };
      await setdocUser.update(json);
    }
    setState(() {
      _isLoading = false;
    });
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
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      "BIODATA",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 80,
                      ),
                    ),
                  ),
                  ListTile(
                      title: TextFormField(
                    initialValue: _teacherName,
                    decoration:const InputDecoration(
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
                    decoration:const InputDecoration(
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
                    decoration:const InputDecoration(
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
                    decoration:const InputDecoration(
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
                    decoration:const InputDecoration(
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
                    decoration:const InputDecoration(
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
                    decoration:const InputDecoration(
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
                    decoration:const InputDecoration(
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
                    decoration:const InputDecoration(
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
                    decoration:const InputDecoration(
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
                    decoration:const InputDecoration(
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
                    decoration:const InputDecoration(
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
                    decoration:const InputDecoration(
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
                  ElevatedButton(
                      onPressed: _saveForm, child: const Text("Edit")),
                  const SizedBox(height: 4,),
                ],
              ),
            ),
          );
  }
}
