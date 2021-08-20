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
      description:
          'On this page, we are going to be using the provider package. If you are new to Flutter and you don’t have a strong reason to choose another approach (Redux, Rx, hooks, etc.), this is probably the approach you should start with. The provider package is easy to understand and it doesn’t use much code. It also uses concepts that are applicable in every other approach.',
      dateTime: DateTime.now(),
    ),
    Trade(
      id: 'tr2',
      pair: 'USD/CAD',
      result: 'profit',
      description:
          'On this page, we are going to be using the provider package. If you are new to Flutter and you don’t have a strong reason to choose another approach (Redux, Rx, hooks, etc.), this is probably the approach you should start with. The provider package is easy to understand and it doesn’t use much code. It also uses concepts that are applicable in every other approach. On this page, we are going to be using the provider package. If you are new to Flutter and you don’t have a strong reason to choose another approach (Redux, Rx, hooks, etc.), this is probably the approach you should start with. The provider package is easy to understand and it doesn’t use much code. It also uses concepts that are applicable in every other approach. On this page, we are going to be using the provider package. If you are new to Flutter',
      dateTime: DateTime.now(),
    ),
    Trade(
      id: 'tr3',
      pair: 'GNP/USD',
      result: 'loss',
      description:
          'On this page, we are going to be using the provider package. If you are new to Flutter and you don’t have a strong reason to choose another approach (Redux, Rx, hooks, etc.), this is probably the approach you should start with. The provider package is easy to understand and it doesn’t use much code. It also uses concepts that are applicable in every other approach.',
      dateTime: DateTime.now(),
    ),
    Trade(
      id: 'tr4',
      pair: 'CAD/JPY',
      result: 'profit',
      description:
          'On this page, we are going to be using the provider package. If you are new to Flutter and you don’t have a strong reason to choose another approach (Redux, Rx, hooks, etc.), this is probably the approach you should start with. The provider package is easy to understand and it doesn’t use much code. It also uses concepts that are applicable in every other approach.',
      dateTime: DateTime.now(),
    ),
    Trade(
      id: 'tr5',
      pair: 'CHF/JPY',
      result: 'loss',
      description:
          'On this page, we are going to be using the provider package. If you are new to Flutter and you don’t have a strong reason to choose another approach (Redux, Rx, hooks, etc.), this is probably the approach you should start with. The provider package is easy to understand and it doesn’t use much code. It also uses concepts that are applicable in every other approach.',
      dateTime: DateTime.now(),
    ),
    Trade(
      id: 'tr6',
      pair: 'CAD/USD',
      result: 'loss',
      description:
          'On this page, we are going to be using the provider package. If you are new to Flutter and you don’t have a strong reason to choose another approach (Redux, Rx, hooks, etc.), this is probably the approach you should start with. The provider package is easy to understand and it doesn’t use much code. It also uses concepts that are applicable in every other approach.',
      dateTime: DateTime.now(),
    ),
    Trade(
      id: 'tr7',
      pair: 'USD/ZAR',
      result: 'profit',
      description:
          'On this page, we are going to be using the provider package. If you are new to Flutter and you don’t have a strong reason to choose another approach (Redux, Rx, hooks, etc.), this is probably the approach you should start with. The provider package is easy to understand and it doesn’t use much code. It also uses concepts that are applicable in every other approach.',
      dateTime: DateTime.now(),
    ),
    Trade(
      id: 'tr8',
      pair: 'NZD/USD',
      result: 'loss',
      description:
          'On this page, we are going to be using the provider package. If you are new to Flutter and you don’t have a strong reason to choose another approach (Redux, Rx, hooks, etc.), this is probably the approach you should start with. The provider package is easy to understand and it doesn’t use much code. It also uses concepts that are applicable in every other approach.',
      dateTime: DateTime.now(),
    ),
    Trade(
      id: 'tr9',
      pair: 'NZD/JPY',
      result: 'profit',
      description:
          'On this page, we are going to be using the provider package. If you are new to Flutter and you don’t have a strong reason to choose another approach (Redux, Rx, hooks, etc.), this is probably the approach you should start with. The provider package is easy to understand and it doesn’t use much code. It also uses concepts that are applicable in every other approach.',
      dateTime: DateTime.now(),
    ),
    Trade(
      id: 'tr10',
      pair: 'EUR/JPY',
      result: 'loss',
      description:
          'On this page, we are going to be using the provider package. If you are new to Flutter and you don’t have a strong reason to choose another approach (Redux, Rx, hooks, etc.), this is probably the approach you should start with. The provider package is easy to understand and it doesn’t use much code. It also uses concepts that are applicable in every other approach.',
      dateTime: DateTime.now(),
    ),
  ];

  List<Trade> get trades {
    return [..._trades];
  }
}
