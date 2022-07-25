import 'package:flutter/material.dart';

class ConatinerWithLabel extends StatefulWidget {
  final String title;
  final List<Widget>? children;
  final int widthRatio;
  const ConatinerWithLabel(
      {Key? key, required this.title, this.children, required this.widthRatio})
      : super(key: key);

  @override
  State<ConatinerWithLabel> createState() => _ConatinerWithLabelState();
}

class _ConatinerWithLabelState extends State<ConatinerWithLabel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * (8 / 22) * widget.widthRatio,
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * (1 / 153.6),
          vertical: MediaQuery.of(context).size.height * (5 / 792)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.amber.withOpacity(0.3),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${widget.title} : ',
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * (18 / 1536),
            ),
          ),
          Row(
            children: widget.children!,
          ),
        ],
      ),
    );
  }
}
