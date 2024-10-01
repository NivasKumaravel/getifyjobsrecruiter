class WalletHistoryModel {
  bool? status;
  String? message;
  WalletHistoryData? data;

  WalletHistoryModel({this.status, this.message, this.data});

  WalletHistoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new WalletHistoryData.fromJson(json['data']) : null;
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

class WalletHistoryData {
  String? coins;
  List<History>? history;

  WalletHistoryData({this.coins, this.history});

  WalletHistoryData.fromJson(Map<String, dynamic> json) {
    coins = json['coins'];
    if (json['history'] != null) {
      history = <History>[];
      json['history'].forEach((v) {
        history!.add(new History.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['coins'] = this.coins;
    if (this.history != null) {
      data['history'] = this.history!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class History {
  String? openingBalance;
  String? closingBalance;
  String? coins;
  String? transactionType;
  String? message;
  String? amount;
  String? created_at;

  History(
      {this.openingBalance,
        this.closingBalance,
        this.coins,
        this.transactionType,
        this.message,
        this.amount,
      this.created_at});

  History.fromJson(Map<String, dynamic> json) {
    openingBalance = json['opening_balance'];
    closingBalance = json['closing_balance'];
    coins = json['coins'];
    transactionType = json['transaction_type'];
    message = json['message'];
    amount = json['amount'];
    created_at = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['opening_balance'] = this.openingBalance;
    data['closing_balance'] = this.closingBalance;
    data['coins'] = this.coins;
    data['transaction_type'] = this.transactionType;
    data['message'] = this.message;
    data['amount'] = this.amount;
    data['created_at'] = this.created_at;
    return data;
  }
}
