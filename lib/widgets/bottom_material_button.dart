import 'package:flutter/material.dart';

class BottomMaterialButton extends StatefulWidget {
  final String text;
  final Widget? popUpChild;
  final List<Widget>? popUpactions;
  final Color? buttonColor;
  final bool? isPadding;
  const BottomMaterialButton(
      {Key? key,
      required this.text,
      this.popUpChild,
      this.popUpactions,
      this.buttonColor = Colors.amberAccent,
      this.isPadding = true})
      : super(key: key);

  @override
  State<BottomMaterialButton> createState() => _BottomMaterialButtonState();
}

class _BottomMaterialButtonState extends State<BottomMaterialButton> {
  double paddingRatio(bool isPadding) {
    return isPadding ? (1 / 76.8) : 0;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: widget.buttonColor,
      elevation: 4,
      type: MaterialType.button,
      child: MaterialButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return Center(
                  child: SingleChildScrollView(
                    child: StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                      return AlertDialog(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(widget.text),
                            IconButton(
                                onPressed: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                },
                                icon: const Icon(
                                  Icons.close_rounded,
                                  color: Colors.black87,
                                ))
                          ],
                        ),
                        contentPadding: EdgeInsets.all(
                            MediaQuery.of(context).size.width * (2 / 153.6)),
                        content: SizedBox(
                          width:
                              MediaQuery.of(context).size.width * (700 / 1563),
                          child: widget.popUpChild,
                        ),
                        actions: widget.popUpactions,
                      );
                    }),
                  ),
                );
              });
        },
        padding: EdgeInsets.all(MediaQuery.of(context).size.width *
            (paddingRatio(widget.isPadding!))),
        child: Text(
          widget.text,
          style: TextStyle(
              fontSize: MediaQuery.of(context).size.width / 86,
              color: Colors.black87),
        ),
      ),
    );
  }
}
