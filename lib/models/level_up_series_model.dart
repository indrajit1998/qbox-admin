class LevelUpTestModel {
  String? uploadedTeacher;
  String? testName;
  String? examTime;
  int? duration;
  String? category;
  String? course;
  String? chapter;
  String? subject;
  int? paperSet;
  List<QuestionsList>? questionsList;

  LevelUpTestModel(
      {this.uploadedTeacher,
      this.testName,
      this.examTime,
      this.duration,
      this.category,
      this.course,
      this.chapter,
      this.paperSet,
      this.subject,
      this.questionsList});

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
    if (questionsList != null) {
      data['questionsList'] = questionsList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class QuestionsList {
  int? id;
  String? question;
  String? description;
  Answers? answers;
  bool? multipleCorrectAnswers;
  CorrectAnswers? correctAnswers;
  String? explanation;
  String? tip;
  List<String>? tags;
  String? difficulty;

  QuestionsList(
      {this.id,
      this.question,
      this.description,
      this.answers,
      this.multipleCorrectAnswers,
      this.correctAnswers,
      this.explanation,
      this.tip,
      this.tags,
      this.difficulty});

  QuestionsList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    description = json['description'];
    answers =
        json['answers'] != null ? Answers.fromJson(json['answers']) : null;
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
    data['description'] = description;
    if (answers != null) {
      data['answers'] = answers!.toJson();
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

class Answers {
  String? answerA;
  String? answerB;
  String? answerC;
  String? answerD;

  Answers({this.answerA, this.answerB, this.answerC, this.answerD});

  Answers.fromJson(Map<String, dynamic> json) {
    answerA = json['answer_a'];
    answerB = json['answer_b'];
    answerC = json['answer_c'];
    answerD = json['answer_d'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['answer_a'] = answerA;
    data['answer_b'] = answerB;
    data['answer_c'] = answerC;
    data['answer_d'] = answerD;
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
