class LiveVideoModel {
  String? title;
  String? scheduleDate;
  String? endDate;
  String? course;
  String? category;
  String? cid;
  String? chapter;
  bool? isLive;

  LiveVideoModel(
      {this.title,
      this.endDate,
      this.scheduleDate,
      this.course,
      this.category,
      this.cid,
      this.chapter,
      this.isLive});

  LiveVideoModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    scheduleDate = json['scheduleDate'];
    endDate = json['endDate'];
    course = json['course'];
    category = json['category'];
    chapter = json['chapter'];
    cid = json['cid'];
    isLive = json['live'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['scheduleDate'] = scheduleDate;
    data['endDate'] = endDate;
    data['course'] = course;
    data['category'] = category;
    data['chapter'] = chapter;
    data['cid'] = course;
    data['live'] = isLive;
    return data;
  }
}
