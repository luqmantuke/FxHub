import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pipshub/services/firebaseapi.dart';

class CourseFirestoreModel extends ChangeNotifier {
  final _firebaseApi = FirebaseApi();
  Stream<QuerySnapshot> fetchCourses() {
    return _firebaseApi.streamCourseListCollection();
  }
}
