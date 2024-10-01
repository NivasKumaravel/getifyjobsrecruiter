class InterviewModel {
  bool? status;
  String? message;
  Data? data;

  InterviewModel({this.status, this.message, this.data});

  InterviewModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  Count? count;
  int? totalItems;
  List<UserItems>? items;

  Data({this.count, this.totalItems, this.items});

  Data.fromJson(Map<String, dynamic> json) {
    count = json['count'] != null ? new Count.fromJson(json['count']) : null;
    totalItems = json['total_items'];
    if (json['items'] != null) {
      items = <UserItems>[];
      json['items'].forEach((v) {
        items!.add(new UserItems.fromJson(v));
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
  int? accepted;
  int? requested;
  int? reschedule;
  int? rejected;

  int? waiting_list;
  int? selected;
  int? not_attend;

  Count({this.accepted, this.requested, this.reschedule, this.rejected});

  Count.fromJson(Map<String, dynamic> json) {
    accepted = json['accepted'];
    requested = json['requested'];
    reschedule = json['reschedule'];
    rejected = json['rejected'];

    waiting_list = json['waiting_list'];
    selected = json['selected'];
    not_attend = json['not_attend'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accepted'] = this.accepted;
    data['requested'] = this.requested;
    data['reschedule'] = this.reschedule;
    data['rejected'] = this.rejected;

    data['waiting_list'] = this.waiting_list;
    data['selected'] = this.selected;
    data['not_attend'] = this.not_attend;

    return data;
  }
}

class UserItems {
  String? name;
  String? jobTitle;
  String? jobId;
  String? candidateId;
  String? profilePic;
  String? appliedDate;
  String? jobStatus;
  String? statusMessage;
  ScheduleData? scheduleData;

  UserItems(
      {this.name,
      this.jobTitle,
      this.jobId,
      this.candidateId,
      this.profilePic,
      this.appliedDate,
        this.jobStatus,
        this.statusMessage,
        this.scheduleData});

  UserItems.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    jobTitle = json['job_title'];
    jobId = json['job_id'];
    candidateId = json['candidate_id'];
    profilePic = json['profile_pic'];
    appliedDate = json['applied_date'];
    jobStatus = json['job_status'];
    statusMessage = json['status_message'];

    dynamic qwerty = json['schedule_data'];

    if (qwerty is List) {
    } else {
      scheduleData = json['schedule_data'] != null
          ? new ScheduleData.fromJson(json['schedule_data'])
          : null;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['job_title'] = this.jobTitle;
    data['job_id'] = this.jobId;
    data['candidate_id'] = this.candidateId;
    data['profile_pic'] = this.profilePic;
    data['applied_date'] = this.appliedDate;
    data['job_status'] = this.jobStatus;
    data['status_message'] = this.statusMessage;
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
  String? action_by;

  ScheduleData(
      {this.interviewDate, this.interviewTime, this.branch});

  ScheduleData.fromJson(Map<String, dynamic> json) {
    interviewDate = json['interview_date'];
    interviewTime = json['interview_time'];
    branch = json['branch'];
    action_by = json['action_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['interview_date'] = this.interviewDate;
    data['interview_time'] = this.interviewTime;
    data['branch'] = this.branch;
    data['action_by'] = this.action_by;
    return data;
  }
}
