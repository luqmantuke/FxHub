class TradeModel {
  String pair;
  String result;
  String description;
  DateTime dateTime;
  int amount;
  TradeModel(
      {required this.pair,
      required this.result,
      required this.description,
      required this.amount,
      required this.dateTime});

  factory TradeModel.fromMap(Map<String, dynamic> map) {
    return TradeModel(
        pair: map['pair'] ?? '',
        result: map['result'] ?? '',
        description: map['description'] ?? '',
        amount: map['amount'] ?? '',
        dateTime: map['dateTime'].toDate() ?? '');
  }
  Map<String, dynamic> toJson() => {
        'pair': pair,
        'result': result,
        'description': description,
        'amount': amount,
        'dateTime': dateTime,
      };
}
