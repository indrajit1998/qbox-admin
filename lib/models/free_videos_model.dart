class FreeVideoModel {
  String? title;
  String? imageUrl;
  int? likes;
  int? download;
  String? videoLink;
  String? uploadDate;
  String? course;
  String? category;
  String? description;
  String? chapter;
  String? subject;
  String? id;
  String? batchName;
  String? uploadedTeacherEmail;
  List<Comments>? comments;

  FreeVideoModel(
      {this.title,
      this.imageUrl,
      this.batchName,
      this.likes,
      this.download,
      this.videoLink,
      this.uploadDate,
      this.course,
      this.category,
      this.chapter,
      this.subject,
      this.id,
      this.description,
      this.uploadedTeacherEmail,
      this.comments});
  FreeVideoModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    imageUrl = json['imageUrl'];
    likes = json['likes'];
    download = json['download'];
    videoLink = json['videoLink'];
    uploadDate = json['uploadDate'];
    course = json['course'];
    category = json['category'];
    chapter = json['chapter'];
    subject = json['subject'];
    id = json['id'];
    batchName = json['batchName'];
    description = json['description'];
    uploadedTeacherEmail = json['uploadedTeacherEmail'];
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((k, v) {
        comments!.add(Comments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['imageUrl'] = imageUrl;
    data['likes'] = likes;
    data['download'] = download;
    data['videoLink'] = videoLink;
    data['uploadDate'] = uploadDate;
    data['course'] = course;
    data['category'] = category;
    data['chapter'] = chapter;
    data['subject'] = subject;
    data['id'] = id;
    data['batchName'] = batchName;
    data['description'] = description;
    data['uploadedTeacherEmail'] = uploadedTeacherEmail;
    if (comments != null) {
      data['comments'] = comments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class Comments {
  String? username;
  String? userId;
  String? createdAt;
  String? text;

  Comments(Map<String, Object> map,
      {this.createdAt, this.text, this.userId, this.username});
  Comments.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    userId = json['userId'];
    username = json['username'];
    createdAt = json['createdAt'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    data['userId'] = userId;
    data['username'] = username;
    data['createdAt'] = createdAt;
    return data;
  }
}
