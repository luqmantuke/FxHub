import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pipshub/authentication/authentication.dart';
import 'package:pipshub/models/trade.dart';
import 'package:pipshub/services/firebaseapi.dart';
import 'package:flutter/material.dart';

class Trades with ChangeNotifier {
// Get TODAY Trades As Stream
  Stream<QuerySnapshot> fetchTodayTradesasSteam() {
    final _firebaseApi = FirebaseApi();
    FirebaseAuth _auth = FirebaseAuth.instance;
    final uID = AuthenticationService(_auth).getCurrentUID();
    return _firebaseApi.streamTradesTodayCollection(uID);
  }

  // Get YESTERDAY Trades As Stream
  Stream<QuerySnapshot> fetchYesterdayTradesasSteam() {
    final _firebaseApi = FirebaseApi();
    FirebaseAuth _auth = FirebaseAuth.instance;
    final uID = AuthenticationService(_auth).getCurrentUID();
    return _firebaseApi.streamTradesYesterdayCollection(uID);
  }

  // Get WEEK Trades As Stream
  Stream<QuerySnapshot> fetchWeekTradesasSteam() {
    final _firebaseApi = FirebaseApi();
    FirebaseAuth _auth = FirebaseAuth.instance;
    final uID = AuthenticationService(_auth).getCurrentUID();
    return _firebaseApi.streamTradesWeekCollection(uID);
  }

  // Get MONTH Trades As Stream
  Stream<QuerySnapshot> fetchMonthTradesasSteam() {
    final _firebaseApi = FirebaseApi();
    FirebaseAuth _auth = FirebaseAuth.instance;
    final uID = AuthenticationService(_auth).getCurrentUID();
    return _firebaseApi.streamTradesMonthCollection(uID);
  }

  // Get ALL Trades As Stream
  Stream<QuerySnapshot> fetchAllTradesasSteam() {
    final _firebaseApi = FirebaseApi();
    FirebaseAuth _auth = FirebaseAuth.instance;
    final uID = AuthenticationService(_auth).getCurrentUID();
    return _firebaseApi.streamAlltradesCollection(uID);
  }

  // Delete Trades
  Future deleteTrade(String tradeID) async {
    final _firebaseApi = FirebaseApi();
    FirebaseAuth _auth = FirebaseAuth.instance;
    final uID = AuthenticationService(_auth).getCurrentUID();
    return _firebaseApi.deleteTrade(uID, tradeID);
  }

  // EDIT Trades
  Future editTrade(String tradeID, TradeModel tradeModel) async {
    final _firebaseApi = FirebaseApi();
    FirebaseAuth _auth = FirebaseAuth.instance;
    final uID = AuthenticationService(_auth).getCurrentUID();
    return _firebaseApi.editTrade(uID, tradeID, tradeModel.toJson());
  }

  // ADD Trades
  Future addTrade(TradeModel tradeModel) async {
    final _firebaseApi = FirebaseApi();
    FirebaseAuth _auth = FirebaseAuth.instance;
    final uID = AuthenticationService(_auth).getCurrentUID();
    return _firebaseApi.addTrade(uID, tradeModel.toJson());
  }
}
