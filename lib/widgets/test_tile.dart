import 'package:flutter/material.dart';
import 'package:qbox_admin/widgets/pop_up_text_field.dart';
import 'package:qbox_admin/widgets/submit_button.dart';

class TestTile extends StatelessWidget {
  const TestTile({Key? key, required this.title, this.download = false})
      : super(key: key);
  final String title;
  final bool download;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: IconButton(
        onPressed: () {
          download
              ? null
              : showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return SingleChildScrollView(
                      child: AlertDialog(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(title),
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
                          width:
                              MediaQuery.of(context).size.width * (700 / 1563),
                          child: Wrap(
                            children: [
                              const Divider(
                                color: Colors.amber,
                              ),
                              PopUpTextField(
                                  hint: title,
                                  label: 'Test Name',
                                  widthRatio: 2),
                              const PopUpTextField(
                                  hint: '60 min',
                                  label: 'Test Duration',
                                  widthRatio: 1),
                              const PopUpTextField(
                                  hint: 'DD-MM-YYYY-HH-mm',
                                  label: 'Start Date',
                                  widthRatio: 1),
                              const Divider(
                                color: Colors.amber,
                              ),
                              const PopUpTextField(
                                hint: 'API means',
                                label: 'Question',
                                widthRatio: 2,
                              ),
                              const PopUpTextField(
                                hint: '',
                                label: 'Option 1',
                                widthRatio: 1,
                              ),
                              const PopUpTextField(
                                hint: '',
                                label: 'Option 2',
                                widthRatio: 1,
                              ),
                              const PopUpTextField(
                                hint: '',
                                label: 'Option 3',
                                widthRatio: 1,
                              ),
                              const PopUpTextField(
                                hint: '',
                                label: 'Option 4',
                                widthRatio: 1,
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SubmitButton(
                                text: 'Preview Paper',
                                onPressed: () {},
                              ),
                              SubmitButton(
                                text: 'Add Question',
                                onPressed: () {},
                              ),
                              SubmitButton(
                                text: 'Submit',
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  });
        },
        icon: download
            ? const Icon(Icons.download_rounded)
            : const Icon(Icons.mode_edit_rounded),
      ),
    );
  }
}
