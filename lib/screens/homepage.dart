import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:pipshub/screens/course/course_list.dart';
import 'package:pipshub/screens/news/news_list.dart';
import 'package:pipshub/screens/trades/add_trade.dart';
import 'package:pipshub/utils/contants.dart';

import 'package:pipshub/widgets/list_trades.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<Widget> _screenOptions = [ListTrades(), NewsList(), CourseList()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent.withOpacity(1),
        centerTitle: true,
        title: Text(
          'PIPSHUB',
          style: TextStyle(
            color: facebookColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        elevation: 0.0,
        // automaticallyImplyLeading: false,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.all(0),
          children: [
            Container(
                height: MediaQuery.of(context).size.height / 4,
                color: Colors.blue),
            ListTile(
              leading: Icon(Icons.share),
              title: Text("Share with Friends"),
              onTap: () async {
                Share.share(
                    'Check out PIPSHUB, an app for Forex trading that provides Trade Tracking System, Economic News Alert, together with different courses for FREE.  https://play.google.com/store/apps/details?id=com.tukesolutions.pipshub');
              },
            ),
            ListTile(
                leading: Icon(Icons.rate_review),
                title: Text("Rate and Review"),
                onTap: () async {
                  var url =
                      'https://play.google.com/store/apps/details?id=com.tukesolutions.pipshub';
                  if (await canLaunch(url)) {
                    await launch(url);
                  }
                }),
            ListTile(
              leading: Icon(FontAwesomeIcons.telegram),
              title: Text("Join Our Telegram Channel"),
              onTap: () async {
                var url = 'https://t.me/pipshubappchannel';
                if (await canLaunch(url)) {
                  await launch(url);
                }
              },
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.headset),
              title: Text("Contact Support On Telegram"),
              onTap: () async {
                var url = 'https://t.me/pipshubapp';
                if (await canLaunch(url)) {
                  await launch(url);
                }
              },
            ),
          ],
        ),
      ),
      body: _screenOptions.elementAt(_selectedIndex),
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              child: Icon(Icons.add_circle_outline_rounded, size: 45),
              onPressed: () async {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddTrade(),
                  ),
                );
              },
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0.5,
        selectedItemColor: activeColor,
        selectedLabelStyle: TextStyle(
          color: googleColor,
        ),
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.chartLine,
            ),
            label: 'Trades',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.bullhorn,
            ),
            label: 'News',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.playCircle,
            ),
            label: 'Course',
          ),
        ],
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
      ),
    );
  }
}
