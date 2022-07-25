import 'package:flutter/material.dart';
import 'package:qbox_admin/models/practice_model.dart';
import 'package:qbox_admin/widgets/question_preview.dart';

class QuestionPaperPreview extends StatelessWidget {
  static String routeName = 'questionPaperPreview';
  final PracticeModel questionPaper;
  const QuestionPaperPreview({Key? key, required this.questionPaper})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    questionPaper.category!,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    questionPaper.course!,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    questionPaper.chapter!,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ],
          ),
          elevation: 0,
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                for (var question in questionPaper.questions!)
                  QuestionPreview(
                    question: question,
                  ),
              ],
            ),
          ),
        ));
  }
}

class A3SheetContainer extends StatelessWidget {
  const A3SheetContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1 / (1.4142),
      child: Container(
        width: 700,
        margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * (30 / 792),
          bottom: MediaQuery.of(context).size.height * (30 / 792),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              offset: const Offset(0, 19),
              blurRadius: 28,
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.38),
              offset: const Offset(0, 15),
              blurRadius: 12,
            ),
          ],
        ),
      ),
    );
  }
}
