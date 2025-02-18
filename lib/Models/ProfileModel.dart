class ProfileModel {
  bool? status;
  String? message;
  ProfileData? data;

  ProfileModel({this.status, this.message, this.data});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new ProfileData.fromJson(json['data']) : null;
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

class ProfileData {
  String? recruiterId;
  String? logo;
  String? name;
  String? companyName;
  String? companyStartDate;
  String? aboutCompany;
  String? email;
  String? phone;
  String? personalPhone;
  String? location;
  String? address;
  String? dob;
  String? industry;
  String? industryId;
  List<Branch>? branch;
  String? qrCode;
  String? qrImage;
  String? referral_code;
  int? total_referral;
  String? coins;

  ProfileData(
      {this.recruiterId,
        this.logo,
        this.name,
        this.companyName,
        this.companyStartDate,
        this.aboutCompany,
        this.email,
        this.phone,
        this.personalPhone,
        this.location,
        this.address,
        this.dob,
        this.industry,
        this.industryId,
        this.branch,
        this.qrCode,
        this.qrImage,
        this.referral_code,
        this.total_referral,
        this.coins
      });

  ProfileData.fromJson(Map<String, dynamic> json) {
    recruiterId = json['recruiter_id'];
    logo = json['logo'];
    name = json['name'];
    companyName = json['company_name'];
    companyStartDate = json['company_start_date'];
    aboutCompany = json['about_company'];
    email = json['email'];
    phone = json['phone'];
    personalPhone = json['personal_phone'];
    location = json['location'];
    address = json['address'];
    dob = json['dob'];
    industry = json['industry'];
    industryId = json['industry_id'];
    qrCode = json['qr_code'];
    qrImage = json['qr_image'];
    coins = json['coins'];
    referral_code = json['referral_code'];
    total_referral = json['total_referral'];
    if (json['branch'] != null) {
      branch = <Branch>[];
      json['branch'].forEach((v) {
        branch!.add(new Branch.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['recruiter_id'] = this.recruiterId;
    data['logo'] = this.logo;
    data['name'] = this.name;
    data['company_name'] = this.companyName;
    data['company_start_date'] = this.companyStartDate;
    data['about_company'] = this.aboutCompany;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['personal_phone'] = this.personalPhone;
    data['location'] = this.location;
    data['address'] = this.address;
    data['dob'] = this.dob;
    data['industry'] = this.industry;
    data['industry_id'] = this.industryId;
    data['qr_code'] = this.qrCode;
    data['qr_image'] = this.qrImage;
    data['coins'] = this.coins;
    data['referral_code'] = this.referral_code;
    data['total_referral'] = this.total_referral;
    if (this.branch != null) {
      data['branch'] = this.branch!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Branch {
  String? branchId;
  String? branchAddress;
  String? branchName;
  String? branchPhone;
  String? branchEmail;

  Branch(
      {this.branchId,
        this.branchAddress,
        this.branchName,
        this.branchPhone,
        this.branchEmail});

  Branch.fromJson(Map<String, dynamic> json) {
    branchId = json['branch_id'];
    branchAddress = json['branch_address'];
    branchName = json['branch_name'];
    branchPhone = json['branch_phone'];
    branchEmail = json['branch_email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['branch_id'] = this.branchId;
    data['branch_address'] = this.branchAddress;
    data['branch_name'] = this.branchName;
    data['branch_phone'] = this.branchPhone;
    data['branch_email'] = this.branchEmail;
    return data;
  }
}
