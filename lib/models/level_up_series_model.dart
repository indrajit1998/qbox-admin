class LevelUpTestModel {
  String? uploadedTeacher;
  String? testName;
  String? examTime;
  int? duration;
  String? category;
  String? course;
  String? chapter;
  String? subject;
  String? cid;
  int? paperSet;
  List<QuestionsList>? questionsList;

  LevelUpTestModel({
    this.uploadedTeacher,
    this.testName,
    this.examTime,
    this.duration,
    this.category,
    this.course,
    this.chapter,
    this.paperSet,
    this.subject,
    this.cid,
    this.questionsList,
  });

  LevelUpTestModel.fromJson(Map<String, dynamic> json) {
    uploadedTeacher = json['uploadedTeacher'];
    testName = json['testName'];
    examTime = json['examTime'];
    duration = json['duration'];
    category = json['category'];
    course = json['course'];
    chapter = json['chapter'];
    subject = json['subject'];
    paperSet = json['paperSet'];
    cid = json['cid'];
    if (json['questionsList'] != null) {
      questionsList = <QuestionsList>[];
      json['questionsList'].forEach((k, v) {
        questionsList!.add(QuestionsList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uploadedTeacher'] = uploadedTeacher;
    data['testName'] = testName;
    data['examTime'] = examTime;
    data['duration'] = duration;
    data['category'] = category;
    data['course'] = course;
    data['chapter'] = chapter;
    data['subject'] = subject;
    data['paperSet'] = paperSet;
    data['cid'] = cid;
    if (questionsList != null) {
      data['questionsList'] = questionsList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class QuestionsList {
  int? id;
  String? question;
  String? equation;
  String? description;
  Options? options;
  bool? multipleCorrectAnswers;
  CorrectAnswers? correctAnswers;
  String? explanation;
  String? tip;
  List<String>? tags;
  String? difficulty;

  QuestionsList({
    this.id,
    this.question,
    this.equation,
    this.description,
    this.options,
    this.multipleCorrectAnswers,
    this.correctAnswers,
    this.explanation,
    this.tip,
    this.tags,
    this.difficulty,
  });

  QuestionsList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    equation = json['equation'];
    description = json['description'];
    options =
        json['options'] != null ? Options.fromJson(json['options']) : null;
    multipleCorrectAnswers = json['multiple_correct_answers'];
    correctAnswers = json['correct_answers'] != null
        ? CorrectAnswers.fromJson(json['correct_answers'])
        : null;
    explanation = json['explanation'];
    tip = json['tip'];
    tags = json['tags'].cast<String>();
    difficulty = json['difficulty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['question'] = question;
    data['equation'] = equation;
    data['description'] = description;
    if (options != null) {
      data['options'] = options!.toJson();
    }
    data['multiple_correct_answers'] = multipleCorrectAnswers;
    if (correctAnswers != null) {
      data['correct_answers'] = correctAnswers!.toJson();
    }
    data['explanation'] = explanation;
    data['tip'] = tip;
    data['tags'] = tags;
    data['difficulty'] = difficulty;
    return data;
  }
}

class Options {
  String? optionA;
  String? optionB;
  String? optionC;
  String? optionD;

  Options({this.optionA, this.optionB, this.optionC, this.optionD});

  Options.fromJson(Map<String, dynamic> json) {
    optionA = json['optionA'];
    optionB = json['optionB'];
    optionC = json['optionC'];
    optionD = json['optionD'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['optionA'] = optionA;
    data['optionB'] = optionB;
    data['optionC'] = optionC;
    data['optionD'] = optionD;
    return data;
  }
}

class CorrectAnswers {
  bool? answerACorrect;
  bool? answerBCorrect;
  bool? answerCCorrect;
  bool? answerDCorrect;

  CorrectAnswers(
      {this.answerACorrect,
      this.answerBCorrect,
      this.answerCCorrect,
      this.answerDCorrect});

  CorrectAnswers.fromJson(Map<String, dynamic> json) {
    answerACorrect = json['answer_a_correct'];
    answerBCorrect = json['answer_b_correct'];
    answerCCorrect = json['answer_c_correct'];
    answerDCorrect = json['answer_d_correct'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['answer_a_correct'] = answerACorrect;
    data['answer_b_correct'] = answerBCorrect;
    data['answer_c_correct'] = answerCCorrect;
    data['answer_d_correct'] = answerDCorrect;
    return data;
  }
}
