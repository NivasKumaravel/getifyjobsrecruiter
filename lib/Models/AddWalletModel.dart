class AddWalletModel {
  bool? status;
  String? message;
  List<AddWalletData>? data;

  AddWalletModel({this.status, this.message, this.data});

  AddWalletModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <AddWalletData>[];
      json['data'].forEach((v) {
        data!.add(new AddWalletData.fromJson(v));
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

class AddWalletData {
  String? id;
  String? amount;
  String? message;
  String? coin;
  String? status;
  String? createdAt;
  String? updatedAt;

  AddWalletData(
      {this.id,
        this.amount,
        this.message,
        this.coin,
        this.status,
        this.createdAt,
        this.updatedAt});

  AddWalletData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    message = json['message'];
    coin = json['coin'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['amount'] = this.amount;
    data['message'] = this.message;
    data['coin'] = this.coin;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
