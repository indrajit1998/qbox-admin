import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qbox_admin/screens/managements/batch_management.dart';
import 'package:qbox_admin/screens/managements/coupon_management.dart';
import 'package:qbox_admin/screens/managements/course_management.dart';
import 'package:qbox_admin/screens/managements/free_video_management.dart';
import 'package:qbox_admin/screens/managements/level_up_management.dart';
import 'package:qbox_admin/screens/managements/practice_management.dart';
import 'package:qbox_admin/screens/managements/student_management.dart';
import 'package:qbox_admin/screens/managements/teacher_management.dart';
import 'package:qbox_admin/screens/managements/test_management.dart';
import 'package:qbox_admin/screens/managements/videos_management.dart';
import 'package:qbox_admin/widgets/home_tile.dart';

enum Management {
  courseManagement,
  batchManagement,
  studentManagement,
  fullLengthTestManagement,
  teacherManagement,
  couponManagement,
  videoManagement,
  freeVideosManagement,
  levelUpSeriesManagement,
  practiceQuestionManagement,
}

class HomePage extends StatefulWidget {
  static String routeName = 'homePage';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int bodyIndex = 0;
  Management selectManagement = Management.courseManagement;
  List<Widget> displayList = [];
  List<String> sideDisplayList = [];
  List sideManagementList = [];

  Future<String> getUserRole() async {
    final user = FirebaseAuth.instance.currentUser;
    String userEmail = user!.email.toString();
    final docData =
        FirebaseFirestore.instance.collection('teachers').doc(userEmail);
    final snapshot = await docData.get();
    if (snapshot.exists) {
      var data = snapshot.data() as Map<String, dynamic>;
      return data['role'] as String;
    }
    return '';
  }

  Future<List> getHomeList() async {
    String role = await getUserRole();
    if (role == 'Teacher') {
      displayList = <Widget>[] + teachersList;
      sideDisplayList = <String>[] + sideTeachersList;
      sideManagementList = [] + sideTeachersManagementList;
      return [teachersList, sideTeachersList, sideTeachersManagementList];
    } else if (role == 'Admin') {
      displayList = <Widget>[] + adminList;
      sideDisplayList = <String>[] + sideAdminList;
      sideManagementList = [] + sideAdminManagementList;
      return [adminList, sideAdminList, sideAdminManagementList];
    } else if (role == 'Super Admin') {
      displayList = <Widget>[] + adminList + teachersList;
      sideDisplayList = <String>[] + sideAdminList + sideTeachersList;
      sideManagementList =
          [] + sideAdminManagementList + sideTeachersManagementList;
      return [displayList, sideDisplayList, sideManagementList];
    }
    return [];
  }

  // Left Panel Display Name
  List<String> sideTeachersList = ['Free Videos', 'Practice'];

  List<String> sideAdminList = [
    'Courses ',
    'Batch',
    'Students',
    'Teachers',
    'Coupons',
    'Full Length Tests',
    'Level Up Tests',
    'Live Videos',
  ];
  // Left Panel Management List
  List sideTeachersManagementList = [
    Management.freeVideosManagement,
    Management.practiceQuestionManagement,
  ];

  List sideAdminManagementList = [
    Management.courseManagement,
    Management.batchManagement,
    Management.studentManagement,
    Management.teacherManagement,
    Management.couponManagement,
    Management.fullLengthTestManagement,
    Management.levelUpSeriesManagement,
    Management.videoManagement,
  ];

  // Right Panel Display List
  List<Widget> teachersList = [
    const FreeVideoManagement(),
    const PracticeManagement(),
  ];

  List<Widget> adminList = [
    const CourseManagement(),
    const BatchManagement(),
    const StudentManagement(),
    const TeacherManagement(),
    const CouponManagement(),
    const FullLengthTestManagement(),
    const LevelUpManagement(),
    const VideoManagement(),
  ];

  @override
  void initState() {
    super.initState();
    getUserRole();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        color: Colors.amber,
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width / 537.6,
                            vertical: MediaQuery.of(context).size.height / 198),
                        margin: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width / 537.6,
                            vertical: MediaQuery.of(context).size.height / 198),
                        child: GestureDetector(
                          onTap: () {},
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                radius: MediaQuery.of(context).size.width / 48,
                                child: Icon(
                                  Icons.person,
                                  size: MediaQuery.of(context).size.width / 48,
                                ),
                              ),
                              Text(
                                'Indrajit Sikdar',
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width / 70,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(),
                            ],
                          ),
                        ),
                      ),
                      FutureBuilder(
                          future: getHomeList(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            return ListView(
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.width / 153.6),
                              children: [
                                for (int i = 0; i < sideDisplayList.length; i++)
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        bodyIndex = i;
                                        selectManagement =
                                            sideManagementList[i];
                                      });
                                    },
                                    child: HomeTile(
                                      title: sideDisplayList[i],
                                      color: selectManagement ==
                                              sideManagementList[i]
                                          ? Colors.amber
                                          : Colors.white,
                                    ),
                                  ),
                              ],
                            );
                          }),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 9,
              child: Container(
                margin: EdgeInsets.all(
                    MediaQuery.of(context).size.width * (2 / 153.6)),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      offset: const Offset(0, 19),
                      blurRadius: 28,
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.38),
                      offset: const Offset(0, 15),
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: FutureBuilder(
                    future: getHomeList(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.connectionState == ConnectionState.waiting &&
                          !snapshot.hasData) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text('Trying To Fetching Data'),
                              CircularProgressIndicator(),
                            ],
                          ),
                        );
                      }
                      if (snapshot.connectionState == ConnectionState.done &&
                          !snapshot.hasData) {
                        return const Center(
                          child: Text(
                            'No Data is Available for you. Please Contact the Academics staff\n(Try to Refresh the Page)',
                            textAlign: TextAlign.center,
                          ),
                        );
                      }
                      return displayList[bodyIndex];
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
