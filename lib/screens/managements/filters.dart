import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:qbox_admin/widgets/bottom_material_button.dart';

import '../../widgets/pop_up_text_field.dart';

class ContentFilterPage extends StatefulWidget {
  const ContentFilterPage({Key? key}) : super(key: key);

  @override
  State<ContentFilterPage> createState() => _ContentFilterPageState();
}

class _ContentFilterPageState extends State<ContentFilterPage> {
  TextEditingController courseController = TextEditingController();
  TextEditingController catController = TextEditingController();
  TextEditingController batchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding:
            EdgeInsets.all(MediaQuery.of(context).size.width * (1 / 153.6)),
        child: Column(
          children: [
            Text(
              'Search Content',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width / 32,
              ),
            ),
            const Divider(
              color: Colors.amberAccent,
            ),
            const Spacer(),
            BottomMaterialButton(
              text: 'Add Filter',
              popUpChild: Column(children: [
                PopUpTextField(
                  controller: catController,
                  hint: 'Category',
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
                  controller: courseController,
                  hint: 'Course',
                  label: 'Course',
                  widthRatio: 1,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return ("Field cannot be empty");
                    }
                    return null;
                  },
                ),
                PopUpTextField(
                  controller: batchController,
                  hint: 'Batch',
                  label: 'Batch',
                  widthRatio: 1,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return ("Field cannot be empty");
                    }
                    return null;
                  },
                ),
              ]),
              popUpactions: [
                Material(
                  type: MaterialType.button,
                  color: Colors.amberAccent,
                  child: MaterialButton(
                    onPressed: (() {}),
                    child: const Text('apply'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
