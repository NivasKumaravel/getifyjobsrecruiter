class ShortlistedModel {
  bool? status;
  String? message;
  ShortlistedData? data;

  ShortlistedModel({this.status, this.message, this.data});

  ShortlistedModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new ShortlistedData.fromJson(json['data']) : null;
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

class ShortlistedData {
  int? totalItems;
  List<Items>? items;

  ShortlistedData({this.totalItems, this.items});

  ShortlistedData.fromJson(Map<String, dynamic> json) {
    totalItems = json['total_items'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_items'] = this.totalItems;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? name;
  String? jobTitle;
  String? jobId;
  String? candidateId;
  String? profilePic;
  String? appliedDate;

  Items(
      {this.name,
        this.jobTitle,
        this.jobId,
        this.candidateId,
        this.profilePic,
        this.appliedDate});

  Items.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    jobTitle = json['job_title'];
    jobId = json['job_id'];
    candidateId = json['candidate_id'];
    profilePic = json['profile_pic'];
    appliedDate = json['applied_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['job_title'] = this.jobTitle;
    data['job_id'] = this.jobId;
    data['candidate_id'] = this.candidateId;
    data['profile_pic'] = this.profilePic;
    data['applied_date'] = this.appliedDate;
    return data;
  }
}
