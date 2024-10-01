class DirectCandidateListModel {
  bool? status;
  String? message;
  DirectCandidateListData? data;

  DirectCandidateListModel({this.status, this.message, this.data});

  DirectCandidateListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new DirectCandidateListData.fromJson(json['data']) : null;
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

class DirectCandidateListData {
  int? totalItems;
  List<Items>? items;

  DirectCandidateListData({this.totalItems, this.items});

  DirectCandidateListData.fromJson(Map<String, dynamic> json) {
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
  String? candidateId;
  String? profilePic;
  String? appliedDate;
  String? jobStatus;

  Items(
      {this.name,
        this.jobTitle,
        this.candidateId,
        this.profilePic,
        this.appliedDate,
        this.jobStatus
      });

  Items.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    jobTitle = json['job_title'];
    candidateId = json['candidate_id'];
    profilePic = json['profile_pic'];
    appliedDate = json['applied_date'];
    jobStatus = json['job_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['job_title'] = this.jobTitle;
    data['candidate_id'] = this.candidateId;
    data['profile_pic'] = this.profilePic;
    data['applied_date'] = this.appliedDate;
    data['job_status'] = this.jobStatus;
    return data;
  }
}
