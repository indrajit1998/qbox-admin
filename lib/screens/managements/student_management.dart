import 'dart:io';
import 'package:flutter/Foundation.dart' show kIsWeb;
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:universal_html/html.dart' as AnchorElement;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Column,Row,Alignment,Border;//as xlsio;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';


class StudentManagement extends StatefulWidget {
  const StudentManagement({Key? key}) : super(key: key);

  @override
  State<StudentManagement> createState() => _StudentManagementState();
}

class _StudentManagementState extends State<StudentManagement> {

  DateTime? _startDate ;
  DateTime? _toDate;
  final _scrollController=ScrollController();

  //   Future<String> getUserImagePath(String userEmail, String fileName) async {
  //   final userRef = FirebaseStorage.instance.ref();
  //   String urlPath = 'users/$userEmail/UserProfile/$fileName';
  //   final userProfileUrl = await userRef.child(urlPath).getDownloadURL();
  //   return userProfileUrl == Null ? '' : userProfileUrl;
  // }
  //AsyncSnapshot<QuerySnapshot>? latestSnapshot;

  List? lst;
   Future<List<ExcelDataRow>> _buildExcelSheet() async{
  List<ExcelDataRow> excelDataRows = <ExcelDataRow>[];
   excelDataRows=lst!.map<ExcelDataRow>((dataRow) {
     List tmpListCourse= [];
     dataRow['selectedCourse'].map(
     (e){
       tmpListCourse.add(e['courseName']);
     }).toList();

     return ExcelDataRow(cells: [
     ExcelDataCell(columnHeader: 'Name', value: dataRow['firstName']),
     ExcelDataCell(columnHeader: 'Email', value: dataRow['email']),
     ExcelDataCell(columnHeader: 'Phone', value: dataRow['phone']),
     ExcelDataCell(columnHeader: 'Signup Date', value: dataRow['dateOfJoin']),
     ExcelDataCell(columnHeader: 'Courses', value: tmpListCourse)
  ]);} ).toList();

   return excelDataRows;
  }


  Future<void> _createExcel() async{
    final Workbook workbook = Workbook();

    final Worksheet sheet= workbook.worksheets[0];

    final Future<List<ExcelDataRow>> dataRows=_buildExcelSheet();
    List<ExcelDataRow> dataRows_1 = await Future.value(dataRows);
    sheet.importData(dataRows_1, 1, 1);
    sheet.getRangeByName('A1:E1').autoFitColumns();

    final List<int> bytes =workbook.saveAsStream();
    workbook.dispose();

    if(kIsWeb){
      AnchorElement.AnchorElement(href: "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}")..setAttribute('download', 'QBoxStudentDetail.xlsx')..click();

    }else {
      final String path = (await getApplicationSupportDirectory()).path;
      final String fileName =Platform.isWindows?'$path\\Output.xlsx': '$path/Output.xlsx';

      final File file = File(fileName);
      await file.writeAsBytes(bytes, flush: true);
      OpenFile.open(fileName);
    }
  }

  //Link to know Excel Workbook Sample
  //https://www.syncfusion.com/kb/12624/how-to-import-data-into-excel-using-listt-in-flutter#:~:text=Syncfusion%20Flutter%20XlsIO%20library%20is%20used%20to%20create,Step%201%3A%20Create%20a%20new%20Flutter%20application%20project.

  List<DataRow> _getRowList(AsyncSnapshot<QuerySnapshot> snapshot ){
     lst= snapshot.data!.docs;
    if(_startDate!=null && _toDate!=null){
      lst!.removeWhere((element){
        if(DateTime.parse(element['dateOfJoin']).isAfter(_startDate!) && DateTime.parse(element['dateOfJoin']).isBefore(_toDate!)){

          return false;
        }

        return true;
      });
    }
     int index=1;
    return lst!.map((rowData) {
      return DataRow(
          color: MaterialStateColor.resolveWith(
              (states) => Colors.black12),
          cells: <DataCell>[
            DataCell(Text('${index++}')),
            DataCell(FutureBuilder(
              //  future: getUserImagePath(data['email'],
              //     data['profileImageName']),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print(
                      'Something went wrong!+ ${snapshot.error}');
                  return const Icon(
                    Icons.person,
                  );
                }
                if (snapshot.connectionState ==
                        ConnectionState.done &&
                    snapshot.hasData) {
                  return CircleAvatar(
                    backgroundImage: NetworkImage(
                      snapshot.data.toString(),
                    ),
                  );
                }
                return const Icon(
                  Icons.person,
                );
              },
            )),
            DataCell(Text(
                '${rowData['firstName']} ${rowData['lastName']}')),
            DataCell(Text(rowData['email'])),
            DataCell(Text(rowData['phone'])),
            DataCell(Text(rowData['dateOfJoin'])),
            DataCell(
              SingleChildScrollView(
                child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      ...rowData['selectedCourse']
                          .map(
                              (e) => Row(
                                children: [
                                  Icon(Icons.circle,size: 8,),
                                  Text('   ${e['courseName']}'),
                                ],
                              ))
                          .toList(),
                    ]),
              ),
              placeholder: true,
            )
          ]);
    }).toList();
  }

  void _presentDatePicker(String isStart) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            //Add check that toDate always after startDate
            lastDate: DateTime.now())//isStart=='start'?_toDate!=null?_toDate!:DateTime.now(): DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        if(isStart=='start'){
          if(_toDate!=null && pickedDate.isAfter(_toDate!)){
            Fluttertoast.showToast(msg: 'Pick Date Before End Date');
            return ;
          }
          _startDate=pickedDate;
        }else{
          if(_startDate!=null && pickedDate.isBefore(_startDate!)){
            Fluttertoast.showToast(msg: 'Pick Date After Start Date');
            return ;
          }
          _toDate=pickedDate;
        }

      });
    });
  }

  //time string 2022-08-01 13:14:02.802515
  Widget getTableList() {
    return Scrollbar(
      thumbVisibility: true,
      trackVisibility: true,
      controller: _scrollController,
      child: SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('users').snapshots(),
            //where('dateOfJoin',isGreaterThanOrEqualTo: _startDate).snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something is wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasData) {

                double screenWidth=MediaQuery.of(context).size.width;
                double columnSpacingWidth;
                if(screenWidth>1376){
                  columnSpacingWidth=screenWidth/11.5;
                }else{
                  columnSpacingWidth=screenWidth/22.7;
                }
                return SingleChildScrollView(
                  primary: false,
                  child: Theme(
                    data: Theme.of(context).copyWith(dividerColor: Colors.white),
                    child: DataTable(
                      columnSpacing: columnSpacingWidth,
                      dataRowHeight: 70,
                      columns: const [
                        DataColumn(label: Text('Serial No')),
                        DataColumn(label: Text('Image')),
                        DataColumn(
                          label: Text('Name'),
                        ),
                        DataColumn(
                          label: Text('Email'),
                        ),
                        DataColumn(
                          label: Text('Number'),
                        ),
                        DataColumn(
                          label: Text('SignUp Date'),
                        ),
                        DataColumn(
                          label: Text('Course'),
                        ),
                      ],
                      rows: _getRowList(snapshot),
                    ),
                  ),
                );
              }
              return const Text('No Student data');
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        padding:
            EdgeInsets.all(MediaQuery.of(context).size.width * (1 / 152.6)),
        child: Column(
          children: [
            Text(
              'Students Data',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width / 37,
              ),
            ),
            const Divider(
              color: Colors.amberAccent,
            ),
            Container(
                width: double.infinity,
                height: screenHeight / 3.2,
                padding: EdgeInsets.all(screenwidth * (1 / 95)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('From',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            GestureDetector(
                              onTap: () {
                                print('$screenHeight  $screenwidth');
                                _presentDatePicker('start');
                              },
                              child: Container(
                                width: screenwidth / 4.7,
                                height: screenHeight / 17,
                                alignment: Alignment.centerLeft,
                                margin:const EdgeInsets.symmetric(vertical: 5),
                                padding:const EdgeInsets.only(left: 3),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey)),
                                child: Text(_startDate == null
                                    ? ''
                                    : _startDate
                                        .toString()
                                        .replaceAll('00:00:00.000', '')),
                              ),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'To',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            GestureDetector(
                              onTap: () => _presentDatePicker('to'),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                width: screenwidth / 4.7,
                                height: screenHeight / 17,
                                margin:const EdgeInsets.symmetric(vertical: 5),
                                padding:const EdgeInsets.only(left: 3),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey)),
                                child: Text(_toDate == null
                                    ? ''
                                    : _toDate
                                        .toString()
                                        .replaceAll('00:00:00.000', '')),
                              ),
                            )
                          ],
                        ),
                        ElevatedButton(
                          onPressed: _createExcel,
                          child:const Text('Download Excel'),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.amber,
                              padding: EdgeInsets.symmetric(
                                  vertical: screenHeight/41.06, horizontal: screenwidth/24.83)),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _startDate=null;
                          _toDate=null;
                        });
                      },
                      child: Text('All Data'),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.amber,
                          padding: EdgeInsets.symmetric(
                              vertical: screenHeight/41.06, horizontal: screenwidth/24.83)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: screenHeight/65.7, bottom: 3),
                      child: Text(
                        _startDate!=null && _toDate!=null?'From ${_startDate.toString().split(' ').first} to ${_toDate.toString().split(' ').first}':'Daily Data',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: screenHeight / 42),
                      ),
                    ),
                    Divider(color: Colors.grey),
                  ],
                )),
            Expanded(
              child: Container(
                child: getTableList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
