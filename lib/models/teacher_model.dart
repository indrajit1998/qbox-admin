class TeacherModel {
  String? firstName;
  String? lastName;
  String? email;
  String? profilePicUrl;
  Country? country;
  int? phoneNumber;
  String? role;
  List<String>? courses;
  List<String>? batches;
  List<String>? freeVideos;
  List<String>? liveVideos;
  List<String>? subjects;
  Review? review;

  TeacherModel(
      {this.firstName,
      this.lastName,
      this.email,
      this.profilePicUrl,
      this.country,
      this.phoneNumber,
      this.role,
      this.courses,
      this.batches,
      this.freeVideos,
      this.liveVideos,
      this.subjects,
      this.review});

  TeacherModel.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    profilePicUrl = json['profilePicUrl'];
    country =
        json['country'] != null ? Country.fromJson(json['country']) : null;
    phoneNumber = json['phoneNumber'];
    role = json['role'];
    courses = json['courses'].cast<String>();
    batches = json['batches'].cast<String>();
    freeVideos = json['freeVideos'].cast<String>();
    liveVideos = json['liveVideos'].cast<String>();
    subjects = json['subjects'].cast<String>();
    review = json['review'] != null ? Review.fromJson(json['review']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['profilePicUrl'] = profilePicUrl;
    if (country != null) {
      data['country'] = country!.toJson();
    }
    data['phoneNumber'] = phoneNumber;
    data['role'] = role;
    data['courses'] = courses;
    data['batches'] = batches;
    data['freeVideos'] = freeVideos;
    data['liveVideos'] = liveVideos;
    data['subjects'] = subjects;
    if (review != null) {
      data['review'] = review!.toJson();
    }
    return data;
  }
}

class Country {
  String? id;
  String? name;

  Country({this.id, this.name});

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class Review {
  double? rating;
  List<Reviews>? reviews;

  Review({this.rating, this.reviews});

  Review.fromJson(Map<String, dynamic> json) {
    rating = json['rating'];
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(Reviews.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rating'] = rating;
    if (reviews != null) {
      data['reviews'] = reviews!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Reviews {
  String? userName;
  double? rating;
  String? comment;

  Reviews({this.userName, this.rating, this.comment});

  Reviews.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    rating = json['rating'];
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userName'] = userName;
    data['rating'] = rating;
    data['comment'] = comment;
    return data;
  }
}
