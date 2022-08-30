class CouponModel {
  String? title;
  String? discount;
  String? couponCode;
  String? category;
  String? expiryDate;
  String? description;
  String? course;

  CouponModel(
      {this.title,
      this.discount,
      this.couponCode,
      this.category,
      this.course,
      this.expiryDate,
      this.description});

  CouponModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    discount = json['discount'];
    couponCode = json['couponCode'];
    category = json['category'];
    course=json['course'];
    expiryDate = json['expiryDate'];

    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['discount'] = discount;
    data['couponCode'] = couponCode;
    data['category'] = category;
    data['course']=course;
    data['expiryDate'] = expiryDate;
    data['description'] = description;
    return data;
  }
}
