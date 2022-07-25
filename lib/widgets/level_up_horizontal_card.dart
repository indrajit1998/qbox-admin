import 'package:flutter/material.dart';
import 'package:qbox_admin/models/level_up_series_model.dart';
import 'package:qbox_admin/widgets/level_up_question_paper_preview.dart';

class LevelUpHorizontalCard extends StatelessWidget {
  final LevelUpTestModel model;

  const LevelUpHorizontalCard({Key? key, required this.model})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  LevelUpQuestionPaperPreview(questionPaper: model)),
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
              Text(
                model.testName!,
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).primaryColor),
              ),
              Text(
                model.chapter!,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
