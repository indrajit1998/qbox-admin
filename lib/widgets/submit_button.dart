import 'package:flutter/material.dart';

class SubmitButton extends StatefulWidget {
  final String text;
  final Function onPressed;
  const SubmitButton({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  State<SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.amberAccent,
      elevation: 4,
      type: MaterialType.button,
      child: MaterialButton(
        onPressed: widget.onPressed(),
        padding: EdgeInsets.all(MediaQuery.of(context).size.width / 76.8),
        child: Text(
          widget.text,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width / 86,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
