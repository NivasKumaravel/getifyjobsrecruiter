class SkillSetModel {
  bool? status;
  String? message;
  List<SkillSetData>? data;

  SkillSetModel({this.status, this.message, this.data});

  SkillSetModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <SkillSetData>[];
      json['data'].forEach((v) {
        data!.add(new SkillSetData.fromJson(v));
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

class SkillSetData {
  String? id;
  String? token;
  String? skills;
  String? status;
  String? createdAt;
  String? updatedAt;

  SkillSetData(
      {this.id,
        this.token,
        this.skills,
        this.status,
        this.createdAt,
        this.updatedAt});

  SkillSetData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    token = json['token'];
    skills = json['skills'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['token'] = this.token;
    data['skills'] = this.skills;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
