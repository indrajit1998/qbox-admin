import 'package:flutter/material.dart';
import 'package:qbox_admin/models/level_up_series_model.dart';
import 'package:qbox_admin/widgets/question_paper_options_card.dart';

class LevelUpQuestionPreview extends StatelessWidget {
  final QuestionsList question;

  const LevelUpQuestionPreview({Key? key, required this.question})
      : super(key: key);

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
              Card(
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    width: MediaQuery.of(context).size.width * (408 / 1563),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                        question.correctAnswers!.answerACorrect!.toString())),
              ),
              Card(
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    width: MediaQuery.of(context).size.width * (408 / 1563),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                        question.correctAnswers!.answerBCorrect!.toString())),
              )
              // QuestionPaperOptionsCard(
              //   option: question.answers!.answerA.toString(),
              //   correctAnswer: question.correctAnswers!.answerACorrect!,
              // ),
              // QuestionPaperOptionsCard(
              //   option: question.answers!.answerB.toString(),
              //   correctAnswer: question.correctAnswers!.answerBCorrect!,
              // ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Card(
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    width: MediaQuery.of(context).size.width * (408 / 1563),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                        question.correctAnswers!.answerCCorrect!.toString())),
              ),
              Card(
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    width: MediaQuery.of(context).size.width * (408 / 1563),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                        question.correctAnswers!.answerDCorrect!.toString())),
              )
              // QuestionPaperOptionsCard(
              //   option: question.answers!.answerC.toString(),
              //   correctAnswer: question.correctAnswers!.answerCCorrect!,
              // ),

              // QuestionPaperOptionsCard(
              //   option: question.answers!.answerD,
              //   correctAnswer: question.correctAnswers!.answerDCorrect!,
              // ),
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
