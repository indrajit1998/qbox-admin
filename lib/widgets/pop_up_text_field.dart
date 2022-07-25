import 'package:flutter/material.dart';

class PopUpTextField extends StatelessWidget {
  final String hint;
  final String label;
  final int widthRatio;
  final TextEditingController? controller;
  final validator;
  final int? maximumLines;
  const PopUpTextField(
      {Key? key,
      required this.hint,
      required this.label,
      required this.widthRatio,
      this.controller,
      this.validator,
      this.maximumLines = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * (350 / 1563) * widthRatio,
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        validator: validator,
        maxLines: maximumLines,
        decoration: InputDecoration(
          hintText: hint,
          label: Text(label),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          fillColor: Colors.grey[100],
          filled: true,
        ),
      ),
    );
  }
}
