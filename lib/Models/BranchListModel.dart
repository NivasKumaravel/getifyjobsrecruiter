class BranchListModel {
  bool? status;
  String? message;
  List<BranchListData>? data;

  BranchListModel({this.status, this.message, this.data});

  BranchListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <BranchListData>[];
      json['data'].forEach((v) {
        data!.add(new BranchListData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BranchListData {
  String? branchId;
  String? branchName;
  String? branchPhone;
  String? branchEmail;
  String? branchAddress;

  BranchListData(
      {this.branchId,
        this.branchName,
        this.branchPhone,
        this.branchEmail,
        this.branchAddress});

  BranchListData.fromJson(Map<String, dynamic> json) {
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
