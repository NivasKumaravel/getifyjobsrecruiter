class InvoiceModel {
  bool? status;
  String? message;
  InvoiceData? data;

  InvoiceModel({this.status, this.message, this.data});

  InvoiceModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new InvoiceData.fromJson(json['data']) : null;
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

class InvoiceData {
  List<Invoice>? invoice;

  InvoiceData({this.invoice});

  InvoiceData.fromJson(Map<String, dynamic> json) {
    if (json['invoice'] != null) {
      invoice = <Invoice>[];
      json['invoice'].forEach((v) {
        invoice!.add(new Invoice.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.invoice != null) {
      data['invoice'] = this.invoice!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Invoice {
  String? id;
  String? amount;
  String? transactionId;
  String? createdAt;

  Invoice({this.id, this.amount, this.transactionId, this.createdAt});

  Invoice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    transactionId = json['transaction_id'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['amount'] = this.amount;
    data['transaction_id'] = this.transactionId;
    data['created_at'] = this.createdAt;
    return data;
  }
}
