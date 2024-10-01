class AppliedCampusCandidateModel {
  bool? status;
  String? message;
  AppliedCandidateData? data;

  AppliedCampusCandidateModel({this.status, this.message, this.data});

  AppliedCampusCandidateModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new AppliedCandidateData.fromJson(json['data']) : null;
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

class AppliedCandidateData {
  Info? info;
  int? totalItems;
  List<Items>? items;

  AppliedCandidateData({this.info, this.totalItems, this.items});

  AppliedCandidateData.fromJson(Map<String, dynamic> json) {
    info = json['info'] != null ? new Info.fromJson(json['info']) : null;
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
    if (this.info != null) {
      data['info'] = this.info!.toJson();
    }
    data['total_items'] = this.totalItems;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Info {
  String? jobId;
  String? jobTitle;
  String? createdDate;

  Info({this.jobId, this.jobTitle, this.createdDate});

  Info.fromJson(Map<String, dynamic> json) {
    jobId = json['job_id'];
    jobTitle = json['job_title'];
    createdDate = json['created_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['job_id'] = this.jobId;
    data['job_title'] = this.jobTitle;
    data['created_date'] = this.createdDate;
    return data;
  }
}

class Items {
  String? name;
  String? profilePic;
  String? candidate_id;
  String? job_title;
  String? round;
  String? appliedDate;
  String? interviewTime;
  String? interviewDate;
  String? branch;

  Items({this.name, this.profilePic, this.round, this.appliedDate,this.candidate_id,this.job_title,this.interviewDate,this.interviewTime,this.branch});

  Items.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    profilePic = json['profile_pic'];
    candidate_id = json['candidate_id'];
    job_title = json['job_title'];
    round = json['round'];
    appliedDate = json['applied_date'];
    interviewTime = json['interview_time'];
    interviewDate = json['interview_date'];
    branch = json['branch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['profile_pic'] = this.profilePic;
    data['candidate_id'] = this.candidate_id;
    data['job_title'] = this.job_title;
    data['round'] = this.round;
    data['applied_date'] = this.appliedDate;
    data['interview_time'] = this.interviewTime;
    data['interview_date'] = this.interviewDate;
    data['branch'] = this.branch;
    return data;
  }
}
