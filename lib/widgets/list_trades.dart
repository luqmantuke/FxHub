import 'package:firebase_auth/firebase_auth.dart';
import 'package:pipshub/authentication/authentication.dart';
import 'package:pipshub/screens/trade_details.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pipshub/provider/trades.dart';

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
    return Consumer<Trades>(builder: (context, trades, child) {
      return Container(
        child: Card(
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("userData")
                    .doc(AuthenticationService(FirebaseAuth.instance)
                        .getCurrentUID()
                        .toString())
                    .collection("trades")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final docSnapshot = snapshot.data!.docs[index];
                        final docs = snapshot.data!.docs[index].data();
                        print("docs $docs");
                        print(docSnapshot.data());
                        DateTime myDateTime =
                            docSnapshot.get('dateTime').toDate();
                        return ListTile(
                          leading: docSnapshot.get('result') == 'profit'
                              ? profit
                              : loss,
                          title: Text(docSnapshot.get('pair'),
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600)),
                          subtitle: Row(
                            children: [
                              Text(myDateTime.day.toString(),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600)),
                              Text("-",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600)),
                              Text(myDateTime.month.toString(),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600)),
                              Text("-",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600)),
                              Text(myDateTime.year.toString(),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                          trailing: Icon(Icons.more_vert),
                          onTap: () async {
                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => TradeDetails(
                                  pair: docSnapshot.get('pair'),
                                  id: 'trades.trades[index].id.toString()',
                                  result: docSnapshot.get('result'),
                                  description: docSnapshot.get('description'),
                                  day: myDateTime.day.toString(),
                                  month: myDateTime.month.toString(),
                                  year: myDateTime.year.toString(),
                                  trade: docSnapshot,
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
    });
  }
}
