import 'package:flutter/material.dart';

class Trade {
  String pair;
  String id;
  IconData result;
  DateTime dateTime;

  Trade(
      {required this.pair,
      required this.id,
      required this.result,
      required this.dateTime});
}
