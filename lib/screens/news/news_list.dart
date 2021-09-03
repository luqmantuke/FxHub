import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:pipshub/models/news.dart';
import 'package:pipshub/provider/news.dart';
import 'package:provider/provider.dart';

class NewsList extends StatefulWidget {
  const NewsList({Key? key}) : super(key: key);

  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsCrudModel>(context);
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: newsProvider.fetchNewsasSteam(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final news = snapshot.data!.docs
                  .map((news) =>
                      NewsModel.fromMap(news.data() as Map<String, dynamic>))
                  .toList();
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          child: dateFilter("YESTERDAY"),
                          onTap: () {},
                        ),
                        GestureDetector(
                          child: dateFilter("TODAY"),
                          onTap: () {},
                        ),
                        GestureDetector(
                          child: dateFilter("TOMORROW"),
                          onTap: () {},
                        ),
                        GestureDetector(
                          child: dateFilter("THIS WEEK"),
                          onTap: () {},
                        ),
                      ],
                    ),

                    SizedBox(height: 20),
                    // CONTAINER SHOWING TODAY'S DATE

                    Container(
                      height: MediaQuery.of(context).size.height / 30,
                      color: Colors.green.shade50,
                      child: Center(
                        child: Text("TUESDAY, 31 AUG 2021(12 EVENTS)",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ),

                    SizedBox(height: 40),

                    // CONTAINER SHOWING LIST OF CALENDARS IN FORM OF LISTTILE
                    Container(
                      height: MediaQuery.of(context).size.height / 1.6,
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

                                return ListTile(
                                  leading: CachedNetworkImage(
                                    height:
                                        MediaQuery.of(context).size.height / 3,
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
                                          text: formattedDateTime.toString(),
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
                                      backgroundColor:
                                          Colors.lightBlueAccent.withOpacity(1),
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
