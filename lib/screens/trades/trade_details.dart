import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pipshub/provider/trades.dart';
import 'package:pipshub/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:pipshub/screens/trades/edit_trade.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class TradeDetails extends StatefulWidget {
  String pair;
  String result;
  String description;
  String day;
  String month;
  String year;
  String id;
  QueryDocumentSnapshot<Object?> trade;
  TradeDetails({
    required this.pair,
    required this.day,
    required this.month,
    required this.year,
    required this.description,
    required this.result,
    required this.id,
    required this.trade,
  });
  @override
  _TradeDetailsState createState() => _TradeDetailsState();
}

class _TradeDetailsState extends State<TradeDetails> {
  bool isLoading = false;
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
        child: SingleChildScrollView(
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
                    widget.pair.toUpperCase(),
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
                child: SingleChildScrollView(
                  child: Text(
                    widget.description,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditTrade(
                              pair: widget.pair,
                              result: widget.result,
                              description: widget.description,
                              trade: widget.trade),
                        ),
                      );
                    },
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
                        isLoading == true ? "DELETING" : "DELETE",
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
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete ${widget.pair.toUpperCase()}'),
          content: SingleChildScrollView(
            child: isLoading == true
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: <Widget>[
                      Text('Are you sure you want to delete.'),
                      Text(
                        widget.pair.toUpperCase(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                isLoading == true ? "Deleting....." : 'Confirm',
                style: TextStyle(fontSize: 18),
              ),
              onPressed: isLoading == true
                  ? null
                  : () async {
                      setState(() {
                        isLoading = true;
                      });
                      final deleteTrade =
                          Provider.of<Trades>(context, listen: false);
                      await deleteTrade.deleteTrade(widget.trade.id);
                      final snackBar = SnackBar(
                        content: Text(
                            'Trade ${widget.pair.toUpperCase()} Deleted Successfully!'),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                      );
                    },
            ),
            TextButton(
              child: Text('Cancel', style: TextStyle(fontSize: 18)),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
