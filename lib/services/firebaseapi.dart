import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseApi {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  // STREAM TRADENEWS METHOD

  Stream<QuerySnapshot> streamtradeNewsCollection() {
    return _db
        .collection('tradeNews')
        .orderBy('dateTime', descending: true)
        .snapshots();
  }

  // STREAM TRADES METHOD
  Stream<QuerySnapshot> streamtradesCollection(String uID) {
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
