import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pipshub/services/firebaseapi.dart';

class NewsCrudModel extends ChangeNotifier {
  final _firebaseApi = FirebaseApi();
  Stream<QuerySnapshot> fetchNewsasSteam() {
    return _firebaseApi.streamtradeNewsCollection();
  }
}
