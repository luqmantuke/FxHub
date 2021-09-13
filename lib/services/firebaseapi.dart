import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseApi {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // STREAM TRADENEWS METHOD
  Stream<QuerySnapshot> streamtradeNewsTodayCollection() {
    DateTime _now = DateTime.now();
    DateTime _start = DateTime(_now.year, _now.month, _now.day, 0, 0);
    DateTime _end = DateTime(_now.year, _now.month, _now.day, 23, 59, 59);
    return _db
        .collection('tradeNews')
        .where('dateTime', isGreaterThanOrEqualTo: _start)
        .where('dateTime', isLessThanOrEqualTo: _end)
        .orderBy('dateTime', descending: true)
        .snapshots();
  }

  // STREAM TRADENEWS METHOD YESTERDAY
  Stream<QuerySnapshot> streamtradeNewsYesterdayCollection() {
    DateTime _now = DateTime.now();
    DateTime _start = DateTime(_now.year, _now.month, _now.day - 1, 0, 0);
    DateTime _end = DateTime(_now.year, _now.month, _now.day - 1, 23, 59, 59);

    return _db
        .collection('tradeNews')
        .where('dateTime', isGreaterThanOrEqualTo: _start)
        .where('dateTime', isLessThanOrEqualTo: _end)
        .orderBy('dateTime', descending: true)
        .snapshots();
  }

  // STREAM TRADENEWS METHOD TOMORROW
  Stream<QuerySnapshot> streamtradeNewsTomorrowCollection() {
    DateTime _now = DateTime.now();
    DateTime _start = DateTime(_now.year, _now.month, _now.day + 1, 0, 0);
    DateTime _end = DateTime(_now.year, _now.month, _now.day + 1, 23, 59, 59);
    return _db
        .collection('tradeNews')
        .where('dateTime', isGreaterThanOrEqualTo: _start)
        .where('dateTime', isLessThanOrEqualTo: _end)
        .orderBy('dateTime', descending: true)
        .snapshots();
  }

  // STREAM TRADENEWS METHOD THIS WEEK
  Stream<QuerySnapshot> streamtradeNewsWeekCollection() {
    DateTime _now = DateTime.now();
    DateTime _start = DateTime(_now.year, _now.month, _now.day - 1, 0, 0);
    DateTime _end = DateTime(_now.year, _now.month, _now.day + 5, 23, 59, 59);
    return _db
        .collection('tradeNews')
        .where('dateTime', isGreaterThanOrEqualTo: _start)
        .where('dateTime', isLessThanOrEqualTo: _end)
        .orderBy('dateTime', descending: false)
        .snapshots();
  }

  // STREAM Today TRADES METHOD
  Stream<QuerySnapshot> streamTradesTodayCollection(String uID) {
    DateTime _now = DateTime.now();
    DateTime _start = DateTime(_now.year, _now.month, _now.day, 0, 0);
    DateTime _end = DateTime(_now.year, _now.month, _now.day, 23, 59, 59);
    return _db
        .collection("userData")
        .doc(uID)
        .collection("trades")
        .where('dateTime', isGreaterThanOrEqualTo: _start)
        .where('dateTime', isLessThanOrEqualTo: _end)
        .orderBy('dateTime', descending: true)
        .snapshots();
  }

  // STREAM YESTERDAY TRADE METHOD
  Stream<QuerySnapshot> streamTradesYesterdayCollection(String uID) {
    DateTime _now = DateTime.now();
    DateTime _start = DateTime(_now.year, _now.month, _now.day - 1, 0, 0);
    DateTime _end = DateTime(_now.year, _now.month, _now.day - 1, 23, 59, 59);
    return _db
        .collection("userData")
        .doc(uID)
        .collection("trades")
        .where('dateTime', isGreaterThanOrEqualTo: _start)
        .where('dateTime', isLessThanOrEqualTo: _end)
        .orderBy('dateTime', descending: true)
        .snapshots();
  }

  // STREAM WEEK TRADE METHOD
  Stream<QuerySnapshot> streamTradesWeekCollection(String uID) {
    DateTime _now = DateTime.now();
    DateTime _start = DateTime(_now.year, _now.month, _now.day - 1, 0, 0);
    DateTime _end = DateTime(_now.year, _now.month, _now.day + 7, 23, 59, 59);
    return _db
        .collection("userData")
        .doc(uID)
        .collection("trades")
        .where('dateTime', isGreaterThanOrEqualTo: _start)
        .where('dateTime', isLessThanOrEqualTo: _end)
        .orderBy('dateTime', descending: true)
        .snapshots();
  }

  // STREAM MONTH TRADE METHOD
  Stream<QuerySnapshot> streamTradesMonthCollection(String uID) {
    DateTime _now = DateTime.now();
    DateTime _start = DateTime(_now.year, _now.month, _now.day - 1, 0, 0);
    DateTime _end = DateTime(_now.year, _now.month, _now.day + 30, 23, 59, 59);
    return _db
        .collection("userData")
        .doc(uID)
        .collection("trades")
        .where('dateTime', isGreaterThanOrEqualTo: _start)
        .where('dateTime', isLessThanOrEqualTo: _end)
        .orderBy('dateTime', descending: true)
        .snapshots();
  }

  // STREAM ALL TRADE METHOD
  Stream<QuerySnapshot> streamAlltradesCollection(String uID) {
    return _db
        .collection("userData")
        .doc(uID)
        .collection("trades")
        .orderBy('dateTime', descending: true)
        .snapshots();
  }

  // DELETE TRADES METHOD
  Future<void> deleteTrade(String uID, String tradeID) {
    return _db
        .collection("userData")
        .doc(uID)
        .collection("trades")
        .doc(tradeID)
        .delete();
  }

  // EDIT TRADES METHOD
  Future<void> editTrade(
      String uID, String tradeID, Map<String, Object?> trade) {
    return _db
        .collection("userData")
        .doc(uID)
        .collection("trades")
        .doc(tradeID)
        .update(trade);
  }

  // ADD TRADES METHOD
  Future<void> addTrade(String uID, Map<String, Object?> trade) {
    return _db.collection("userData").doc(uID).collection("trades").add(trade);
  }
}
