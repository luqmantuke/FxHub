import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pipshub/authentication/authentication.dart';
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
  var tradeDateFilter = 'today';

  @override
  Widget build(BuildContext context) {
    final profit = Icon(FontAwesomeIcons.checkCircle, color: Colors.green);
    final loss = Icon(FontAwesomeIcons.timesCircle, color: Colors.red);
    final trade = Provider.of<Trades>(context);
    final uName = Provider.of<AuthenticationService>(context, listen: false)
        .getCurrentUname();
    final oopstrade = tradeDateFilter.toUpperCase();
    streamFilter() {
      if (tradeDateFilter == 'today') {
        return trade.fetchTodayTradesasSteam();
      } else if (tradeDateFilter == 'yesterday') {
        return trade.fetchYesterdayTradesasSteam();
      } else if (tradeDateFilter == 'week') {
        return trade.fetchWeekTradesasSteam();
      } else if (tradeDateFilter == 'month') {
        return trade.fetchMonthTradesasSteam();
      } else {
        return trade.fetchAllTradesasSteam();
      }
    }

    final orientation = MediaQuery.of(context).orientation;
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 10, right: 13),
            height: orientation == Orientation.portrait
                ? MediaQuery.of(context).size.height / 15
                : MediaQuery.of(context).size.height / 13,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // SizedBox(width: 1),
                RichText(
                  text: TextSpan(
                    text: ' ',
                    style: DefaultTextStyle.of(context).style,
                    children: [
                      TextSpan(
                          text: 'Welcome, ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'courgette',
                              fontSize: 16)),
                      TextSpan(
                        text: uName,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                    ],
                  ),
                ),
                DropdownButton<String>(
                    elevation: 0,
                    dropdownColor: Colors.lightBlueAccent.shade100,
                    value: tradeDateFilter,
                    items: [
                      DropdownMenuItem(
                        child: Text("Today"),
                        value: "today",
                      ),
                      DropdownMenuItem(
                        child: Text("Yesterday"),
                        value: 'yesterday',
                      ),
                      DropdownMenuItem(
                        child: Text("Last Week"),
                        value: 'week',
                      ),
                      DropdownMenuItem(
                        child: Text("Last Month"),
                        value: 'month',
                      ),
                      DropdownMenuItem(
                        child: Text("All Time"),
                        value: 'all',
                      ),
                    ],
                    onChanged: (String? newValue) {
                      setState(() {
                        tradeDateFilter = newValue.toString();
                      });
                    },
                    hint: Text("Select item"))
              ],
            ),
          ),
          SingleChildScrollView(
            child: Container(
              // ignore: unrelated_type_equality_checks
              height: orientation == Orientation.portrait
                  ? MediaQuery.of(context).size.height / 1.35
                  : MediaQuery.of(context).size.height / 1.7,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    spreadRadius: 10,
                    blurRadius: 10,
                    offset: Offset(0, 0),
                    color: Colors.transparent)
              ]),
              child: Card(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: streamFilter(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final trades = snapshot.data!.docs
                              .map((trade) => TradeModel.fromMap(
                                  trade.data() as Map<String, dynamic>))
                              .toList();
                          if (snapshot.data!.size == 0) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    "assets/images/oops.svg",
                                    height:
                                        MediaQuery.of(context).size.height / 4,
                                  ),
                                  SizedBox(height: 17),
                                  Text(
                                    "You've no trades $oopstrade  Press Plus Button To Add One.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            );
                          }
                          return ListView.builder(
                            itemCount: trades.length,
                            itemBuilder: (context, index) {
                              final docSnapshot = trades[index];
                              final tradeSnapshot = snapshot.data!.docs[index];
                              DateTime myDateTime = docSnapshot.dateTime;
                              return ListTile(
                                leading: docSnapshot.result == 'profit'
                                    ? profit
                                    : loss,
                                title: Text(docSnapshot.pair,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600)),
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
                                // trailing: Text(docSnapshot.amount.toString(),
                                //     style: TextStyle(
                                //       fontSize: 17,
                                //       color: docSnapshot.result == 'profit'
                                //           ? Colors.blue
                                //           : Colors.red,
                                //       fontWeight: FontWeight.bold,
                                //     )),
                                trailing: RichText(
                                  text: TextSpan(
                                    text: docSnapshot.result == 'profit'
                                        ? 'USD  +'
                                        : 'USD  -',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                        fontSize: 16),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: docSnapshot.amount.toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: docSnapshot.result == 'profit'
                                              ? Colors.blue
                                              : Colors.red,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () async {
                                  await Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => TradeDetails(
                                        pair: docSnapshot.pair,
                                        id: 'trades.trades[index].id.toString()',
                                        result: docSnapshot.result,
                                        description: docSnapshot.description,
                                        amount: docSnapshot.amount,
                                        day: myDateTime.day.toString(),
                                        dateTime: myDateTime.toString(),
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
            ),
          ),
        ],
      ),
    );
  }

  onSelected(BuildContext context, String item) {
    final trade = Provider.of<Trades>(context);
    switch (item) {
      case "Today":
        return trade.fetchTodayTradesasSteam();

      default:
    }
  }
}
