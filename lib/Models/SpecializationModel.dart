class SpecializationModel {
  bool? status;
  String? message;
  List<SpecializationData>? data;

  SpecializationModel({this.status, this.message, this.data});

  SpecializationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <SpecializationData>[];
      json['data'].forEach((v) {
        data!.add(new SpecializationData.fromJson(v));
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

class SpecializationData {
  String? id;
  String? token;
  String? qualificationId;
  String? specialization;
  String? status;
  String? createdAt;
  String? updatedAt;

  SpecializationData(
      {this.id,
        this.token,
        this.qualificationId,
        this.specialization,
        this.status,
        this.createdAt,
        this.updatedAt});

  SpecializationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    token = json['token'];
    qualificationId = json['qualification_id'];
    specialization = json['specialization'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['token'] = this.token;
    data['qualification_id'] = this.qualificationId;
    data['specialization'] = this.specialization;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
