import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pipshub/authentication/authentication.dart';
import '../models/trade.dart';

class FirebaseApi with ChangeNotifier {
  // void getAllNews() async {
  //   final stream = FirebaseFirestore.instance
  //       .collection("tradeNews")
  //       .orderBy('dateTime', descending: true)
  //       .snapshots();
  //   print(stream);
  //   notifyListeners();
}
