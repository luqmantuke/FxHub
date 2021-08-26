import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pipshub/authentication/authentication.dart';
import 'package:provider/provider.dart';
import '../models/trade.dart';

class FirebaseApi {
  // CREATE USERTRADES
  static Future<String> createTrade(Trade trade) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final uID = AuthenticationService(_auth).getCurrentUID();
    final docTrade = FirebaseFirestore.instance
        .collection("userData")
        .doc(uID.toString())
        .collection("trades");

    await docTrade.add(trade.toJson());
    return docTrade.id;
  }

  // DELETE USERTRADES
  static Future<String> deleteTrade(Trade trade) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final uID = AuthenticationService(_auth).getCurrentUID();
    await FirebaseFirestore.instance
        .collection("userData")
        .doc(uID.toString())
        .collection("trades")
        .doc()
        .delete();
    return uID;
  }
}
