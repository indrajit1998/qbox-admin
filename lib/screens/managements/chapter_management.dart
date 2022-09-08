import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../utilities/dimensions.dart';
import '../../widgets/bottom_material_button.dart';

class ChapterManagement extends StatefulWidget {
  const ChapterManagement({Key? key}) : super(key: key);

  @override
  State<ChapterManagement> createState() => _ChapterManagementState();
}

class _ChapterManagementState extends State<ChapterManagement> {
  final GlobalKey<FormState> _chapterFormKey = GlobalKey<FormState>();
  TextEditingController _chapterController = TextEditingController();
    TextEditingController _chapterTextController = TextEditingController();
  TextEditingController _chapterDetailsController = TextEditingController();
  TextEditingController _subjectController = TextEditingController();

  bool isLoading = false;
  String? errorMessage;
  String? _chosenCourse;
  String? _chosenCategory;
  String? _chosenBatch;
  String? _chapterCourse;
  String? _chapterCategory;
  String? _chapterBatch;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.all(MediaQuery.of(context).size.width * (1 / 153.6)),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '        Chapter',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 32,
                  ),
                ),
                const Divider(
                  color: Colors.black,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Text(
                              'Category',
                              style: TextStyle(
                                  fontSize: 19, fontWeight: FontWeight.w600),
                            ),
                          ),
                          Container(
                            height: 50,
                            width: Dimensions.width10 * 10,
                            // padding: const EdgeInsets.all(5),
                            padding: EdgeInsets.symmetric(horizontal: 30.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15.0),
                              border: Border.all(
                                  color: Colors.black12,
                                  style: BorderStyle.solid,
                                  width: 0.80),
                            ),
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
                                  padding: EdgeInsets.all(15),
                                  child:  
                                  DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      icon: const Visibility(
                                          visible: true,
                                          child:
                                              Icon(Icons.keyboard_arrow_down)),
                                      value: _chapterCategory,
                                      // isDense: true,
                                      items: snapshot.data!.docs
                                          .map((DocumentSnapshot doc) {
                                        Map<String, dynamic> data =
                                            doc.data() as Map<String, dynamic>;
                                        return DropdownMenuItem<String>(
                                            value: data['title'],
                                            child: Text(data['title'])
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
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Text(
                              'Course',
                              style: TextStyle(
                                  fontSize: 19, fontWeight: FontWeight.w600),
                            ),
                          ),
                          Container(
                            height: 50,
                            width: Dimensions.width10 * 10,
                            // padding: const EdgeInsets.all(5),
                            padding: EdgeInsets.symmetric(horizontal: 30.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15.0),
                              border: Border.all(
                                  color: Colors.black12,
                                  style: BorderStyle.solid,
                                  width: 0.80),
                            ),
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
                                  padding: EdgeInsets.all(15),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      icon: const Visibility(
                                          visible: true,
                                          child:
                                              Icon(Icons.keyboard_arrow_down)),
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 7, horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Text(
                              'Batch Name',
                              style: TextStyle(
                                  fontSize: 19, fontWeight: FontWeight.w600),
                            ),
                          ),
                          Container(
                            height: 50,
                            width: Dimensions.width10 * 10,
                            // padding: const EdgeInsets.all(5),
                            padding: EdgeInsets.symmetric(horizontal: 30.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15.0),
                              border: Border.all(
                                  color: Colors.black12,
                                  style: BorderStyle.solid,
                                  width: 0.80),
                            ),
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
                                  padding: EdgeInsets.all(15),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      icon: const Visibility(
                                          visible: true,
                                          child:
                                              Icon(Icons.keyboard_arrow_down)),
                                      value: _chapterBatch,
                                      // isDense: true,
                                      items: snapshot.data!.docs
                                          .map((DocumentSnapshot doc) {
                                        Map<String, dynamic> data =
                                            doc.data() as Map<String, dynamic>;
                                        return DropdownMenuItem<String>(
                                            value: data['batch'],
                                            child: Text(data['batch']));
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
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Text(
                              'Chapter',
                              style: TextStyle(
                                  fontSize: 19, fontWeight: FontWeight.w600),
                            ),
                          ),
                          Container(
                            height: 50,
                            width: Dimensions.width10 * 10,
                            // padding: const EdgeInsets.all(5),
                            padding: EdgeInsets.symmetric(horizontal: 30.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15.0),
                              border: Border.all(
                                  color: Colors.black12,
                                  style: BorderStyle.solid,
                                  width: 0.80),
                            ),
                            child:  Container(
                                  height: 150,
                                  width: Dimensions.width10 * 10,
                                  padding: EdgeInsets.all(15),
                                  child: TextFormField(
                                    controller: _chapterTextController,
                                    
                                    decoration: InputDecoration(
                                      labelText: 'Chapter',
                                      border: InputBorder.none,
                                            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
                                    ),
                                  )
                            )
                            ),
                          
                        
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: Dimensions.padding20 * 14,
                      top: Dimensions.padding20 * 0.5,
                      bottom: Dimensions.padding20 * 0.2),
                  child: Container(
                    height: 40,
                    width: Dimensions.width10 * 6,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text('Show Result'),
                    ),
                  ),
                ),
                Text(
                  '        Chapter List',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 32,
                  ),
                ),
                const Divider(
                  color: Colors.amberAccent,
                ),

                _chapterList(),

                   GestureDetector(
                    onTap: () {
                      setState(() {
                        
                      });
                    },
                     child: Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 20),
                       child: Align(
                                   alignment: Alignment.bottomRight,
                                   child: BottomMaterialButton(
                                     text: 'Add Chapter',
                                     popUpChild: Form(
                                       key: _chapterFormKey,
                                       child: Wrap(
                        children: [
                          const Divider(
                            color: Colors.amber,
                          ),
                               Padding(
                                       padding:
                          const EdgeInsets.symmetric(vertical: 3,),
                                       child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 6),
                                child: Text(
                                  'Category',
                                  style: TextStyle(
                                      fontSize: 19, fontWeight: FontWeight.w600),
                                ),
                              ),
                              Container(
                                height: 50,
                                width: Dimensions.width10 * 6,
                                // padding: const EdgeInsets.all(5),
                                // padding: EdgeInsets.symmetric(horizontal: 3.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15.0),
                                  border: Border.all(
                                      color: Colors.black12,
                                      style: BorderStyle.solid,
                                      width: 0.80),
                                ),
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
                                      height: 50,
                                      width: Dimensions.width10 * 3,
                                      padding: EdgeInsets.all(15),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          icon: const Visibility(
                                              visible: true,
                                              child:
                                                  Icon(Icons.keyboard_arrow_down)),
                                          value: _chosenCategory,
                                          // isDense: true,
                                          items: snapshot.data!.docs
                                              .map((DocumentSnapshot doc) {
                                            Map<String, dynamic> data =
                                                doc.data() as Map<String, dynamic>;
                                            return DropdownMenuItem<String>(
                                                value: data['title'],
                                                child: Text(data['title']));
                                          }).toList(),
                                          hint: const Text("Choose Category"),
                                          onChanged: (value) {
                                            setState(() {
                                              _chosenCategory = value as String?;
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
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 6),
                                child: Text(
                                  'Course',
                                  style: TextStyle(
                                      fontSize: 19, fontWeight: FontWeight.w600),
                                ),
                              ),
                              Container(
                                height: 50,
                                width: Dimensions.width10 * 6,
                                // padding: const EdgeInsets.all(5),
                                // padding: EdgeInsets.symmetric(horizontal: 3.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15.0),
                                  border: Border.all(
                                      color: Colors.black12,
                                      style: BorderStyle.solid,
                                      width: 0.80),
                                ),
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
                                      height: 50,
                                      width: Dimensions.width10 * 3,
                                      padding: EdgeInsets.all(15),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          icon: const Visibility(
                                              visible: true,
                                              child:
                                                  Icon(Icons.keyboard_arrow_down)),
                                          value: _chosenCourse,
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
                                              _chosenCourse = value as String?;
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
                   
                                     Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceAround,
                                       children: [
                        Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                                        padding: EdgeInsets.symmetric(vertical: 6),
                                        child: Text(
                                          'Batch Name',
                                          style: TextStyle(
                                              fontSize: 19, fontWeight: FontWeight.w600),
                                        ),
                                      ),
                        
                                  Container(
                                    height: 50,
                                    width: Dimensions.width10 * 6,
                                    margin: const EdgeInsets.only(left: 4),
                                    // padding: const EdgeInsets.all(5),
                                    // padding: EdgeInsets.symmetric(horizontal: 4.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15.0),
                                      border: Border.all(
                                          color: Colors.black12,
                                          style: BorderStyle.solid,
                                          width: 0.80),
                                    ),
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
                                          height: 50,
                                          width: Dimensions.width10 * 3,
                                          padding: EdgeInsets.all(15),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton(
                                              icon: const Visibility(
                                                  visible: true,
                                                  child:
                                                      Icon(Icons.keyboard_arrow_down)),
                                              value: _chosenBatch,
                                              // isDense: true,
                                              items: snapshot.data!.docs
                                                  .map((DocumentSnapshot doc) {
                                                Map<String, dynamic> data =
                                                    doc.data() as Map<String, dynamic>;
                                                return DropdownMenuItem<String>(
                                                    value: data['batch'],
                                                    child: Text(data['batch']));
                                              }).toList(),
                                              hint: const Text("Batch Name"),
                                              onChanged: (value) {
                                                setState(() {
                                                  _chosenBatch = value as String?;
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
                             const Padding(
                                        padding: EdgeInsets.symmetric(vertical: 6),
                                        child: Text(
                                          'Chapter',
                                          style: TextStyle(
                                              fontSize: 19, fontWeight: FontWeight.w600),
                                        ),
                                      ),
                        
                                  Container(
                                    height: 50,
                                    width: Dimensions.width10 * 6,
                                    margin: EdgeInsets.only(left: 4),
                                    // padding: const EdgeInsets.all(5),
                                    padding: EdgeInsets.symmetric(horizontal: 4.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15.0),
                                      border: Border.all(
                                          color: Colors.black12,
                                          style: BorderStyle.solid,
                                          width: 0.80),
                                    ),
                                    child: TextFormField(
                                      controller: _chapterController,
                                       decoration: InputDecoration(
                                        border: InputBorder.none,
                                              hintText: 'Chapter',
                                              labelText: 'Chapter'
                                      ),
                                       validator: (value) {
                                  if (value!.isEmpty) {
                                      return ("Field cannot be empty");
                                  }
                                  return null;
                                },
                                    ),
                             
                                    ),
                          ],
                        )
                                       ],
                                     ),
                                      Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                              Padding(
                                       padding: EdgeInsets.symmetric(vertical: 6,horizontal: Dimensions.padding20 * 0.8),
                                        child: Text(
                                          'Subject',
                                          style: TextStyle(
                                              fontSize: 19, fontWeight: FontWeight.w600),
                                        ),
                                      ),
                        
                                  Container(
                                    height: 50,
                                    width: Dimensions.width10 * 17,
                                    margin: EdgeInsets.symmetric(horizontal: Dimensions.padding20 * 0.8),
                                    padding: EdgeInsets.symmetric(horizontal: 4.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15.0),
                                      border: Border.all(
                                          color: Colors.black12,
                                          style: BorderStyle.solid,
                                          width: 0.80),
                                    ),
                                    child: TextFormField(
                                      controller: _subjectController,
                                       decoration: InputDecoration(
                                        border: InputBorder.none,
                                              hintText: 'Subject Name',
                                              labelText: 'Subject'
                                      ),
                                       validator: (value) {
                                  if (value!.isEmpty) {
                                      return ("Field cannot be empty");
                                  }
                                  return null;
                                },
                                    ),
                             
                                    ),
                          ],
                        ),
                        SizedBox(height: 20,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:  [
                              Padding(
                                            padding: EdgeInsets.symmetric(vertical: 6,horizontal: Dimensions.padding20 * 0.8),
                                            child: Text(
                                              'Chapter Details',
                                              style: TextStyle(
                                                  fontSize: 19, fontWeight: FontWeight.w600),
                                            ),
                                          ),
                            
                          
                          
                        
                                  Container(
                                  
                                    margin: EdgeInsets.symmetric(horizontal: Dimensions.padding20 * 0.8),
                                    // padding: const EdgeInsets.all(5),
                                    padding: EdgeInsets.symmetric(horizontal: 4.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15.0),
                                      border: Border.all(
                                          color: Colors.black12,
                                          style: BorderStyle.solid,
                                          width: 0.80),
                                    ),
                                    child: TextFormField(
                                      controller: _chapterDetailsController,
                                       decoration: InputDecoration(
                                        border: InputBorder.none,
                                            labelText: 'Description',
                                            hintText: 'Chapter Description'
                                      ),
                                      maxLines: 5,
                                       validator: (value) {
                                  if (value!.isEmpty) {
                                      return ("Field cannot be empty");
                                  }
                                  return null;
                                },
                                    ),
                          
                          ),
                            ])
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
                            if (_chapterFormKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              try {
                                await  FirebaseFirestore.instance.collection('chapter').add({
                                      'category' : _chosenCategory,
                                      'course' : _chosenCourse,
                                      'subject': _subjectController.text,
                                      'batch' : _chosenBatch,
                                      'chapter' : _chapterController.text,
                                      'chapterDetails' : _chapterDetailsController.text.toString()
                                      })
                                     
                               .then((value) => print("User Added"))
                               .catchError((error) => print("Failed to add user: $error"));
                                setState(() {
                                        
                                      });
                                      _chapterController.clear();
                                      _chapterDetailsController.clear();
                                    _chapterTextController.clear();
                              } on FirebaseAuthException catch (error) {
                                switch (error.code) {
                                  default:
                                    errorMessage =
                                        "An undefined Error happened.+$error";
                                }
                                Fluttertoast.showToast(msg: errorMessage!);
                              }
                              setState(() {
                                isLoading = false;
                              });
                              Fluttertoast.showToast(
                                  msg: "Chapter Added Successfully");
                              if (!mounted) {
                                return;
                              }
                              Navigator.of(context, rootNavigator: true).pop();
                            }
                          },
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width / 76.8),
                          child: isLoading
                              ? const CircularProgressIndicator()
                              : Text(
                                  'Save',
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width / 86,
                                    color: Colors.black,
                                  ),
                                ),
                        ),
                                       )
                                     ],
                                   ),
                                 ),
                     ),
                   ),




              ]),
        ),
      ),
    ));
  }


  Widget _chapterList(){
    return  Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 2.3,
            margin: EdgeInsets.symmetric(vertical: 8),
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('chapter').snapshots(),
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
                            DataColumn(label: Text('Chapter')),
                            DataColumn(label: Text('Subject')),
                            DataColumn(label: Text('Chapter Details')),
                           
                          
                          ],
                          rows: snapshot.data!.docs
                              .map((rowData) => DataRow(
                                    color: MaterialStateColor.resolveWith(
                                        (states) => Colors.black12),
                                    cells: <DataCell>[
                                      DataCell(Text(rowData['category'])),
                                      DataCell(Text(rowData['course'])),
                                      DataCell(Text(rowData['batch'])),
                                      DataCell(Text(rowData['chapter'])),
                                       DataCell(Text(rowData['subject'])),
                                      DataCell(Text(rowData['chapterDetails'])),
                                     
                                    ],
                                  ))
                              .toList()),
                    ),
                  );
                }
                return Text('No Data');
              },
            ),
          );
  }
}
