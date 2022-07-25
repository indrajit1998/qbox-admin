import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qbox_admin/models/coupon_model.dart';
import 'package:qbox_admin/widgets/bottom_material_button.dart';
import 'package:qbox_admin/widgets/pop_up_text_field.dart';

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
  int index = 1;
  String? errorMessage;

  Future<List> getData() async {
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('coupons');
    QuerySnapshot querySnapshot = await collectionRef.get();
    final allData = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();
    return allData;
  }

  @override
  Widget build(BuildContext context) {
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
                                            ), //Extracting from Map element the value
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
                popUpChild: Form(
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
                        controller: _couponCodeController,
                        hint: 'ZSCVFGV',
                        label: 'Coupon Code',
                        widthRatio: 1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Field cannot be empty");
                          }
                          return null;
                        },
                      ),
                      PopUpTextField(
                        controller: _couponCategoryController,
                        hint: 'Medical',
                        label: 'Category',
                        widthRatio: 1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Field cannot be empty");
                          }
                          return null;
                        },
                      ),
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
                popUpactions: [
                  Material(
                    color: Colors.amberAccent,
                    elevation: 4,
                    type: MaterialType.button,
                    child: MaterialButton(
                      onPressed: () async {
                        if (_couponFormKey.currentState!.validate()) {
                          try {
                            await FirebaseFirestore.instance
                                .collection('coupons')
                                .doc(_couponNameController.text.trim())
                                .set(CouponModel(
                                        title:
                                            _couponNameController.text.trim(),
                                        discount: _couponDiscountController.text
                                            .trim(),
                                        category: _couponCategoryController.text
                                            .trim(),
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
                      child: Text(
                        'Add Coupon',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 86,
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
