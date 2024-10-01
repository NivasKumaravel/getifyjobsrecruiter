class RequestCallListModel {
  bool? status;
  String? message;
  RequestCallListData? data;

  RequestCallListModel({this.status, this.message, this.data});

  RequestCallListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new RequestCallListData.fromJson(json['data']) : null;
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

class RequestCallListData {
  int? totalItems;
  List<Items>? items;

  RequestCallListData({this.totalItems, this.items});

  RequestCallListData.fromJson(Map<String, dynamic> json) {
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
  String? requestedDate;

  Items(
      {this.name,
        this.jobTitle,
        this.jobId,
        this.candidateId,
        this.profilePic,
        this.requestedDate});

  Items.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    jobTitle = json['job_title'];
    jobId = json['job_id'];
    candidateId = json['candidate_id'];
    profilePic = json['profile_pic'];
    requestedDate = json['requested_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['job_title'] = this.jobTitle;
    data['job_id'] = this.jobId;
    data['candidate_id'] = this.candidateId;
    data['profile_pic'] = this.profilePic;
    data['requested_date'] = this.requestedDate;
    return data;
  }
}
