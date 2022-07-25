import 'package:flutter/material.dart';
import 'package:qbox_admin/models/practice_model.dart';
import 'package:qbox_admin/widgets/question_paper_options_card.dart';

class QuestionPreview extends StatelessWidget {
  final Questions question;
  const QuestionPreview({Key? key, required this.question}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${question.id} . ${question.question!}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              QuestionPaperOptionsCard(
                option: question.options!.optionA!,
                correctAnswer: question.correctAnswers!.answerACorrect!,
              ),
              QuestionPaperOptionsCard(
                option: question.options!.optionB!,
                correctAnswer: question.correctAnswers!.answerBCorrect!,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              QuestionPaperOptionsCard(
                option: question.options!.optionC!,
                correctAnswer: question.correctAnswers!.answerCCorrect!,
              ),
              QuestionPaperOptionsCard(
                option: question.options!.optionD!,
                correctAnswer: question.correctAnswers!.answerDCorrect!,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Tip = ${question.tip}'),
              Text('Difficulty = ${question.difficulty}'),
            ],
          ),
          Text('Description = ${question.description}'),
          Text('Explanation = ${question.explanation}'),
          for (String tag in question.tags!) Text(tag),
        ],
      ),
    );
  }
}
