import 'package:flutter/material.dart';

class Trade {
  String pair;
  String id;
  String result;
  String description;
  DateTime dateTime;

  Trade(
      {required this.pair,
      required this.id,
      required this.result,
      required this.description,
      required this.dateTime});

  static Trade fromJson(Map<String, dynamic> json) => Trade(
      pair: json['pair'],
      id: json['id'],
      result: json['result'],
      description: json['description'],
      dateTime: json['dateTime']);

  Map<String, dynamic> toJson() => {
        'pair': pair,
        'id': id,
        'result': result,
        'description': description,
        'dateTime': DateTime.now()
      };
}
