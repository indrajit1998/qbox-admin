class BatchModel {
  String? batchName;
  List? teachers;
  String? courseName;
  String? cid;
  String? startDate;
  String? endDate;

  BatchModel({this.batchName, this.teachers, this.courseName, this.cid,this.startDate,this.endDate});

  BatchModel.fromJson(Map<String, dynamic> json) {
    courseName = json['courseName'];
    batchName = json['batchName'];
    startDate =json['startDate'];
    endDate= json['endDate'];
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
    data['startDate']=startDate;
    data['endDate']=endDate;
    return data;
  }
}
