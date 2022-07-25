import 'package:flutter/material.dart';

class ShowPopUpBox extends StatelessWidget {
  final String title;
  final Widget? child;
  final List<Widget>? actions;
  const ShowPopUpBox({Key? key, required this.title, this.child, this.actions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            IconButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
                icon: const Icon(Icons.close_rounded))
          ],
        ),
        contentPadding:
            EdgeInsets.all(MediaQuery.of(context).size.width * (2 / 153.6)),
        content: Form(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * (700 / 1563),
            child: child,
          ),
        ),
        actions: actions,
      ),
    );
  }
}
