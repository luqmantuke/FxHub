import 'package:flutter/material.dart';

class Trade {
  String pair;
  String id;
  String result;
  DateTime dateTime;

  Trade(
      {required this.pair,
      required this.id,
      required this.result,
      required this.dateTime});
}
