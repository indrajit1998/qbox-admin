import 'package:flutter/material.dart';
import 'package:qbox_admin/models/level_up_series_model.dart';
import 'package:qbox_admin/widgets/level_up_question_preview.dart';

class LevelUpQuestionPaperPreview extends StatelessWidget {
  static String routeName = 'questionPaperPreview';
  final LevelUpTestModel questionPaper;
  const LevelUpQuestionPaperPreview({Key? key, required this.questionPaper})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Category = ${questionPaper.category!}',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                Text(
                  'Course = ${questionPaper.course!}',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                Text(
                  'Chapter = ${questionPaper.chapter!}',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                questionPaper.questionsList!.isEmpty
                    ? const Center(
                        child: Text('NO Question Added'),
                      )
                    : const Text(''),
                for (var question in questionPaper.questionsList!)
                  LevelUpQuestionPreview(
                    question: question,
                  ),
              ],
            ),
          ),
        ));
  }
}
