import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('trades');

class Database {
  static String? userUid;

  // WRITE DATA

  static Future<void> addTrade({
    required String pair,
    required String id,
    required String result,
    required String description,
    required DateTime dateTime,
  }) async {
    DocumentReference documentReference =
        _mainCollection.doc(userUid).collection('tradeResults').doc();
    Map<String, dynamic> data = <String, dynamic>{
      "pair": pair,
      "id": id,
      "result": result,
      "description": description,
      "dateTime": dateTime,
    };
    await documentReference
        .set(data)
        .whenComplete(() => print("tradeResults added to the database"))
        .catchError((error) => print(error));
  }

  // READ DATA
  static Stream<QuerySnapshot> readTradeResults() {
    CollectionReference tradeResultsCollection =
        _mainCollection.doc(userUid).collection('tradeResults');
    return tradeResultsCollection.snapshots();
  }
}
