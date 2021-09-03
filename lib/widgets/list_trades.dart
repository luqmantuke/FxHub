import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pipshub/models/trade.dart';
import 'package:pipshub/provider/trades.dart';
import 'package:pipshub/screens/trades/trade_details.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListTrades extends StatefulWidget {
  const ListTrades({Key? key}) : super(key: key);

  @override
  _ListTradesState createState() => _ListTradesState();
}

class _ListTradesState extends State<ListTrades> {
  // final Stream<QuerySnapshot> _tradeStream =
  @override
  Widget build(BuildContext context) {
    final profit = Icon(FontAwesomeIcons.checkCircle, color: Colors.green);
    final loss = Icon(FontAwesomeIcons.timesCircle, color: Colors.red);
    final newsProvider = Provider.of<Trades>(context);
    return Container(
      child: Card(
          child: StreamBuilder<QuerySnapshot>(
              stream: newsProvider.fetchTradesasSteam(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final trades = snapshot.data!.docs
                      .map((trade) => TradeModel.fromMap(
                          trade.data() as Map<String, dynamic>))
                      .toList();
                  return ListView.builder(
                    itemCount: trades.length,
                    itemBuilder: (context, index) {
                      final docSnapshot = trades[index];
                      final tradeSnapshot = snapshot.data!.docs[index];
                      DateTime myDateTime = docSnapshot.dateTime;
                      return ListTile(
                        leading: docSnapshot.result == 'profit' ? profit : loss,
                        title: Text(docSnapshot.pair,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600)),
                        subtitle: Row(
                          children: [
                            Text(myDateTime.day.toString(),
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600)),
                            Text("-",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600)),
                            Text(myDateTime.month.toString(),
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600)),
                            Text("-",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600)),
                            Text(myDateTime.year.toString(),
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600)),
                          ],
                        ),
                        // trailing: Icon(Icons.more_vert),
                        onTap: () async {
                          await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => TradeDetails(
                                pair: docSnapshot.pair,
                                id: 'trades.trades[index].id.toString()',
                                result: docSnapshot.result,
                                description: docSnapshot.description,
                                day: myDateTime.day.toString(),
                                month: myDateTime.month.toString(),
                                year: myDateTime.year.toString(),
                                trade: tradeSnapshot,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              })),
    );
  }
}
