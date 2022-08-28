import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qbox_admin/models/practice_model.dart';
import 'package:qbox_admin/widgets/question_preview.dart';

import '../widgets/bottom_material_button.dart';
import '../widgets/pop_up_text_field.dart';

class QuestionPaperPreview extends StatefulWidget {
  static String routeName = 'questionPaperPreview';
  final PracticeModel questionPaper;
  const QuestionPaperPreview({Key? key, required this.questionPaper})
      : super(key: key);

  @override
  State<QuestionPaperPreview> createState() => _QuestionPaperPreviewState();
}

class _QuestionPaperPreviewState extends State<QuestionPaperPreview> {
   final _questionController = TextEditingController();
  final _optionAController = TextEditingController();
  final _optionBController = TextEditingController();
  final _optionCController = TextEditingController();
  final _optionDController = TextEditingController();
  final _multiCorrectAnswerController = TextEditingController();
  final _correctOptionAController = TextEditingController();
  final _correctOptionBController = TextEditingController();
  final _correctOptionCController = TextEditingController();
  final _correctOptionDController = TextEditingController();
  final _explanationController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _tipController = TextEditingController();
  final _difficultyController = TextEditingController();

  final GlobalKey<FormState> _questionAddScreenFormKey = GlobalKey<FormState>();

  List<Questions> questionsList = [];
  Set<String> tagsList = {"tag"};

  String? errorMessage;

  int questionsLength() {
    int length = 0;
    setState(() {
      length = questionsList.length;
    });
    return length;
  }
   bool multAnsCorrect = false;
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
                    widget.questionPaper.category!,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    widget.questionPaper.course!,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    widget.questionPaper.chapter!,
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
                for (var question in widget.questionPaper.questions!)
                  QuestionPreview(
                    question: question,
                  ),








                  

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BottomMaterialButton(
                    text: 'Add Question',
                    popUpChild: Form(
                      key: _questionAddScreenFormKey,
                      child: Wrap(
                        children: [
                          Divider(
                            color: Theme.of(context).primaryColor,
                          ),
                          PopUpTextField(
                            controller: _questionController,
                            hint: 'API means',
                            label: 'Question',
                            widthRatio: 2,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ("Field cannot be empty");
                              }
                              return null;
                            },
                          ),
                          PopUpTextField(
                            controller: _optionAController,
                            hint: '',
                            label: 'Option 1',
                            widthRatio: 1,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ("Field cannot be empty");
                              }
                              return null;
                            },
                          ),
                          PopUpTextField(
                            controller: _optionBController,
                            hint: '',
                            label: 'Option 2',
                            widthRatio: 1,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ("Field cannot be empty");
                              }
                              return null;
                            },
                          ),
                          PopUpTextField(
                            controller: _optionCController,
                            hint: '',
                            label: 'Option 3',
                            widthRatio: 1,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ("Field cannot be empty");
                              }
                              return null;
                            },
                          ),
                          PopUpTextField(
                            controller: _optionDController,
                            hint: '',
                            label: 'Option 4',
                            widthRatio: 1,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ("Field cannot be empty");
                              }
                              return null;
                            },
                          ),
                          Row(
                            children: [
                              const Text("Multiple Correct Answer"),
                              const SizedBox(
                                width: 10,
                              ),
                              TextButton(
                                  onPressed: () {
                                    if (multAnsCorrect == false) {
                                      setState(() {
                                        multAnsCorrect = true;
                                        _multiCorrectAnswerController.text =
                                            "true";
                                        Fluttertoast.showToast(
                                            msg:
                                                "Multiple Correct Answer Enabled");
                                      });
                                    } else if (multAnsCorrect == true) {
                                      setState(() {
                                        multAnsCorrect = false;
                                        _multiCorrectAnswerController.text =
                                            "false";
                                        Fluttertoast.showToast(
                                            msg:
                                                "Multiple Correct Answer Disabled");
                                      });
                                    }
                                  },
                                  child:  Text(multAnsCorrect.toString())),
                            ],
                          ),
                          PopUpTextField(
                            controller: _multiCorrectAnswerController,
                            hint: '',
                            label: 'Multiple Correct Answer',
                            widthRatio: 1,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ("Field cannot be empty");
                              }
                              return null;
                            },
                          ),
                          PopUpTextField(
                            controller: _correctOptionAController,
                            hint: 'write true or false',
                            label: 'Option A is correct',
                            widthRatio: 1,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ("Field cannot be empty");
                              }
                              return null;
                            },
                          ),
                          PopUpTextField(
                            controller: _correctOptionBController,
                            hint: 'write true or false',
                            label: 'Option B is correct',
                            widthRatio: 1,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ("Field cannot be empty");
                              }
                              return null;
                            },
                          ),
                          PopUpTextField(
                            controller: _correctOptionCController,
                            hint: 'write true or false',
                            label: 'Option C is correct',
                            widthRatio: 1,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ("Field cannot be empty");
                              }
                              return null;
                            },
                          ),
                          PopUpTextField(
                            controller: _correctOptionDController,
                            hint: 'write true or false',
                            label: 'Option D is correct',
                            widthRatio: 1,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ("Field cannot be empty");
                              }
                              return null;
                            },
                          ),
                          PopUpTextField(
                            controller: _explanationController,
                            hint: '',
                            label: 'Explanation',
                            widthRatio: 2,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ("Field cannot be empty");
                              }
                              return null;
                            },
                          ),
                          PopUpTextField(
                            controller: _descriptionController,
                            hint: '',
                            label: 'Description',
                            widthRatio: 2,
                          ),
                          PopUpTextField(
                            controller: _tipController,
                            hint: '',
                            label: 'tip',
                            widthRatio: 2,
                          ),
                          PopUpTextField(
                            controller: _difficultyController,
                            hint: 'easy',
                            label: 'difficulty',
                            widthRatio: 2,
                          ),
                        ],
                      ),
                    ),
                    popUpactions: [
                      Material(
                        color: Colors.amberAccent,
                        elevation: 4,
                        type: MaterialType.button,
                        child: MaterialButton(
                          onPressed: () {
                            if (_questionAddScreenFormKey.currentState!
                                .validate()) {
                              questionsList.add(Questions(
                                id: questionsList.length + 1,
                                question: _questionController.text.trim(),
                                options: Options(
                                  optionA: _optionAController.text.trim(),
                                  optionB: _optionBController.text.trim(),
                                  optionC: _optionDController.text.trim(),
                                  optionD: _optionDController.text.trim(),
                                ),
                                multipleCorrectAnswers:
                                    _multiCorrectAnswerController.text.trim() ==
                                            'true'
                                        ? true
                                        : false,
                                correctAnswers: CorrectAnswers(
                                  answerACorrect:
                                      _correctOptionAController.text.trim() ==
                                              'true'
                                          ? true
                                          : false,
                                  answerBCorrect:
                                      _correctOptionBController.text.trim() ==
                                              'true'
                                          ? true
                                          : false,
                                  answerCCorrect:
                                      _correctOptionCController.text.trim() ==
                                              'true'
                                          ? true
                                          : false,
                                  answerDCorrect:
                                      _correctOptionDController.text.trim() ==
                                              'true'
                                          ? true
                                          : false,
                                ),
                                explanation: _explanationController.text.trim(),
                                description: _descriptionController.text.trim(),
                                tip: _tipController.text.trim(),
                                tags: [],
                                difficulty: _difficultyController.text.trim(),
                              ));
                              questionsLength();
                              if (!mounted) {
                                return;
                              }
                              Navigator.of(context, rootNavigator: true).pop();
                            }
                          },
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width / 76.8),
                          child: Text(
                            'Add New Question',
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width / 86,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Material(
                  //   color: Colors.amberAccent,
                  //   elevation: 4,
                  //   type: MaterialType.button,
                  //   child: MaterialButton(
                  //     onPressed: () async {
                  //       // try {
                  //       //   String userEmail = FirebaseAuth
                  //       //       .instance.currentUser!.email
                  //       //       .toString();
                  //       //   await FirebaseFirestore.instance
                  //       //       .collection('practice')
                  //       //       .doc()
                  //       //       .set({
                  //       //         "uploadedTeacher": userEmail,
                  //       //         "category": widget.category,
                  //       //         "course": widget.course,
                  //       //         "chapter": widget.chapter,
                  //       //         "subject": widget.subject,
                  //       //         "cid": widget.cid,
                  //       //         "questions": questionsListToMap(questionsList),
                  //       //       })
                  //       //       .then((value) => print("Practice Set Added"))
                  //       //       .catchError((error) =>
                  //       //           print("Failed to add Practice Set: $error"));
                  //       // } on FirebaseAuthException catch (error) {
                  //       //   switch (error.code) {
                  //       //     default:
                  //       //       errorMessage =
                  //       //           "An undefined Error happened.+$error";
                  //       //   }
                  //       //   Fluttertoast.showToast(msg: errorMessage!);
                  //       // }
                  //       Fluttertoast.showToast(
                  //           msg: "Practice Set Added Successfully");
                  //       if (!mounted) {
                  //         return;
                  //       }
                  //       Navigator.of(context, rootNavigator: true).pop();
                  //     },
                  //     padding: EdgeInsets.all(
                  //         MediaQuery.of(context).size.width / 76.8),
                  //     child: Text(
                  //       'Submit',
                  //       style: TextStyle(
                  //         fontSize: MediaQuery.of(context).size.width / 86,
                  //         color: Colors.black,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
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
