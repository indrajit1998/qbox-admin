class FreeVideoModel {
  String? title;
  String? imageUrl;
  int? likes;
  String? videoLink;
  String? uploadDate;
  String? course;
  String? category;
  String? uploadedTeacherEmail;

  FreeVideoModel(
      {this.title,
      this.imageUrl,
      this.likes,
      this.videoLink,
      this.uploadDate,
      this.course,
      this.category,
      this.uploadedTeacherEmail});

  FreeVideoModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    imageUrl = json['imageUrl'];
    likes = json['likes'];
    videoLink = json['videoLink'];
    uploadDate = json['uploadDate'];
    course = json['course'];
    category = json['category'];
    uploadedTeacherEmail = json['uploadedTeacherEmail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['imageUrl'] = imageUrl;
    data['likes'] = likes;
    data['videoLink'] = videoLink;
    data['uploadDate'] = uploadDate;
    data['course'] = course;
    data['category'] = category;
    data['uploadedTeacherEmail'] = uploadedTeacherEmail;
    return data;
  }
}
