class LiveVideoModel {
  String? title;
  String? scheduleDate;
  String? endDate;
  String? course;
  String? category;
  String? link;
  bool? isLive;

  LiveVideoModel(
      {this.title,
      this.endDate,
      this.scheduleDate,
      this.course,
      this.category,
      this.link,
      this.isLive});

  LiveVideoModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    scheduleDate = json['scheduleDate'];
    endDate = json['endDate'];
    course = json['course'];
    category = json['category'];
    link = json['link'];
    isLive = json['live'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['scheduleDate'] = scheduleDate;
    data['endDate'] = endDate;
    data['course'] = course;
    data['category'] = category;
    data['link'] = link;
    data['live'] = isLive;
    return data;
  }
}
