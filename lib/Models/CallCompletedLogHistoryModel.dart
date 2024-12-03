class CallCompletedLogHistoryModel {
  bool? status;
  String? message;
  CallCompletedLogHistoryData? data;

  CallCompletedLogHistoryModel({this.status, this.message, this.data});

  CallCompletedLogHistoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new CallCompletedLogHistoryData.fromJson(json['data']) : null;
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

class CallCompletedLogHistoryData {
  List<Items>? items;

  CallCompletedLogHistoryData({this.items});

  CallCompletedLogHistoryData.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? message;
  String? date;

  Items({this.message, this.date});

  Items.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['date'] = this.date;
    return data;
  }
}
