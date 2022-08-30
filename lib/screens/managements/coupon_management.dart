import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qbox_admin/models/coupon_model.dart';
import 'package:qbox_admin/widgets/bottom_material_button.dart';
import 'package:qbox_admin/widgets/pop_up_text_field.dart';
import 'package:qbox_admin/models/category_model.dart';

class CouponManagement extends StatefulWidget {
  const CouponManagement({Key? key}) : super(key: key);

  @override
  State<CouponManagement> createState() => _CouponManagementState();
}

class _CouponManagementState extends State<CouponManagement> {
  final GlobalKey<FormState> _couponFormKey = GlobalKey<FormState>();
  final _couponNameController = TextEditingController();
  final _couponDiscountController = TextEditingController();
  final _couponCodeController = TextEditingController();
  final _couponCategoryController = TextEditingController();
  final _couponExpiryDateController = TextEditingController();
  final _couponDescriptionController = TextEditingController();
  final _courseDurationController = TextEditingController();
  String? selectedCourse;
  String? selectedCategory;
  List<String?> _category = [];
  List<String?> _allCourse = [];
  int index = 1;
  String? errorMessage;

  @override
  void initState() {
    getcategoryData();
    super.initState();
  }

  Future<void> getcategoryData() async {
    final querysnapshot =
        await FirebaseFirestore.instance.collection('cat').get();

    for (var docSnap in querysnapshot.docs) {
      Map<String, dynamic> data = docSnap.data() as Map<String, dynamic>;
      CategoryModel model = CategoryModel.fromJson(data);
      model.courses?.forEach((element) {
        _allCourse.add(element.courseName);
      });
      _category.add(data['title']);
    }
    // _selectCategory = _category.elementAt(0);
    // _selectCourse = allCourse.elementAt(0);
    // _selectBatch = batchList.elementAt(0);

    setState(() {});
  }

  Future<List> getData() async {
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('coupons');
    QuerySnapshot querySnapshot = await collectionRef.get();
    final allData = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();
    return allData;
  }

  bool isLoading = false;

  Widget getDropDownOptions(String title, List item, String? selection,Function setState) {
    return Container(
      width: MediaQuery.of(context).size.width * (700 / (1563*2))-30,//MediaQuery.of(context).size.width * (1 / 4),
      // height: MediaQuery.of(context).size.height * (1 / 15),
      margin: const EdgeInsets.symmetric(horizontal: 12,vertical: 3),
      //padding: const EdgeInsets.symmetric( horizontal: 5),
      decoration:
          BoxDecoration(border: Border.all(color: Colors.grey, width: 0.5),borderRadius: BorderRadius.all(Radius.circular(8))),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
            value: selection,
            isExpanded: true,
            iconSize: 35,
            icon: const Icon(
              Icons.arrow_drop_down,
              color: Colors.black,
            ),
            hint: Text('Select $title'),
            onChanged: (value) {
              setState(() {
                //selection=value;
                if (title == 'Category') {
                  selectedCategory = value;
                } else {
                  selectedCourse = value;
                }
              });
            },
            items: item.map((item) => _buildDropMenuItem(item)).toList()),
      ),
    );
  }

  DropdownMenuItem<String> _buildDropMenuItem(String item) {
    return DropdownMenuItem(
      alignment: AlignmentDirectional.topCenter,
      value: item,
      child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left:8.0,right: 10),
            child: Text(item),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    //print(MediaQuery.of(context).size.width); 1366
    return Scaffold(
      body: Container(
        padding:
            EdgeInsets.all(MediaQuery.of(context).size.width * (1 / 153.6)),
        child: Column(
          children: [
            Text(
              'Coupons',
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
                alignment: Alignment.topCenter,
                margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.width * (1 / 153.6),
                ),
                child: FutureBuilder(
                    future: getData(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.done &&
                          snapshot.hasData) {
                        List data = snapshot.data;
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SingleChildScrollView(
                            child: DataTable(
                              headingRowColor: MaterialStateColor.resolveWith(
                                (states) {
                                  return Colors.amber;
                                },
                              ),
                              columnSpacing:
                                  MediaQuery.of(context).size.width / 16.4,
                              columns: const [
                                DataColumn(
                                  label: Text('Serial No'),
                                ),
                                DataColumn(
                                  label: Text('Title'),
                                ),
                                DataColumn(
                                    label: Text(
                                  'Discount',
                                )),
                                DataColumn(
                                    label: Text(
                                  'Coupon Code',
                                )),
                                DataColumn(
                                    label: Text(
                                  'Category',
                                )),
                                DataColumn(
                                  label:Text('Course')
                                ),
                                DataColumn(
                                    label: Text(
                                  'Expiry Date',
                                )),
                                DataColumn(
                                    label: Text(
                                  'Description',
                                )),
                              ],
                              rows: data
                                  .map(
                                    ((rowData) => DataRow(
                                          cells: <DataCell>[
                                            DataCell(
                                              Text('${index++}'),
                                            ),
                                            DataCell(
                                              Text(rowData['title']),
                                            ),
                                            //Extracting from Map element the value
                                            DataCell(
                                              Text(rowData['discount']),
                                            ),
                                            DataCell(
                                              Text(rowData['couponCode']),
                                            ),
                                            DataCell(
                                              Text(rowData['category']),
                                            ),
                                            DataCell(
                                              Text(rowData['course'])
                                            ),
                                            DataCell(
                                              Text(rowData['expiryDate']),
                                            ),
                                            DataCell(
                                              Text(rowData['description']),
                                            ),
                                          ],
                                        )),
                                  )
                                  .toList(),
                            ),
                          ),
                        );
                      }
                      if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      }
                      return const Text('No Coupons');
                    }),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: BottomMaterialButton(
                text: 'Add Coupon',
                popUpChild: StatefulBuilder(
                  builder:(context,setSate)=> Form(
                    key: _couponFormKey,
                    child: Wrap(
                      children: [
                        const Divider(
                          color: Colors.amber,
                        ),
                        PopUpTextField(
                          controller: _couponNameController,
                          hint: 'Title',
                          label: 'Title',
                          widthRatio: 2,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ("Field cannot be empty");
                            }
                            return null;
                          },
                        ),
                        PopUpTextField(
                          controller: _couponDiscountController,
                          hint: '12%',
                          label: 'Discount',
                          widthRatio: 1,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ("Field cannot be empty");
                            }
                            return null;
                          },
                        ),
                        PopUpTextField(
                          controller: _courseDurationController,
                          hint: 'DD-MM-YYYY',
                          label: 'Course Duration',
                          widthRatio: 1,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ("Field cannot be empty");
                            }
                            return null;
                          },
                        ),
                        getDropDownOptions(
                            'Category', _category, selectedCategory,setSate),

                        getDropDownOptions('Course', _allCourse, selectedCourse,setSate),
                     
                        PopUpTextField(
                          controller: _couponExpiryDateController,
                          hint: 'DD-MM-YYYY',
                          label: 'Expiry Date',
                          widthRatio: 1,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ("Field cannot be empty");
                            }
                            return null;
                          },
                        ),
                        PopUpTextField(
                          controller: _couponDescriptionController,
                          hint: '',
                          label: 'Description',
                          widthRatio: 2,
                          maximumLines: 5,
                        ),
                      ],
                    ),
                  ),
                ),
                popUpactions: [
                  Material(
                    color: Colors.amberAccent,
                    elevation: 4,
                    type: MaterialType.button,
                    child: MaterialButton(
                      onPressed: () async {
                        if (_couponFormKey.currentState!.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                          try {
                            await FirebaseFirestore.instance
                                .collection('coupons')
                                .doc(_couponNameController.text.trim())
                                .set(CouponModel(
                                        title:
                                            _couponNameController.text.trim(),
                                        discount: _couponDiscountController.text
                                            .trim(),
                                        category:selectedCategory,
                                        course:selectedCourse,
                                        couponCode:
                                            _couponCodeController.text.trim(),
                                        description:
                                            _couponDescriptionController.text
                                                .trim(),
                                        expiryDate: _couponExpiryDateController
                                            .text
                                            .trim())
                                    .toJson())
                                .then((value) => print("Coupon Added"))
                                .catchError((error) {
                              // ignore: invalid_return_type_for_catch_error
                              return Fluttertoast.showToast(msg: error!);
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
                            isLoading = false;
                          });
                          Fluttertoast.showToast(
                              msg: "Coupon Added Successfully");
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
                              'Add Coupon',
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
          ],
        ),
      ),
    );
  }
}
