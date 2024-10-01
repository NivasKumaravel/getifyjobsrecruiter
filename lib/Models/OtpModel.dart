class RecruiterOtpVerificationModel {
  bool? status;
  String? message;
  Data? data;

  RecruiterOtpVerificationModel({this.status, this.message, this.data});

  RecruiterOtpVerificationModel.fromJson(Map<String, dynamic> json) {
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
  String? phone;

  Data({this.recruiterId,this.phone});

  Data.fromJson(Map<String, dynamic> json) {
    recruiterId = json['recruiter_id'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['recruiter_id'] = this.recruiterId;
    data['phone'] = this.phone;
    return data;
  }
}
