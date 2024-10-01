class ResentOtpModel {
  bool? status;
  String? message;
  Data? data;

  ResentOtpModel({this.status, this.message, this.data});

  ResentOtpModel.fromJson(Map<String, dynamic> json) {
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

  Data({this.recruiterId});

  Data.fromJson(Map<String, dynamic> json) {
    recruiterId = json['recruiter_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['recruiter_id'] = this.recruiterId;
    return data;
  }
}
