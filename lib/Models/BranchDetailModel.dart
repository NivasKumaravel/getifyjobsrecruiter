class BranchDetailModel {
  bool? status;
  String? message;
  BranchDetailData? data;

  BranchDetailModel({this.status, this.message, this.data});

  BranchDetailModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new BranchDetailData.fromJson(json['data']) : null;
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

class BranchDetailData {
  String? branchId;
  String? branchName;
  String? branchPhone;
  String? branchEmail;
  String? branchAddress;

  BranchDetailData(
      {this.branchId,
        this.branchName,
        this.branchPhone,
        this.branchEmail,
        this.branchAddress});

  BranchDetailData.fromJson(Map<String, dynamic> json) {
    branchId = json['branch_id'];
    branchName = json['branch_name'];
    branchPhone = json['branch_phone'];
    branchEmail = json['branch_email'];
    branchAddress = json['branch_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['branch_id'] = this.branchId;
    data['branch_name'] = this.branchName;
    data['branch_phone'] = this.branchPhone;
    data['branch_email'] = this.branchEmail;
    data['branch_address'] = this.branchAddress;
    return data;
  }
}
