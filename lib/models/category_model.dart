import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String? title;
  List<Courses>? courses;
  List<String>? teachers;

  CategoryModel({this.title, this.courses});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    if (json['courses'] != null) {
      courses = <Courses>[];
      json['courses'].forEach((k, v) {
        courses!.add(Courses.fromJson(v));
      });
    }
    if (json['teachers'] != null) {
      teachers = json['teachers'].cast<String>();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    if (courses != null) {
      data['courses'] =
          FieldValue.arrayUnion([courses!.map((v) => v.toJson()).toList()]);
    }
    data['teachers'] = teachers;
    return data;
  }
}

class Courses {
  String? courseName;
  List<String>? batches;
  Payment? payment;

  Courses({this.courseName, this.batches, this.payment});

  Courses.fromJson(Map<String, dynamic> json) {
    courseName = json['courseName'];
    if (json['batches'] != null) {
      batches = json['batches'].cast<String>();
    } else {
      batches = null;
    }
    payment =
        json['payment'] != null ? Payment.fromJson(json['payment']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['courseName'] = courseName;
    data['batches'] = [batches];
    if (payment != null) {
      data['payment'] = payment!.toJson();
    }
    return data;
  }
}

class Payment {
  String? s1month;
  String? s6month;
  String? s12month;
  String? s24months;

  Payment({this.s1month, this.s6month, this.s12month, this.s24months});

  Payment.fromJson(Map<String, dynamic> json) {
    s1month = json['1month'];
    s6month = json['6month'];
    s12month = json['12month'];
    s24months = json['24months'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['1month'] = s1month;
    data['6month'] = s6month;
    data['12month'] = s12month;
    data['24months'] = s24months;
    return data;
  }
}
