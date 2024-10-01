class CampusJobListModel {
  bool? status;
  String? message;
  CampusJobListData? data;

  CampusJobListModel({this.status, this.message, this.data});

  CampusJobListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new CampusJobListData.fromJson(json['data']) : null;
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

class CampusJobListData {
  int? totalItems;
  Items? items;

  CampusJobListData({this.totalItems, this.items});

  CampusJobListData.fromJson(Map<String, dynamic> json) {
    totalItems = json['total_items'];
    items = json['items'] != null ? new Items.fromJson(json['items']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_items'] = this.totalItems;
    if (this.items != null) {
      data['items'] = this.items!.toJson();
    }
    return data;
  }
}

class Items {
  String? campusId;
  String? name;
  String? location;
  String? logo;
  String? recruitmentDate;
  List<Jobs>? jobs;

  Items(
      {this.campusId,
        this.name,
        this.location,
        this.logo,
        this.recruitmentDate,
        this.jobs});

  Items.fromJson(Map<String, dynamic> json) {
    campusId = json['campus_id'];
    name = json['name'];
    location = json['location'];
    logo = json['logo'];
    recruitmentDate = json['recruitment_date'];
    if (json['jobs'] != null) {
      jobs = <Jobs>[];
      json['jobs'].forEach((v) {
        jobs!.add(new Jobs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['campus_id'] = this.campusId;
    data['name'] = this.name;
    data['location'] = this.location;
    data['logo'] = this.logo;
    data['recruitment_date'] = this.recruitmentDate;
    if (this.jobs != null) {
      data['jobs'] = this.jobs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Jobs {
  String? jobId;
  String? jobTitle;
  int? appliedCandidate;
  String? jobStatus;
  String? createdDate;

  Jobs(
      {this.jobId,
        this.jobTitle,
        this.appliedCandidate,
        this.jobStatus,
        this.createdDate});

  Jobs.fromJson(Map<String, dynamic> json) {
    jobId = json['job_id'];
    jobTitle = json['job_title'];
    appliedCandidate = json['applied_candidate'];
    jobStatus = json['job_status'];
    createdDate = json['created_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['job_id'] = this.jobId;
    data['job_title'] = this.jobTitle;
    data['applied_candidate'] = this.appliedCandidate;
    data['job_status'] = this.jobStatus;
    data['created_date'] = this.createdDate;
    return data;
  }
}
