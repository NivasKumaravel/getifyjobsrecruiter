class CampusDetailModel {
  bool? status;
  String? message;
  CampusData? data;

  CampusDetailModel({this.status, this.message, this.data});

  CampusDetailModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new CampusData.fromJson(json['data']) : null;
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

class CampusData {
  String? campusId;
  String? logo;
  String? name;
  String? about;
  String? recruitmentDate;
  String? industries;
  String? preferedDepartment;
  String? campusDrive;
  String? totalCompanies;
  String? foodFacility;
  String? location;
  String? volunteerStaffs;
  String? volunteerStudents;
  String? campusHeldAt;

  CampusData(
      {this.campusId,
        this.logo,
        this.name,
        this.about,
        this.recruitmentDate,
        this.industries,
        this.preferedDepartment,
        this.foodFacility,
        this.location,
        this.volunteerStaffs,
        this.volunteerStudents,
        this.campusHeldAt,
      this.campusDrive,
      this.totalCompanies,

      });

  CampusData.fromJson(Map<String, dynamic> json) {
    campusId = json['campus_id'];
    logo = json['logo'];
    name = json['name'];
    about = json['about'];
    recruitmentDate = json['recruitment_date'];
    industries = json['industries'];
    preferedDepartment = json['prefered_department'];
    foodFacility = json['food_facility'];
    location = json['location'];
    volunteerStaffs = json['volunteer_staffs'];
    volunteerStudents = json['volunteer_students'];
    campusHeldAt = json['campus_held_at'];
    campusDrive = json['campus_drive'];
    totalCompanies = json['total_companies'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['campus_id'] = this.campusId;
    data['logo'] = this.logo;
    data['name'] = this.name;
    data['about'] = this.about;
    data['recruitment_date'] = this.recruitmentDate;
    data['industries'] = this.industries;
    data['prefered_department'] = this.preferedDepartment;
    data['food_facility'] = this.foodFacility;
    data['location'] = this.location;
    data['volunteer_staffs'] = this.volunteerStaffs;
    data['volunteer_students'] = this.volunteerStudents;
    data['campus_held_at'] = this.campusHeldAt;
    data['campus_drive'] = this.campusDrive;
    data['total_companies'] = this.totalCompanies;
    return data;
  }
}
