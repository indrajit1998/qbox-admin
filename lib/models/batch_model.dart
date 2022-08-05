class BatchModel {
  String? batchName;
  List? teachers;
  String? courseName;
  String? cid;

  BatchModel({this.batchName, this.teachers, this.courseName, this.cid});

  BatchModel.fromJson(Map<String, dynamic> json) {
    courseName = json['courseName'];
    batchName = json['batchName'];
    if (json['teachers'] != null) {
      teachers = json['teachers'].cast();
    }
    cid = json['cid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['batchName'] = batchName;
    data['teachers'] = teachers;
    data['courseName'] = courseName;
    data['cid'] = cid;
    return data;
  }
}
