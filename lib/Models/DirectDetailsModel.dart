class DirectDetailsModel {
  bool? status;
  String? message;
  DirectDetailsData? data;

  DirectDetailsModel({this.status, this.message, this.data});

  DirectDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null
        ? new DirectDetailsData.fromJson(json['data'])
        : null;
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

class DirectDetailsData {
  String? jobId;
  String? jobTitle;
  String? jobDescription;
  String? skills;
  String? qualification;
  String? specialization;
  String? currentArrears;
  String? historyOfArrears;
  String? requiredPercentage;
  String? location;
  String? experience;
  String? workType;
  String? workMode;
  String? shiftDetails;
  String? salaryFrom;
  String? salaryTo;
  String? statutoryBenefits;
  String? socialBenefits;
  String? otherBenefits;
  String? recruiter;
  String? companyName;
  String? logo;
  String? recruiterId;
  String? createdDate;
  String? expiryDate;
  InterviewSchedule? interviewSchedule;

  DirectDetailsData(
      {this.jobId,
      this.jobTitle,
      this.jobDescription,
      this.skills,
      this.qualification,
      this.specialization,
      this.currentArrears,
      this.historyOfArrears,
      this.requiredPercentage,
      this.location,
      this.experience,
      this.workType,
      this.workMode,
      this.shiftDetails,
      this.salaryFrom,
      this.salaryTo,
      this.statutoryBenefits,
      this.socialBenefits,
      this.otherBenefits,
      this.recruiter,
      this.companyName,
      this.logo,
      this.recruiterId,
      this.createdDate,
      this.expiryDate,
      this.interviewSchedule});

  DirectDetailsData.fromJson(Map<String, dynamic> json) {
    jobId = json['job_id'];
    jobTitle = json['job_title'];
    jobDescription = json['job_description'];
    skills = json['skills'];
    qualification = json['qualification'];
    specialization = json['specialization'];
    currentArrears = json['current_arrears'];
    historyOfArrears = json['history_of_arrears'];
    requiredPercentage = json['required_percentage'];
    location = json['location'];
    experience = json['experience'];
    workType = json['work_type'];
    workMode = json['work_mode'];
    shiftDetails = json['shift_details'];
    salaryFrom = json['salary_from'];
    salaryTo = json['salary_to'];
    statutoryBenefits = json['statutory_benefits'];
    socialBenefits = json['social_benefits'];
    otherBenefits = json['other_benefits'];
    recruiter = json['recruiter'];
    companyName = json['company_name'];
    logo = json['logo'];
    recruiterId = json['recruiter_id'];
    createdDate = json['created_date'];
    expiryDate = json['expiry_date'];

    dynamic interviewSchedule = json['interview_schedule'];

    if (interviewSchedule is List) {
      print("List");
    } else {
      interviewSchedule =
          new InterviewSchedule.fromJson(json['interview_schedule']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['job_id'] = this.jobId;
    data['job_title'] = this.jobTitle;
    data['job_description'] = this.jobDescription;
    data['skills'] = this.skills;
    data['qualification'] = this.qualification;
    data['specialization'] = this.specialization;
    data['current_arrears'] = this.currentArrears;
    data['history_of_arrears'] = this.historyOfArrears;
    data['required_percentage'] = this.requiredPercentage;
    data['location'] = this.location;
    data['experience'] = this.experience;
    data['work_type'] = this.workType;
    data['work_mode'] = this.workMode;
    data['shift_details'] = this.shiftDetails;
    data['salary_from'] = this.salaryFrom;
    data['salary_to'] = this.salaryTo;
    data['statutory_benefits'] = this.statutoryBenefits;
    data['social_benefits'] = this.socialBenefits;
    data['other_benefits'] = this.otherBenefits;
    data['recruiter'] = this.recruiter;
    data['company_name'] = this.companyName;
    data['logo'] = this.logo;
    data['recruiter_id'] = this.recruiterId;
    data['created_date'] = this.createdDate;
    data['expiry_date'] = this.expiryDate;
    if (this.interviewSchedule != []) {
      data['interview_schedule'] = this.interviewSchedule!.toJson();
    }
    return data;
  }
}

class InterviewSchedule {
  String? interviewDate;
  String? interviewTime;
  String? branch;
  String? scheduledBy;
  String? type;
  bool? reschedule;
  bool? actionBtn;

  InterviewSchedule(
      {this.interviewDate,
      this.interviewTime,
      this.branch,
      this.scheduledBy,
      this.type,
      this.reschedule,
      this.actionBtn});

  InterviewSchedule.fromJson(Map<String, dynamic> json) {
    interviewDate = json['interview_date'];
    interviewTime = json['interview_time'];
    branch = json['branch'];
    scheduledBy = json['scheduled_by'];
    type = json['type'];
    reschedule = json['reschedule'];
    actionBtn = json['action_btn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['interview_date'] = this.interviewDate;
    data['interview_time'] = this.interviewTime;
    data['branch'] = this.branch;
    data['scheduled_by'] = this.scheduledBy;
    data['type'] = this.type;
    data['reschedule'] = this.reschedule;
    data['action_btn'] = this.actionBtn;
    return data;
  }
}
