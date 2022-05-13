class Transaction {
  int? id;
  int? userId;
  String? amount;
  String? charge;
  String? postBalance;
  String? trxType;
  String? trx;
  String? details;
  String? createdAt;
  String? updatedAt;

  Transaction(
      {required this.id,
      required this.userId,
      required this.amount,
      required this.charge,
      required this.postBalance,
      required this.trxType,
      required this.trx,
      required this.details,
      required this.createdAt,
      required this.updatedAt});

  Transaction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    amount = json['amount'];
    charge = json['charge'];
    postBalance = json['post_balance'];
    trxType = json['trx_type'];
    trx = json['trx'];
    details = json['details'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['amount'] = this.amount;
    data['charge'] = this.charge;
    data['post_balance'] = this.postBalance;
    data['trx_type'] = this.trxType;
    data['trx'] = this.trx;
    data['details'] = this.details;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
