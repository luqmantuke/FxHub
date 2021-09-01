import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class NewsList extends StatefulWidget {
  const NewsList({Key? key}) : super(key: key);

  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
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
                onTap: () {
                  print("YESTERDAY");
                },
              ),
              GestureDetector(
                child: dateFilter("TODAY"),
                onTap: () {
                  print("TODAY");
                },
              ),
              GestureDetector(
                child: dateFilter("TOMORROW"),
                onTap: () {
                  print("TOMORROW");
                },
              ),
              GestureDetector(
                child: dateFilter("THIS WEEK"),
                onTap: () {
                  print("THIS WEEK");
                },
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
          SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height / 1.6,
              child: Card(
                child: ListTile(
                  leading: CachedNetworkImage(
                    height: MediaQuery.of(context).size.height / 3,
                    imageUrl:
                        "https://icons.iconarchive.com/icons/custom-icon-design/all-country-flag/256/European-Union-Flag-icon.png",
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  title: Text(
                    'GROSS DOMESTIC PRODUCT',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  subtitle: RichText(
                    text: TextSpan(
                      text: '',
                      children: [
                        TextSpan(
                          text: 'MOD',
                          style: TextStyle(
                              backgroundColor: Colors.orangeAccent,
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: ' ',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text:
                              'Actual 0.01%  Constensus 0.02%  Previous 0.01%',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  isThreeLine: true,
                  trailing: Text(
                    "EUR",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      backgroundColor: Colors.lightBlueAccent.withOpacity(1),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
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
