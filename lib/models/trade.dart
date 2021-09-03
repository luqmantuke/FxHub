class TradeModel {
  String pair;
  String result;
  String description;
  DateTime dateTime;

  TradeModel(
      {required this.pair,
      required this.result,
      required this.description,
      required this.dateTime});

  factory TradeModel.fromMap(Map<String, dynamic> map) {
    return TradeModel(
        pair: map['pair'] ?? '',
        result: map['result'] ?? '',
        description: map['description'] ?? '',
        dateTime: map['dateTime'].toDate() ?? '');
  }
  Map<String, dynamic> toJson() => {
        'pair': pair,
        'result': result,
        'description': description,
        'dateTime': DateTime.now()
      };
}
