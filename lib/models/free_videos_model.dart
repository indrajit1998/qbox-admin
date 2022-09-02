class FreeVideoModel {
  String? title;
  String? imageUrl;
  int? likes;
  int? comment;
  int? download;
  String? videoLink;
  String? uploadDate;
  String? course;
  String? category;
  String? description;
  String ? chapter;
  String? subject;
  String? uploadedTeacherEmail;

  FreeVideoModel(
      {this.title,
      this.imageUrl,
      this.likes,
      this.download,
      this.comment,
      this.videoLink,
      this.uploadDate,
      this.course,
      this.category,
      this.chapter,
      this.subject,
      this.description,
      this.uploadedTeacherEmail});

  FreeVideoModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    imageUrl = json['imageUrl'];
    likes = json['likes'];
    download = json['download'];
    comment = json['comment'];
    videoLink = json['videoLink'];
    uploadDate = json['uploadDate'];
    course = json['course'];
    category = json['category'];
    chapter = json['chapter'];
    subject = json['subject'];
    description = json['description'];
    uploadedTeacherEmail = json['uploadedTeacherEmail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['imageUrl'] = imageUrl;
    data['likes'] = likes;
    data['comment'] = comment;
    data['download'] = download;
    data['videoLink'] = videoLink;
    data['uploadDate'] = uploadDate;
    data['course'] = course;
    data['category'] = category;
    data['chapter'] = chapter;
    data['subject'] = subject;
    data['description'] = description;
    data['uploadedTeacherEmail'] = uploadedTeacherEmail;
    return data;
  }
}
