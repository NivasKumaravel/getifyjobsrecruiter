class LoginModel {
  bool? status;
  String? message;
  Data? data;

  LoginModel({this.status, this.message, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? recruiterId;
  String? name;
  String? logo;
  String? email;
  String? phone;
  String? companyName;

  Data(
      {this.recruiterId,
        this.name,
        this.logo,
        this.email,
        this.phone,
        this.companyName});

  Data.fromJson(Map<String, dynamic> json) {
    recruiterId = json['recruiter_id'];
    name = json['name'];
    logo = json['logo'];
    email = json['email'];
    phone = json['phone'];
    companyName = json['company_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['recruiter_id'] = this.recruiterId;
    data['name'] = this.name;
    data['logo'] = this.logo;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['company_name'] = this.companyName;
    return data;
  }
}
