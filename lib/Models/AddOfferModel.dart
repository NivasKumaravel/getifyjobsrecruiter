class AddOfferModel {
  bool? status;
  String? message;
  AddOfferData? data;

  AddOfferModel({this.status, this.message, this.data});

  AddOfferModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new AddOfferData.fromJson(json['data']) : null;
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

class AddOfferData {
  String? candidateId;

  AddOfferData({this.candidateId});

  AddOfferData.fromJson(Map<String, dynamic> json) {
    candidateId = json['candidate_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['candidate_id'] = this.candidateId;
    return data;
  }
}
