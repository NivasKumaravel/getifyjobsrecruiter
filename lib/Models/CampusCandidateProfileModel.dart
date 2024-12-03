class CandidateCampusProfileModel {
  bool? status;
  String? message;
  CandidateCampusProfileData? data;

  CandidateCampusProfileModel({this.status, this.message, this.data});

  CandidateCampusProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new CandidateCampusProfileData.fromJson(json['data']) : null;
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

class CandidateCampusProfileData {
  String? candidateId;
  String? name;
  String? profilePic;
  String? email;
  String? phone;
  String? address;
  String? gender;
  String? maritalStatus;
  String? careerStatus;
  String? designation;
  String? designationId;
  String? experience;
  String? qualification;
  String? qualificationId;
  String? specialization;
  String? specializationId;
  String? preferredLocation;
  String? currentSalary;
  String? expectedSalary;
  String? collegeName;
  String? collegeId;
  String? startYear;
  String? endYear;
  String? currentPercentage;
  String? currentArrears;
  String? historyOfArrears;
  String? resume;
  String? dob;
  String? nationality;
  String? location;
  int? profilePercentage;
  String? referralCode;
  int? totalReferral;
  String? referralUrl;
  String? skill;
  String? skillSet;
  String? differentlyAbled;
  String? passport;
  String? careerBreak;
  List<Employment>? employment;
  List<Education>? education;
  ScheduleRequested? scheduleRequested;
  ScheduleRequested? candidateReschedule;
  ScheduleRequested? recruiterReschedule;
  ScheduleRequested? scheduleAccepted;
  ScheduleRequested? interviewReschedule;
  String? languagesknown;

  CandidateCampusProfileData(
      {this.candidateId,
        this.name,
        this.profilePic,
        this.email,
        this.phone,
        this.address,
        this.gender,
        this.maritalStatus,
        this.careerStatus,
        this.designation,
        this.designationId,
        this.experience,
        this.qualification,
        this.qualificationId,
        this.specialization,
        this.specializationId,
        this.preferredLocation,
        this.currentSalary,
        this.expectedSalary,
        this.collegeName,
        this.collegeId,
        this.startYear,
        this.endYear,
        this.currentPercentage,
        this.currentArrears,
        this.historyOfArrears,
        this.resume,
        this.dob,
        this.nationality,
        this.location,
        this.profilePercentage,
        this.referralCode,
        this.totalReferral,
        this.referralUrl,
        this.skill,
        this.skillSet,
        this.differentlyAbled,
        this.passport,
        this.careerBreak,
        this.employment,
        this.education,
        this.scheduleRequested,
        this.candidateReschedule,
        this.recruiterReschedule,
        this.scheduleAccepted,
        this.interviewReschedule,
        this.languagesknown
      });

  CandidateCampusProfileData.fromJson(Map<String, dynamic> json) {
    candidateId = json['candidate_id'];
    name = json['name'];
    profilePic = json['profile_pic'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    gender = json['gender'];
    maritalStatus = json['marital_status'];
    careerStatus = json['career_status'];
    designation = json['designation'];
    designationId = json['designation_id'];
    experience = json['experience'];
    qualification = json['qualification'];
    qualificationId = json['qualification_id'];
    specialization = json['specialization'];
    specializationId = json['specialization_id'];
    preferredLocation = json['preferred_location'];
    currentSalary = json['current_salary'];
    expectedSalary = json['expected_salary'];
    collegeName = json['college_name'];
    collegeId = json['college_id'];
    startYear = json['start_year'];
    endYear = json['end_year'];
    currentPercentage = json['current_percentage'];
    currentArrears = json['current_arrears'];
    historyOfArrears = json['history_of_arrears'];
    resume = json['resume'];
    dob = json['dob'];
    nationality = json['nationality'];
    location = json['location'];
    profilePercentage = json['profile_percentage'];
    referralCode = json['referral_code'];
    totalReferral = json['total_referral'];
    referralUrl = json['referral_url'];
    skill = json['skill'];
    languagesknown = json['language_known'];
    skillSet = json['skill_set'];
    differentlyAbled = json['differently_abled'];
    passport = json['passport'];
    careerBreak = json['career_break'];
    if (json['employment'] != []) {
      employment = <Employment>[];
      json['employment'].forEach((v) {
        employment!.add(new Employment.fromJson(v));
      });
    }
    if (json['education'] != []) {
      education = <Education>[];
      json['education'].forEach((v) {
        education!.add(new Education.fromJson(v));
      });
    }
    dynamic qwerty = json['schedule_requested'];
    dynamic qwerty1 = json['candidate_reschedule'];
    dynamic qwerty2 = json['recruiter_reschedule'];
    dynamic qwerty3 = json['schedule_accepted'];
    dynamic qwerty4 = json['interview_reschedule'];

    if (qwerty is List)
      {

      }
    else
      {
        scheduleRequested = new ScheduleRequested.fromJson(json['schedule_requested']);
      }

    if (qwerty1 is List)
    {

    }
    else
    {
      candidateReschedule = new ScheduleRequested.fromJson(json['candidate_reschedule']);
    }

    if (qwerty2 is List)
    {

    }
    else
    {
      recruiterReschedule = new ScheduleRequested.fromJson(json['recruiter_reschedule']);
    }

    if (qwerty3 is List)
    {

    }
    else
    {
      scheduleAccepted = new ScheduleRequested.fromJson(json['schedule_accepted']);
    }
    if(qwerty4 is List){

    }else{
      interviewReschedule = new ScheduleRequested.fromJson(json["interview_reschedule"]);
    }



  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['candidate_id'] = this.candidateId;
    data['name'] = this.name;
    data['profile_pic'] = this.profilePic;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['gender'] = this.gender;
    data['marital_status'] = this.maritalStatus;
    data['career_status'] = this.careerStatus;
    data['designation'] = this.designation;
    data['designation_id'] = this.designationId;
    data['experience'] = this.experience;
    data['qualification'] = this.qualification;
    data['qualification_id'] = this.qualificationId;
    data['specialization'] = this.specialization;
    data['specialization_id'] = this.specializationId;
    data['preferred_location'] = this.preferredLocation;
    data['current_salary'] = this.currentSalary;
    data['expected_salary'] = this.expectedSalary;
    data['college_name'] = this.collegeName;
    data['college_id'] = this.collegeId;
    data['start_year'] = this.startYear;
    data['end_year'] = this.endYear;
    data['current_percentage'] = this.currentPercentage;
    data['current_arrears'] = this.currentArrears;
    data['history_of_arrears'] = this.historyOfArrears;
    data['resume'] = this.resume;
    data['dob'] = this.dob;
    data['nationality'] = this.nationality;
    data['location'] = this.location;
    data['profile_percentage'] = this.profilePercentage;
    data['referral_code'] = this.referralCode;
    data['total_referral'] = this.totalReferral;
    data['referral_url'] = this.referralUrl;
    data['skill'] = this.skill;
    data['skill_set'] = this.skillSet;
    data['differently_abled'] = this.differentlyAbled;
    data['passport'] = this.passport;
    data['language_known'] = this.languagesknown;
    data['career_break'] = this.careerBreak;
    if (this.employment != null) {
      data['employment'] = this.employment!.map((v) => v.toJson()).toList();
    }
    if (this.education != null) {
      data['education'] = this.education!.map((v) => v.toJson()).toList();
    }
    if (this.scheduleRequested != null) {
      data['schedule_requested'] = this.scheduleRequested!.toJson();
    }
    if (this.candidateReschedule != null) {
      data['candidate_reschedule'] = this.candidateReschedule!.toJson();
    }
    if (this.recruiterReschedule != null) {
      data['recruiter_reschedule'] = this.recruiterReschedule!.toJson();
    }
    if (this.scheduleAccepted != null) {
      data['schedule_accepted'] = this.scheduleAccepted!.toJson();
    }if(this.interviewReschedule !=null){
      data['interview_reschedule'] = this.interviewReschedule!.toJson();
    }
    return data;
  }
}

class Employment {
  String? id;
  String? jobRole;
  String? companyName;
  String? jobType;
  String? startDate;
  String? endDate;
  String? noticePeriod;
  String? description;

  Employment(
      {this.id,
        this.jobRole,
        this.companyName,
        this.jobType,
        this.startDate,
        this.endDate,
        this.noticePeriod,
        this.description});

  Employment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobRole = json['job_role'];
    companyName = json['company_name'];
    jobType = json['job_type'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    noticePeriod = json['notice_period'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['job_role'] = this.jobRole;
    data['company_name'] = this.companyName;
    data['job_type'] = this.jobType;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['notice_period'] = this.noticePeriod;
    data['description'] = this.description;
    return data;
  }
}

class Education {
  String? id;
  String? institute;
  String? qualification;
  String? specialization;
  String? educationType;
  String? cgpa;
  String? startDate;
  String? endDate;

  Education(
      {this.id,
        this.institute,
        this.qualification,
        this.specialization,
        this.educationType,
        this.cgpa,
        this.startDate,
        this.endDate});

  Education.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    institute = json['institute'];
    qualification = json['qualification'];
    specialization = json['specialization'];
    educationType = json['education_type'];
    cgpa = json['cgpa'];
    startDate = json['start_date'];
    endDate = json['end_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['institute'] = this.institute;
    data['qualification'] = this.qualification;
    data['specialization'] = this.specialization;
    data['education_type'] = this.educationType;
    data['cgpa'] = this.cgpa;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    return data;
  }
}

class ScheduleRequested {
  String? interviewDate;
  String? interviewTime;
  String? branch;

  ScheduleRequested({this.interviewDate, this.interviewTime, this.branch});

  ScheduleRequested.fromJson(Map<String, dynamic> json) {
    interviewDate = json['interview_date'];
    interviewTime = json['interview_time'];
    branch = json['branch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['interview_date'] = this.interviewDate;
    data['interview_time'] = this.interviewTime;
    data['branch'] = this.branch;
    return data;
  }
}
