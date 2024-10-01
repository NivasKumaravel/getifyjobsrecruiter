class IndustryModel {
  bool? status;
  String? message;
  List<IndustryData>? data;

  IndustryModel({this.status, this.message, this.data});

  IndustryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <IndustryData>[];
      json['data'].forEach((v) {
        data!.add(new IndustryData.fromJson(v));
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

class IndustryData {
  String? id;
  String? token;
  String? industry;
  String? status;
  String? createdAt;
  String? updatedAt;

  IndustryData(
      {this.id,
        this.token,
        this.industry,
        this.status,
        this.createdAt,
        this.updatedAt});

  IndustryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    token = json['token'];
    industry = json['industry'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['token'] = this.token;
    data['industry'] = this.industry;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
