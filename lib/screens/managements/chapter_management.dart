import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../utilities/dimensions.dart';

class ChapterManagement extends StatefulWidget {
  const ChapterManagement({Key? key}) : super(key: key);

  @override
  State<ChapterManagement> createState() => _ChapterManagementState();
}

class _ChapterManagementState extends State<ChapterManagement> {
//  String? _chosenValue;
  String? _chosenCourse;
   String? _chosenCategory;
    String? _chosenBatch;
     String? _chosenChapter;

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
                  '          Chapter',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 32,
                  ),
                ),
                const Divider(
                 color: Colors.black,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children:  [
                    Column(
                      children: [
                         const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Text('Category', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),),
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
                              color: Colors.black87, style: BorderStyle.solid, width: 0.80),
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
                              child:  DropdownButtonHideUnderline(
                                child: DropdownButton(
                                   icon: const Visibility (visible:true, child: Icon(Icons.keyboard_arrow_down)),
                                  value: _chosenCategory,
                                  // isDense: true,
                                  items:
                                      snapshot.data!.docs.map((DocumentSnapshot doc) {
                                        Map<String, dynamic> data = doc.data() as Map<String , dynamic>;
                                    return  DropdownMenuItem<String>(
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
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Text('Course', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),),
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
                              color: Colors.black87, style: BorderStyle.solid, width: 0.80),
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
                              child:  DropdownButtonHideUnderline(
                                child: DropdownButton(
                                   icon: const Visibility (visible:true, child: Icon(Icons.keyboard_arrow_down)),
                                  value: _chosenCourse,
                                  // isDense: true,
                                  items:
                                      snapshot.data!.docs.map((DocumentSnapshot doc) {
                                        Map<String, dynamic> data = doc.data() as Map<String , dynamic>;
                                    return  DropdownMenuItem<String>(
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
              
              
                 Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children:  [
                    Column(
                      children: [
                         const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Text('Batch Name', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),),
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
                              color: Colors.black87, style: BorderStyle.solid, width: 0.80),
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
                              child:  DropdownButtonHideUnderline(
                                child: DropdownButton(
                                   icon: const Visibility (visible:true, child: Icon(Icons.keyboard_arrow_down)),
                                  value: _chosenBatch,
                                  // isDense: true,
                                  items:
                                      snapshot.data!.docs.map((DocumentSnapshot doc) {
                                        Map<String, dynamic> data = doc.data() as Map<String , dynamic>;
                                    return  DropdownMenuItem<String>(
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
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Text('Chapter', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),),
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
                              color: Colors.black87, style: BorderStyle.solid, width: 0.80),
                        ),
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                                            .collection('practice')
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
                              child:  DropdownButtonHideUnderline(
                                child: DropdownButton(
                                   icon: const Visibility (visible:true, child: Icon(Icons.keyboard_arrow_down)),
                                  value: _chosenChapter,
                                  // isDense: true,
                                  items:
                                      snapshot.data!.docs.map((DocumentSnapshot doc) {
                                        Map<String, dynamic> data = doc.data() as Map<String , dynamic>;
                                    return  DropdownMenuItem<String>(
                                       value: data['chapter'],
                                        child: Text(data['chapter']));
                                  }).toList(),
                                  hint: const Text("Select Chapter"),
                                  onChanged: (value) {
                                    setState(() {
                                      _chosenChapter = value as String?;
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
                      padding:  EdgeInsets.only(left: Dimensions.padding20 * 14, top: Dimensions.padding20 * 0.5, bottom: Dimensions.padding20 * 0.2),
                      child: Container(
                         height: 40,
                          width: Dimensions.width10 * 6,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: ElevatedButton(onPressed: () { 
                          
                        },
                   child: Text('Show Result'),),
                      ),
                    ),
                   
                  Text(
                  '          Chapter List',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 32,
                  ),
                ),
                const Divider(
                 color: Colors.amberAccent,
                ),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Text('Category', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),),
                    Text('Course', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),),
                    Text('Batch', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),),
                    Text('Chapter', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),),
                  ],
                ),
              
              
              Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
              
                children: [
                    Text('Row', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),),
                      Text('Course', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),),
                      Text('Batch', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w200),),
                      Text('Chapter', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w200),),
                ],
              ),
                                   Padding(
                      padding:  EdgeInsets.only(left: Dimensions.padding20 * 14, top: Dimensions.padding20 * 2, bottom: Dimensions.padding20 * 0.2),
                      child: Container(
                         height: 40,
                          width: Dimensions.width10 * 6,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: ElevatedButton(onPressed: () { 
                          
                        },
                   child: Text('Add New Chapter'),),
                      ),
                    ),
              ]
            ),
          ),
        ),
      )
    );
  }
}
