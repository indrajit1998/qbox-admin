class PracticeModel {
  String? uploadedTeacher;
  String? category;
  String? course;
  String? chapter;
  String? subject;
  List<Questions>? questions;

  PracticeModel(
      {this.uploadedTeacher,
      this.category,
      this.course,
      this.chapter,
      this.subject,
      this.questions});

  PracticeModel.fromJson(Map<String, dynamic> json) {
    uploadedTeacher = json['uploadedTeacher'] as String;
    category = json['category'] as String;
    course = json['course'] as String;
    chapter = json['chapter'] as String;
    subject = json['subject'] as String;
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((k, v) {
        questions!.add(Questions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uploadedTeacher'] = uploadedTeacher;
    data['category'] = category;
    data['course'] = course;
    data['chapter'] = chapter;
    data['subject'] = subject;
    if (questions != null) {
      data['questions'] = questions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Questions {
  int? id;
  String? question;
  String? description;
  Options? options;
  bool? multipleCorrectAnswers;
  CorrectAnswers? correctAnswers;
  String? explanation;
  String? tip;
  List<String>? tags;
  String? difficulty;

  Questions(
      {this.id,
      this.question,
      this.description,
      this.options,
      this.multipleCorrectAnswers,
      this.correctAnswers,
      this.explanation,
      this.tip,
      this.tags,
      this.difficulty});

  Questions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
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
