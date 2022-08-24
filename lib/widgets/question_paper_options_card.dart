import 'package:flutter/material.dart';

class QuestionPaperOptionsCard extends StatelessWidget {
  final String option;
  final bool correctAnswer;
  const QuestionPaperOptionsCard(
      {Key? key, required this.option, required this.correctAnswer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        width: MediaQuery.of(context).size.width * (408 / 1563),
        decoration: BoxDecoration(
          color: correctAnswer ? Colors.black12 : Colors.black12,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          option,
        ),
      ),
    );
  }
}
