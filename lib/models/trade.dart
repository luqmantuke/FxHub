class Trade {
  String pair;
  String id;
  String result;
  String description;
  DateTime dateTime;

  Trade(
      {required this.pair,
      required this.id,
      required this.result,
      required this.description,
      required this.dateTime});
}
