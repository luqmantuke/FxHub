import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../models/trade.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Trades with ChangeNotifier {
  List<Trade> _trades = [
    Trade(
      id: 'tr1',
      pair: 'USD/JPY',
      result: 'profit',
      dateTime: DateTime.now(),
    ),
    Trade(
      id: 'tr2',
      pair: 'USD/CAD',
      result: 'profit',
      dateTime: DateTime.now(),
    ),
    Trade(
      id: 'tr3',
      pair: 'GNP/USD',
      result: 'loss',
      dateTime: DateTime.now(),
    ),
    Trade(
      id: 'tr4',
      pair: 'CAD/JPY',
      result: 'profit',
      dateTime: DateTime.now(),
    ),
    Trade(
      id: 'tr5',
      pair: 'CHF/JPY',
      result: 'loss',
      dateTime: DateTime.now(),
    ),
    Trade(
      id: 'tr6',
      pair: 'CAD/USD',
      result: 'loss',
      dateTime: DateTime.now(),
    ),
    Trade(
      id: 'tr7',
      pair: 'USD/ZAR',
      result: 'profit',
      dateTime: DateTime.now(),
    ),
    Trade(
      id: 'tr8',
      pair: 'NZD/USD',
      result: 'loss',
      dateTime: DateTime.now(),
    ),
    Trade(
      id: 'tr9',
      pair: 'NZD/JPY',
      result: 'profit',
      dateTime: DateTime.now(),
    ),
    Trade(
      id: 'tr10',
      pair: 'EUR/JPY',
      result: 'loss',
      dateTime: DateTime.now(),
    ),
  ];

  List<Trade> get trades {
    return [..._trades];
  }
}
