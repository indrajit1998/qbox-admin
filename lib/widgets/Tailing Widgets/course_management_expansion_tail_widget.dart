import 'package:flutter/material.dart';
import 'package:qbox_admin/widgets/pop_up_text_field.dart';
import 'package:qbox_admin/widgets/submit_button.dart';

class CourseManagementExpansionTailWidget extends StatelessWidget {
  const CourseManagementExpansionTailWidget({
    Key? key,
    required bool customTileExpanded,
  })  : _customTileExpanded = customTileExpanded,
        super(key: key);

  final bool _customTileExpanded;

  @override
  Widget build(BuildContext context) {
    final TextEditingController courseController = TextEditingController();
    final TextEditingController oneMonthFeeController = TextEditingController();
    final TextEditingController sixMonthController = TextEditingController();
    final TextEditingController oneYearFeeController = TextEditingController();
    final TextEditingController twoYearFeeController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
                      child: AlertDialog(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Add Course'),
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
                        content: Form(
                          key: formKey,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width *
                                (700 / 1563),
                            child: Wrap(
                              children: [
                                const Divider(
                                  color: Colors.amber,
                                ),
                                PopUpTextField(
                                    controller: courseController,
                                    hint: 'Course Name',
                                    label: 'Course Name',
                                    widthRatio: 2),
                                PopUpTextField(
                                    controller: oneMonthFeeController,
                                    hint: 'Rs.3000',
                                    label: 'Course Payment for 1 Month',
                                    widthRatio: 1),
                                PopUpTextField(
                                    controller: sixMonthController,
                                    hint: 'Rs.3000',
                                    label: 'Course Payment for 6 Month',
                                    widthRatio: 1),
                                PopUpTextField(
                                    controller: oneYearFeeController,
                                    hint: 'Rs.24000',
                                    label: 'Course Payment for 1 Year',
                                    widthRatio: 1),
                                PopUpTextField(
                                    controller: twoYearFeeController,
                                    hint: 'Rs.24000',
                                    label: 'Course Payment for 2 Years',
                                    widthRatio: 1),
                              ],
                            ),
                          ),
                        ),
                        actions: [
                          SubmitButton(text: 'Add Course', onPressed: () {}),
                        ],
                      ),
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
          _customTileExpanded
              ? Icons.keyboard_arrow_up_outlined
              : Icons.keyboard_arrow_down_outlined,
        ),
      ],
    );
  }
}
