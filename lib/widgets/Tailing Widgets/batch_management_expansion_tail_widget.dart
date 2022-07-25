import 'package:flutter/material.dart';
import 'package:qbox_admin/utilities/dimensions.dart';
import 'package:qbox_admin/widgets/pop_up_text_field.dart';
import 'package:qbox_admin/widgets/submit_button.dart';

class BatchManagementExpansionTailWidget extends StatefulWidget {
  const BatchManagementExpansionTailWidget({
    Key? key,
    required bool customTileExpanded,
  })  : _customTileExpanded = customTileExpanded,
        super(key: key);

  final bool _customTileExpanded;

  @override
  State<BatchManagementExpansionTailWidget> createState() =>
      _BatchManagementExpansionTailWidgetState();
}

class _BatchManagementExpansionTailWidgetState
    extends State<BatchManagementExpansionTailWidget> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Set<String> teachersList = {};
  String teacherDropDownValue = 'Teacher 1';

  var teacherItems = [
    'Teacher 1',
    'Teacher 2',
    'Teacher 3',
    'Teacher 4',
    'Teacher 5'
  ];
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Center(
                    child: SingleChildScrollView(
                      child: StatefulBuilder(builder:
                          (BuildContext context, StateSetter setState) {
                        return AlertDialog(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Add New Course Category'),
                              IconButton(
                                  onPressed: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .pop();
                                  },
                                  icon: const Icon(Icons.close_rounded))
                            ],
                          ),
                          contentPadding: EdgeInsets.all(
                              MediaQuery.of(context).size.width * (2 / 153.6)),
                          content: SizedBox(
                            width: MediaQuery.of(context).size.width *
                                (700 / 1563),
                            child: Form(
                              key: formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Divider(
                                    color: Colors.amber,
                                  ),
                                  const PopUpTextField(
                                    hint: 'Batch S',
                                    label: 'Batch Name',
                                    widthRatio: 2,
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(
                                        MediaQuery.of(context).size.width *
                                            (1 / 153.6)),
                                    width: double.maxFinite,
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            MediaQuery.of(context).size.width *
                                                (1 / 153.6),
                                        vertical:
                                            MediaQuery.of(context).size.height *
                                                (5 / 792)),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.grey.withOpacity(0.15),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Teachers  :',
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                (18 / 1536),
                                          ),
                                        ),
                                        DropdownButton(
                                          elevation: 0,
                                          dropdownColor: Colors.white,
                                          focusColor: Colors.white,
                                          value: teacherDropDownValue,
                                          items:
                                              teacherItems.map((String items) {
                                            return DropdownMenuItem(
                                              value: items,
                                              child: Text(items),
                                            );
                                          }).toList(),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              teacherDropDownValue = newValue!;
                                              teachersList.add(newValue);
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  Wrap(
                                    direction: Axis.horizontal,
                                    alignment: WrapAlignment.center,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      for (String teacher in teachersList)
                                        UnconstrainedBox(
                                          child: Container(
                                            margin: EdgeInsets.all(
                                                Dimensions.padding20 / 10),
                                            padding: EdgeInsets.only(
                                                left:
                                                    Dimensions.padding20 / 10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: Colors.amberAccent,
                                              border: Border.all(
                                                  color: Colors.black87),
                                            ),
                                            child: Row(
                                              children: [
                                                Text(teacher),
                                                IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      teachersList
                                                          .remove(teacher);
                                                    });
                                                  },
                                                  icon: const Icon(
                                                    Icons.close_rounded,
                                                    color: Colors.black87,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          actions: [
                            SubmitButton(text: 'Add Batch', onPressed: () {}),
                          ],
                        );
                      }),
                    ),
                  );
                });
          },
          icon: const Icon(Icons.add_circle_outline),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * (1 / 153.6),
        ),
        Icon(
          widget._customTileExpanded
              ? Icons.keyboard_arrow_up_outlined
              : Icons.keyboard_arrow_down_outlined,
        ),
      ],
    );
  }
}
