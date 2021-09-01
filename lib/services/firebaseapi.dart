import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pipshub/authentication/authentication.dart';
import '../models/trade.dart';

class FirebaseApi {
  // CREATE USERTRADES
  static Future<String> createTrade(Trade trade) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final uID = AuthenticationService(_auth).getCurrentUID();
    print("UID B4 $uID");
    final docTrade = FirebaseFirestore.instance
        .collection("userData")
        .doc(uID.toString())
        .collection("trades");
    print("UID after $uID");

    await docTrade.add(trade.toJson());
    return docTrade.id;
  }
}
