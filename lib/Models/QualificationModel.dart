import 'package:searchfield/src/searchfield.dart';

class QualificationModel {
  bool? status;
  String? message;
  List<QualificationData>? data;

  QualificationModel({this.status, this.message, this.data});

  QualificationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <QualificationData>[];
      json['data'].forEach((v) {
        data!.add(new QualificationData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class QualificationData {
  String? id;
  String? token;
  String? qualification_id;
  String? specialization;
  String? qualification;
  String? status;
  String? createdAt;
  String? updatedAt;

  QualificationData(
      {this.id,
      this.token,
      this.qualification_id,
      this.specialization,
      this.qualification,
      this.status,
      this.createdAt,
      this.updatedAt});

  QualificationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    token = json['token'];
    qualification_id = json['qualification_id'];
    specialization = json['specialization'];
    qualification = json['qualification'] != null
        ? json['qualification']
        : json['college_name'] != null
            ? json['college_name']
            : json['designation'] != null
                ? json['designation']
                : json['specialization'] != null
                    ? json['specialization']
                    : json['skills'] != null
                        ? json['skills']
                        : json['industry'] != null
                            ? json['industry']
                            : "";

    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['token'] = this.token;
    data['qualification_id'] = this.qualification_id;
    data['specialization'] = this.specialization;
    data['qualification'] = this.qualification;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
