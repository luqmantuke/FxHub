import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pipshub/services/firebaseapi.dart';

class NewsCrudModel extends ChangeNotifier {
  final _firebaseApi = FirebaseApi();
  Stream<QuerySnapshot> fetchNewsasSteamToday() {
    return _firebaseApi.streamtradeNewsTodayCollection();
  }

  // STREAM NEWS YESTERDAY
  Stream<QuerySnapshot> fetchNewsasSteamYesterday() {
    return _firebaseApi.streamtradeNewsYesterdayCollection();
  }

  // STREAM NEWS TOMORROW
  Stream<QuerySnapshot> fetchNewsasSteamTomorrow() {
    return _firebaseApi.streamtradeNewsTomorrowCollection();
  }

  // STREAM NEWS TOMORROW
  Stream<QuerySnapshot> fetchNewsasSteamWeek() {
    return _firebaseApi.streamtradeNewsWeekCollection();
  }
}
