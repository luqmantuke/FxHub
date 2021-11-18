import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:pipshub/models/news.dart';
import 'package:pipshub/provider/news.dart';
import 'package:pipshub/screens/news/news_details.dart';
import 'package:provider/provider.dart';

class NewsList extends StatefulWidget {
  const NewsList({Key? key}) : super(key: key);

  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  var newsDateFilter = 'today';
  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsCrudModel>(context);
    final orientation = MediaQuery.of(context).orientation;
    final oopsNews = newsDateFilter.toUpperCase();
    streamFilter() {
      if (newsDateFilter == 'today') {
        return newsProvider.fetchNewsasSteamToday();
      } else if (newsDateFilter == 'yesterday') {
        return newsProvider.fetchNewsasSteamYesterday();
      } else if (newsDateFilter == 'tomorrow') {
        return newsProvider.fetchNewsasSteamTomorrow();
      } else if (newsDateFilter == 'week') {
        return newsProvider.fetchNewsasSteamWeek();
      }
    }

    DateTime _now = DateTime.now();
    DateTime yesterday = DateTime(_now.year, _now.month, _now.day - 1, 0, 0);
    DateTime today = DateTime(_now.year, _now.month, _now.day, 0, 0);
    DateTime tomorrow = DateTime(_now.year, _now.month, _now.day + 1, 0, 0);
    date() {
      if (newsDateFilter == 'today') {
        return Text(DateFormat('yyyy-MM-dd').format(today),
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ));
      } else if (newsDateFilter == 'yesterday') {
        return Text(DateFormat('yyyy-MM-dd').format(yesterday),
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ));
      } else if (newsDateFilter == 'tomorrow') {
        return Text(DateFormat('yyyy-MM-dd').format(tomorrow),
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ));
      } else if (newsDateFilter == 'week') {
        return Text("Monday-Friday",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ));
      }
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot>(
            stream: streamFilter(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final news = snapshot.data!.docs
                    .map((news) =>
                        NewsModel.fromMap(news.data() as Map<String, dynamic>))
                    .toList();
                if (snapshot.data!.size == 0) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/images/oops.svg",
                          height: MediaQuery.of(context).size.height / 4,
                        ),
                        SizedBox(height: 17),
                        Text(
                          "You've no Sensitive news for $oopsNews.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 17),

                        // ROW WITH LIST OF DATEFILTERS
                        Container(
                          padding: EdgeInsets.only(left: 15, right: 10),
                          height: orientation == Orientation.portrait
                              ? MediaQuery.of(context).size.height / 30
                              : MediaQuery.of(context).size.height / 25,
                          width: orientation == Orientation.portrait
                              ? MediaQuery.of(context).size.width
                              : MediaQuery.of(context).size.width / 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                child: dateFilter("YESTERDAY"),
                                onTap: () {
                                  setState(() {
                                    newsDateFilter = 'yesterday';
                                  });
                                },
                              ),
                              GestureDetector(
                                child: dateFilter("TODAY"),
                                onTap: () {
                                  setState(() {
                                    newsDateFilter = 'today';
                                  });
                                },
                              ),
                              GestureDetector(
                                child: dateFilter("TOMORROW"),
                                onTap: () {
                                  setState(() {
                                    newsDateFilter = 'tomorrow';
                                  });
                                },
                              ),
                              GestureDetector(
                                child: dateFilter("THIS WEEK"),
                                onTap: () {
                                  setState(() {
                                    newsDateFilter = 'week';
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return Container(
                  padding: EdgeInsets.only(top: 5, right: 15, left: 15),
                  child: Column(
                    children: [
                      // CONTAINER 1(NEWS HEADER)
                      Container(
                        child: Center(
                          child: Text(
                            '',
                            style: TextStyle(
                              fontSize: 23,
                              // fontWeight: FontWeight.bold,
                              fontFamily: 'Kaushan',
                            ),
                          ),
                        ),
                      ),

                      // ROW WITH LIST OF DATEFILTERS
                      Container(
                        height: orientation == Orientation.portrait
                            ? MediaQuery.of(context).size.height / 30
                            : MediaQuery.of(context).size.height / 20,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              child: dateFilter("YESTERDAY"),
                              onTap: () {
                                setState(() {
                                  newsDateFilter = 'yesterday';
                                });
                              },
                            ),
                            GestureDetector(
                              child: dateFilter("TODAY"),
                              onTap: () {
                                setState(() {
                                  newsDateFilter = 'today';
                                });
                              },
                            ),
                            GestureDetector(
                              child: dateFilter("TOMORROW"),
                              onTap: () {
                                setState(() {
                                  newsDateFilter = 'tomorrow';
                                });
                              },
                            ),
                            GestureDetector(
                              child: dateFilter("THIS WEEK"),
                              onTap: () {
                                setState(() {
                                  newsDateFilter = 'week';
                                });
                              },
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 20),
                      // CONTAINER SHOWING TODAY'S DATE

                      Container(
                        height: orientation == Orientation.portrait
                            ? MediaQuery.of(context).size.height / 30
                            : MediaQuery.of(context).size.height / 17,
                        color: Colors.green.shade50,
                        child: Center(
                          child: date(),
                        ),
                      ),

                      SizedBox(height: 10),

                      // CONTAINER SHOWING LIST OF CALENDARS IN FORM OF LISTTILE
                      Container(
                        height: orientation == Orientation.portrait
                            ? MediaQuery.of(context).size.height / 1.6
                            : MediaQuery.of(context).size.height / 2.7,
                        child: Card(
                            child: ListView.builder(
                                itemCount: news.length,
                                itemBuilder: (context, index) {
                                  final docSnapshot = news[index];
                                  TextStyle sentimentStyle() {
                                    if (docSnapshot.sentiment == 'MOD') {
                                      return TextStyle(
                                          backgroundColor: Colors.orangeAccent,
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold);
                                    } else if (docSnapshot.sentiment == 'LOW') {
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

                                  DateTime myDateTime = docSnapshot.dateTime;
                                  String formattedDateTime =
                                      DateFormat('yyyy-MM-dd – kk:mm')
                                          .format(myDateTime);

                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) => NewsDetails(
                                                    title: docSnapshot.title,
                                                    image: docSnapshot.image,
                                                    details:
                                                        docSnapshot.details,
                                                    sentiment:
                                                        docSnapshot.sentiment,
                                                    prediction:
                                                        docSnapshot.prediction,
                                                    dateTime: formattedDateTime,
                                                    pair: docSnapshot.pair,
                                                  )));
                                    },
                                    child: ListTile(
                                      leading: CachedNetworkImage(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                3,
                                        imageUrl: docSnapshot.image,
                                        placeholder: (context, url) =>
                                            CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                      title: Text(
                                        docSnapshot.title,
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: RichText(
                                        text: TextSpan(
                                          text: '',
                                          children: [
                                            TextSpan(
                                              text: docSnapshot.sentiment,
                                              style: sentimentStyle(),
                                            ),
                                            TextSpan(
                                              text: ' ',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            TextSpan(
                                              text: docSnapshot.prediction,
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                              ),
                                            ),
                                            TextSpan(
                                              text: " ",
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  formattedDateTime.toString(),
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      isThreeLine: true,
                                      trailing: Text(
                                        docSnapshot.pair,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          backgroundColor: Colors
                                              .lightBlueAccent
                                              .withOpacity(1),
                                        ),
                                      ),
                                    ),
                                  );
                                })),
                      ),
                    ],
                  ),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }

  Container dateFilter(String text) {
    return Container(
      decoration: BoxDecoration(
        // shape: BoxShape.circle,
        borderRadius: BorderRadius.circular(12),
        color: Colors.lightBlueAccent.withOpacity(1),
        border: Border.all(
          color: Colors.lightBlueAccent.withOpacity(1),
          width: 1,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }
}
