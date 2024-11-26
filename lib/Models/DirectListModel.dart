class DirectListModel {
  bool? status;
  String? message;
  DirectListData? data;

  DirectListModel({this.status, this.message, this.data});

  DirectListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data =
        json['data'] != null ? new DirectListData.fromJson(json['data']) : null;
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

class DirectListData {
  int? totalItems;
  List<DirectListItems>? items;

  DirectListData({this.totalItems, this.items});

  DirectListData.fromJson(Map<String, dynamic> json) {
    totalItems = json['total_items'];
    if (json['items'] != null) {
      items = <DirectListItems>[];
      json['items'].forEach((v) {
        items!.add(new DirectListItems.fromJson(v));
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

class DirectListItems {
  String? jobId;
  String? jobTitle;
  String? recruiter_id;
  String? job_status;
  String? current_status;
  int? appliedCandidate;
  String? createdDate;

  DirectListItems(
      {this.jobId,
        this.jobTitle,
        this.appliedCandidate,
        this.createdDate,
        this.recruiter_id,
        this.job_status,
        this.current_status,
      });

  DirectListItems.fromJson(Map<String, dynamic> json) {
    jobId = json['job_id'];
    jobTitle = json['job_title'];
    recruiter_id = json['recruiter_id'];
    job_status = json['job_status'];
    current_status = json['current_status'];
    appliedCandidate = json['applied_candidate'];
    createdDate = json['created_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['job_id'] = this.jobId;
    data['job_title'] = this.jobTitle;
    data['recruiter_id'] = this.recruiter_id;
    data['job_status'] = this.job_status;
    data['current_status'] = this.current_status;
    data['applied_candidate'] = this.appliedCandidate;
    data['created_date'] = this.createdDate;
    return data;
  }
}
