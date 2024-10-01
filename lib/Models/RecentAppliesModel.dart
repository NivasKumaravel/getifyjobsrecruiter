

class RecentAppliesModel {
  bool? status;
  String? message;
  RecentAppliesData? data;

  RecentAppliesModel({this.status, this.message, this.data});

  RecentAppliesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new RecentAppliesData.fromJson(json['data']) : null;
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

class RecentAppliesData {
  Today? today;
  Today? all;
  Coins? coins;

  RecentAppliesData({this.today, this.all, this.coins});

  RecentAppliesData.fromJson(Map<String, dynamic> json) {
    today = json['today'] != null ? new Today.fromJson(json['today']) : null;
    all = json['all'] != null ? new Today.fromJson(json['all']) : null;
    coins = json['coins'] != null ? new Coins.fromJson(json['coins']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.today != null) {
      data['today'] = this.today!.toJson();
    }
    if (this.all != null) {
      data['all'] = this.all!.toJson();
    }
    if (this.coins != null) {
      data['coins'] = this.coins!.toJson();
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
  String? candidateId;
  String? jobTitle;
  String? name;
  String? profilePic;
  String? appliedDate;

  Items(
      {this.jobId,
        this.candidateId,
        this.jobTitle,
        this.name,
        this.profilePic,
        this.appliedDate});

  Items.fromJson(Map<String, dynamic> json) {
    jobId = json['job_id'];
    candidateId = json['candidate_id'];
    jobTitle = json['job_title'];
    name = json['name'];
    profilePic = json['profile_pic'];
    appliedDate = json['applied_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['job_id'] = this.jobId;
    data['candidate_id'] = this.candidateId;
    data['job_title'] = this.jobTitle;
    data['name'] = this.name;
    data['profile_pic'] = this.profilePic;
    data['applied_date'] = this.appliedDate;
    return data;
  }
}

class Coins {
  String? coins;

  Coins({this.coins});

  Coins.fromJson(Map<String, dynamic> json) {
    coins = json['coins'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['coins'] = this.coins;
    return data;
  }
}
