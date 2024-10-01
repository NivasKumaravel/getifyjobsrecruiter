class DirectApplyListModel {
  bool? status;
  String? message;
  Data? data;

  DirectApplyListModel({this.status, this.message, this.data});

  DirectApplyListModel.fromJson(Map<String, dynamic> json) {
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
  Today? today;
  Today? all;

  Data({this.today, this.all});

  Data.fromJson(Map<String, dynamic> json) {
    today = json['today'] != null ? new Today.fromJson(json['today']) : null;
    all = json['all'] != null ? new Today.fromJson(json['all']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.today != null) {
      data['today'] = this.today!.toJson();
    }
    if (this.all != null) {
      data['all'] = this.all!.toJson();
    }
    return data;
  }
}

class Today {
  int? totalItems;
  List<Items>? items;

  Today({this.totalItems, this.items});

  Today.fromJson(Map<String, dynamic> json) {
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
    data['total_items'] = this.totalItems;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? jobId;
  String? jobTitle;
  String? name;
  String? profilePic;
  String? appliedDate;

  Items(
      {this.jobId,
        this.jobTitle,
        this.name,
        this.profilePic,
        this.appliedDate});

  Items.fromJson(Map<String, dynamic> json) {
    jobId = json['job_id'];
    jobTitle = json['job_title'];
    name = json['name'];
    profilePic = json['profile_pic'];
    appliedDate = json['applied_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['job_id'] = this.jobId;
    data['job_title'] = this.jobTitle;
    data['name'] = this.name;
    data['profile_pic'] = this.profilePic;
    data['applied_date'] = this.appliedDate;
    return data;
  }
}
