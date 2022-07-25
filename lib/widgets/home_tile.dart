import 'package:flutter/material.dart';

class HomeTile extends StatelessWidget {
  final String title;
  final Color color;

  const HomeTile({
    Key? key,
    required this.title,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        boxShadow: [
          if (color == Colors.amber)
            BoxShadow(
              color: const Color(0xff64646f).withOpacity(0.33),
              offset: const Offset(3, 3),
              blurRadius: 3,
            ),
        ],
      ),
      margin:
          EdgeInsets.only(bottom: MediaQuery.of(context).size.width / 153.6),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * (3 / 153.6)),
        title: Text(
          title,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width / 69.8181818,
          ),
        ),
      ),
    );
  }
}
