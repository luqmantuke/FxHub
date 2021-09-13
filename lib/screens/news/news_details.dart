import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NewsDetails extends StatelessWidget {
  String image;
  String title;
  String sentiment;
  String prediction;
  String details;
  String dateTime;
  String pair;

  NewsDetails(
      {required this.title,
      required this.image,
      required this.details,
      required this.sentiment,
      required this.dateTime,
      required this.pair,
      required this.prediction});
  TextStyle sentimentStyle() {
    if (sentiment == 'MOD') {
      return TextStyle(
          backgroundColor: Colors.orangeAccent,
          color: Colors.black,
          fontSize: 15,
          fontWeight: FontWeight.bold);
    } else if (sentiment == 'LOW') {
      return TextStyle(
          backgroundColor: Colors.greenAccent,
          color: Colors.black,
          fontSize: 15,
          fontWeight: FontWeight.bold);
    } else {
      return TextStyle(
          backgroundColor: Colors.red,
          color: Colors.black,
          fontSize: 15,
          fontWeight: FontWeight.bold);
    }
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent.withOpacity(1),
        title: Text(pair),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 10),
            Container(
              child: Text(title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 10),
            Container(
              child: Text(
                "DateTime:  $dateTime",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Container(
              child: Text(
                sentiment,
                style: sentimentStyle(),
              ),
            ),
            SizedBox(height: 10),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(right: 13, left: 20),
                height: orientation == Orientation.portrait
                    ? MediaQuery.of(context).size.height / 1.4
                    : MediaQuery.of(context).size.height / 2,
                child: SingleChildScrollView(
                  child: Text(
                    details,
                    style: TextStyle(
                      fontSize: 18,
                      wordSpacing: 4,
                      letterSpacing: 2,
                    ),
                    softWrap: true,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
