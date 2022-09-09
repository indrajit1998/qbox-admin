import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qbox_admin/models/practice_model.dart';
import 'package:qbox_admin/widgets/bottom_material_button.dart';
import 'package:qbox_admin/widgets/pop_up_text_field.dart';
import 'package:qbox_admin/widgets/question_preview.dart';

class QuestionAddingScreen extends StatefulWidget {
  final String category;
  final String course;
  final String chapter;
  final String cid;
  final String subject;
  final String updateDate;
  final String publishDate;
  const QuestionAddingScreen(
      {Key? key,
      required this.chapter,
      required this.course,
      required this.category,
      required this.subject,
      required this.cid, required this.updateDate, required this.publishDate})
      : super(key: key);

  @override
  State<QuestionAddingScreen> createState() => _QuestionAddingScreenState();
}

class _QuestionAddingScreenState extends State<QuestionAddingScreen> {
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

  bool optionscorrecta = false;
  bool optionscorrectb = false;
  bool optionscorrectc = false;
  bool optionscorrectd = false;

  Map<String, dynamic> questionsListToMap(List<Questions> mappingList) {
    Map<String, dynamic> value = {};
    for (var mappingQuestion in mappingList) {
      value['id${mappingQuestion.id}'] = {
        "id": mappingQuestion.id,
        "question": mappingQuestion.question,
        "description": mappingQuestion.description,
        "options": {
          "optionA": mappingQuestion.options!.optionA,
          "optionB": mappingQuestion.options!.optionB,
          "optionC": mappingQuestion.options!.optionC,
          "optionD": mappingQuestion.options!.optionD,
        },
        "multiple_correct_answers": mappingQuestion.multipleCorrectAnswers,
        "correct_answers": {
          "answer_a_correct": mappingQuestion.correctAnswers!.answerACorrect,
          "answer_b_correct": mappingQuestion.correctAnswers!.answerBCorrect,
          "answer_c_correct": mappingQuestion.correctAnswers!.answerCCorrect,
          "answer_d_correct": mappingQuestion.correctAnswers!.answerDCorrect,
        },
        "explanation": mappingQuestion.explanation,
        "tip": mappingQuestion.tip,
        "tags": mappingQuestion.tags,
        "difficulty": mappingQuestion.difficulty
      };
    }
    return value;
  }

  bool multAnsCorrect = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              widget.category,
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
            Text(
              widget.course,
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
            Text(
              widget.chapter,
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
            Text(
              widget.publishDate,
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
            Text(
              widget.updateDate,
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
            Text(
              widget.cid.toString(),
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
          ],
        ),
        elevation: 0,
      ),
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 685,
                child: questionsLength() == 0
                    ? const Center(child: Text('No Question Added until Now'))
                    : ListView.builder(
                        itemCount: questionsLength(),
                        itemBuilder: (BuildContext context, int index) {
                          return QuestionPreview(
                              question: questionsList[index]);
                        }),
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
                                  child: Text(multAnsCorrect.toString())),
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
                            'Add Question',
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width / 86,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Material(
                    color: Colors.amberAccent,
                    elevation: 4,
                    type: MaterialType.button,
                    child: MaterialButton(
                      onPressed: () async {
                        try {
                           DateTime currentTime = DateTime.now();
                          String userEmail = FirebaseAuth
                              .instance.currentUser!.email
                              .toString();
                          await FirebaseFirestore.instance
                              .collection('practice')
                              .doc()
                              .set({
                                "uploadedTeacher": userEmail,
                                "category": widget.category,
                                "course": widget.course,
                                "chapter": widget.chapter,
                                "subject": widget.subject,
                                "cid": widget.cid,
                                "updateDate": currentTime.toString(),
                                "publishDate":widget.publishDate,
                                "questions": questionsListToMap(questionsList),
                              })
                              .then((value) => print("Practice Set Added"))
                              .catchError((error) =>
                                  print("Failed to add Practice Set: $error"));
                        } on FirebaseAuthException catch (error) {
                          switch (error.code) {
                            default:
                              errorMessage =
                                  "An undefined Error happened.+$error";
                          }
                          Fluttertoast.showToast(msg: errorMessage!);
                        }
                        Fluttertoast.showToast(
                            msg: "Practice Set Added Successfully");
                        if (!mounted) {
                          return;
                        }
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.width / 76.8),
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 86,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
