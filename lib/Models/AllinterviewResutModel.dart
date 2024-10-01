class AllinterviewModel {
  bool? status;
  String? message;
  AllinterviewData? data;

  AllinterviewModel({this.status, this.message, this.data});

  AllinterviewModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new AllinterviewData.fromJson(json['data']) : null;
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

class AllinterviewData {
  Count? count;
  int? totalItems;
  List<Items>? items;

  AllinterviewData({this.count, this.totalItems, this.items});

  AllinterviewData.fromJson(Map<String, dynamic> json) {
    count = json['count'] != null ? new Count.fromJson(json['count']) : null;
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
    if (this.count != null) {
      data['count'] = this.count!.toJson();
    }
    data['total_items'] = this.totalItems;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Count {
  int? waitingList;
  int? selected;
  int? rejected;
  int? notAttend;

  Count({this.waitingList, this.selected, this.rejected, this.notAttend});

  Count.fromJson(Map<String, dynamic> json) {
    waitingList = json['waiting_list'];
    selected = json['selected'];
    rejected = json['rejected'];
    notAttend = json['not_attend'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['waiting_list'] = this.waitingList;
    data['selected'] = this.selected;
    data['rejected'] = this.rejected;
    data['not_attend'] = this.notAttend;
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
  ScheduleData? scheduleData;

  Items(
      {this.name,
        this.jobTitle,
        this.jobId,
        this.candidateId,
        this.profilePic,
        this.appliedDate,
        this.scheduleData});

  Items.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    jobTitle = json['job_title'];
    jobId = json['job_id'];
    candidateId = json['candidate_id'];
    profilePic = json['profile_pic'];
    appliedDate = json['applied_date'];
    scheduleData = json['schedule_data'] != null
        ? new ScheduleData.fromJson(json['schedule_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['job_title'] = this.jobTitle;
    data['job_id'] = this.jobId;
    data['candidate_id'] = this.candidateId;
    data['profile_pic'] = this.profilePic;
    data['applied_date'] = this.appliedDate;
    if (this.scheduleData != null) {
      data['schedule_data'] = this.scheduleData!.toJson();
    }
    return data;
  }
}

class ScheduleData {
  String? interviewDate;
  String? interviewTime;
  String? branch;
  String? jobStatus;

  ScheduleData(
      {this.interviewDate, this.interviewTime, this.branch, this.jobStatus});

  ScheduleData.fromJson(Map<String, dynamic> json) {
    interviewDate = json['interview_date'];
    interviewTime = json['interview_time'];
    branch = json['branch'];
    jobStatus = json['job_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['interview_date'] = this.interviewDate;
    data['interview_time'] = this.interviewTime;
    data['branch'] = this.branch;
    data['job_status'] = this.jobStatus;
    return data;
  }
}
