class StatutoryBenefitsModel {
  bool? status;
  String? message;
  List<StatutoryBenefitsData>? data;

  StatutoryBenefitsModel({this.status, this.message, this.data});

  StatutoryBenefitsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <StatutoryBenefitsData>[];
      json['data'].forEach((v) {
        data!.add(new StatutoryBenefitsData.fromJson(v));
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

class StatutoryBenefitsData {
  String? id;
  String? benefits;
  String? type;
  String? status;
  String? createdAt;
  String? updatedAt;

  StatutoryBenefitsData(
      {this.id,
        this.benefits,
        this.type,
        this.status,
        this.createdAt,
        this.updatedAt});

  StatutoryBenefitsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    benefits = json['benefits'];
    type = json['type'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['benefits'] = this.benefits;
    data['type'] = this.type;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
