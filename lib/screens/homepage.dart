import 'dart:ui';

import 'package:firebaseauth/provider/trades.dart';
import 'package:firebaseauth/widgets/list_trades.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../config/pallete.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent.withOpacity(1),
          centerTitle: true,
          title: Text(
            'FxHub',
            style: TextStyle(
              color: Palette.facebookColor,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          elevation: 0.0,
        ),
        body: ListTrades(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add_circle_outline_rounded, size: 45),
          onPressed: () {},
        ),
        drawer: Drawer(),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0.5,
          selectedItemColor: Palette.activeColor,
          selectedLabelStyle: TextStyle(
            color: Palette.googleColor,
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
        ));
  }
}
