import 'package:flutter/material.dart';
import 'package:qbox_admin/models/practice_model.dart';
import 'package:qbox_admin/screens/question_paper_preview.dart';

class HorizontalCard extends StatelessWidget {
  final PracticeModel model;

  const HorizontalCard({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => QuestionPaperPreview(
                    questionPaper: model,
                    category: model.category.toString(),
                    chapter: model.chapter.toString(),
                    cid: model.cid.toString(),
                    course: model.course.toString(),
                    publishDate: model.publishDate.toString(),
                    subject: model.subject.toString(),
                    updateDate: model.updateDate.toString(),
                  )),
        );
      },
      child: Card(
        margin: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Theme.of(context).colorScheme.outline,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: Container(
          width: 300,
          height: 100,
          padding: const EdgeInsets.all(17.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    model.category!.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    model.course!.toUpperCase(),
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                model.chapter!,
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).primaryColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
