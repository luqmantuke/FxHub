import 'package:firebaseauth/models/trade.dart';
import 'package:firebaseauth/widgets/deleted_successfuly.dart';
import 'package:firebaseauth/widgets/list_trades.dart';
import 'package:flutter/material.dart';
import '../provider/trades.dart';

class TradeDetails extends StatefulWidget {
  String pair;
  String result;
  String description;
  String day;
  String month;
  String year;
  String id;
  Trade trade;
  Trades tradeList;

  TradeDetails(
      {required this.pair,
      required this.day,
      required this.month,
      required this.year,
      required this.description,
      required this.result,
      required this.id,
      required this.trade,
      required this.tradeList});

  @override
  _TradeDetailsState createState() => _TradeDetailsState();
}

class _TradeDetailsState extends State<TradeDetails> {
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent.withOpacity(1),
        title: Text(widget.pair),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 30, top: 60),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Pair: ',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  widget.pair,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  'Results: ',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  widget.result,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  'Date: ',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  widget.day,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  '-',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.month,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  '-',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.year,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  'Description: ',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(right: 10, top: 15),
              height: MediaQuery.of(context).size.height * 0.6,
              width: MediaQuery.of(context).size.width * 1,
              child: Text(
                widget.description,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "UPDATE",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 15),
                  child: TextButton(
                    onPressed: () {
                      _showMyDialog();
                    },
                    child: Text(
                      "DELETE",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete ${widget.pair}'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text('Are you sure you want to delete.'),
                Text(
                  widget.pair,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Confirm',
                style: TextStyle(fontSize: 18),
              ),
              onPressed: () async {
                widget.tradeList.deleteTrade(widget.trade);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DeletedSuccess(pair: widget.pair),
                  ),
                );
              },
            ),
            TextButton(
              child: Text('Cancel', style: TextStyle(fontSize: 18)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
