import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pipshub/authentication/authentication.dart';
import 'package:pipshub/models/trade.dart';
import 'package:pipshub/services/firebaseapi.dart';
import 'package:flutter/material.dart';

class Trades with ChangeNotifier {
// Get Trades As Stream
  Stream<QuerySnapshot> fetchTradesasSteam() {
    final _firebaseApi = FirebaseApi();
    FirebaseAuth _auth = FirebaseAuth.instance;
    final uID = AuthenticationService(_auth).getCurrentUID();
    return _firebaseApi.streamtradesCollection(uID);
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
