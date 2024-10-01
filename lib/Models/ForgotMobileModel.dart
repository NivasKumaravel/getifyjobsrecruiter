class ForgotMobileModel {
  bool? status;
  Data? data;
  String? message;

  ForgotMobileModel({this.status, this.data, this.message});

  ForgotMobileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  String? phone;
  int? updateRecruiter;

  Data({this.phone, this.updateRecruiter});

  Data.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    updateRecruiter = json['update_recruiter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    data['update_recruiter'] = this.updateRecruiter;
    return data;
  }
}
