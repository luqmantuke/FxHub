class NewsModel {
  DateTime dateTime;
  String details;
  String image;
  String sentiment;
  String pair;
  String prediction;
  String title;

  NewsModel(
      {required this.dateTime,
      required this.details,
      required this.image,
      required this.pair,
      required this.prediction,
      required this.sentiment,
      required this.title});

  factory NewsModel.fromMap(Map<String, dynamic> map) {
    return NewsModel(
        dateTime: map['dateTime'].toDate() ?? '',
        details: map['details'] ?? '',
        image: map['image'] ?? '',
        pair: map['pair'] ?? '',
        prediction: map['prediction'] ?? '',
        sentiment: map['sentiment'] ?? '',
        title: map['title'] ?? '');
  }
}
