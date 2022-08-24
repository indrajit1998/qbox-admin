import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qbox_admin/models/practice_model.dart';
import 'package:qbox_admin/widgets/bottom_material_button.dart';
import 'package:qbox_admin/widgets/pop_up_text_field.dart';
import 'package:qbox_admin/widgets/question_paper_options_card.dart';

class QuestionPreview extends StatefulWidget {
  final Questions question;
  const QuestionPreview({Key? key, required this.question}) : super(key: key);

  @override
  State<QuestionPreview> createState() => _QuestionPreviewState();
}

class _QuestionPreviewState extends State<QuestionPreview> {
  bool valueA = false;
  bool valueB = false;
  bool valueC = false;
  bool valueD = false;

  
  @override
  Widget build(BuildContext context) {
    
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Container(
              // height: 100,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.black12,
              ),
              child: 
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
           
                  Text(
                  '${widget.question.question!}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
            ),
                ],
              ),
              ),
            
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                QuestionPaperOptionsCard(
                  option: widget.question.options!.optionA!,
                  correctAnswer: widget.question.correctAnswers!.answerACorrect!,
                ),
                // SizedBox(width: 10), //SizedBox
                        Checkbox(
                          value: this.valueA,
                          onChanged: (bool? value) {
                            setState(() {
                              this.valueA = value!;
                            });
                          },
                        ), //
                QuestionPaperOptionsCard(
                  option: widget.question.options!.optionB!,
                  correctAnswer: widget.question.correctAnswers!.answerBCorrect!,
                ),
                 Checkbox(
                          value: this.valueB,
                          onChanged: (bool? value) {
                            setState(() {
                              this.valueB = value!;
                            });
                          },
                        ), 
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // _optionStyle(),
                QuestionPaperOptionsCard(
                  
                  option: widget.question.options!.optionC!,
                  correctAnswer: widget.question.correctAnswers!.answerCCorrect!,
                ),
                 Checkbox(
                          value: this.valueC,
                          onChanged: (bool? value) {
                            setState(() {
                              this.valueC = value!;
                            });
                          },
                        ), 
                QuestionPaperOptionsCard(
                  option: widget.question.options!.optionD!,
                  correctAnswer: widget.question.correctAnswers!.answerDCorrect!,
                ),
                 Checkbox(
                          value: this.valueD,
                          onChanged: (bool? value) {
                            setState(() {
                              this.valueD = value!;
                            });
                          },
                        ), 
              ],
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: [
            //     Text('Tip = ${question.tip}'),
            //     Text('Difficulty = ${question.difficulty}'),
            //   ],
            // ),
            SizedBox(height: 5,),
            Container(
              height: 100,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.black12,
              ),
              child: Text('Description = ${widget.question.description}')),
              SizedBox(height: 10,),
                Container(
              height: 100,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.black12,
              ),
              child: Text('Explanation = ${widget.question.explanation}')),
              SizedBox(height: 5,),
            // Text('Explanation = ${question.explanation}'),
            for (String tag in widget.question.tags!) Text(tag),














          
          ],
        ),
      ),
    );
  }
}
