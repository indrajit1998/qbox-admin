class PTMmodel{
  String? course;
  String? category;
  String? batch;
  String? meetingLink;
  String? date;
  String? time;
  String? id;

  PTMmodel({this.batch,this.category,this.course,this.date,this.meetingLink,this.time,this.id});

  PTMmodel.fromJson(Map<String,dynamic> json){
    course=json['course'];
    category=json['category'];
    batch=json['batch'];
    meetingLink=json['meetingLink'];
    date=json['date'];
    time=json['time'];
    id=json['id'];
  }

   Map<String,dynamic> toJson(){
     Map<String ,dynamic> data=Map<String,dynamic>();
     data['course']=course;
     data['category']=category;
     data['batch']=batch;
     data['meetingLink']=meetingLink;
     data['date']=date;
     data['time']=time;
     data['id']=id;
     return data;
}
}