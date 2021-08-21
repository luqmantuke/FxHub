import 'package:firebaseauth/models/trade.dart';
import 'package:firebaseauth/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/trades.dart';

class AddTrade extends StatefulWidget {
  final List<Trade> tradeList = [];

  @override
  _AddTradeState createState() => _AddTradeState();
}

class _AddTradeState extends State<AddTrade> {
  final pairController = TextEditingController();
  final resultController = TextEditingController();
  final descriptionController = TextEditingController();
  void addTrade(
    String pair,
    String id,
    String result,
    String description,
  ) {
    final trade = Provider.of<Trades>(context, listen: false);
    trade.addTrade(Trade(
        pair: pair,
        id: 'id',
        result: result,
        description: description,
        dateTime: DateTime.now()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.only(
          top: 20,
        ),
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 30),
                  child: Center(
                    child: Text(
                      "Track Your New Trade",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 20, left: 20),
                  // height: MediaQuery.of(context).size.height * 0.2,
                  child: Column(children: [
                    TextField(
                      decoration:
                          InputDecoration(labelText: "Pair Example USD/JPY"),
                      controller: pairController,
                    ),
                    TextField(
                      decoration: InputDecoration(
                          labelText: "Results From Trade Example Loss/Profit"),
                      controller: resultController,
                    ),
                    TextField(
                      decoration: InputDecoration(
                          labelText: "Describe What Made You Take The Trade"),
                      controller: descriptionController,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      minLines: 1,
                      maxLines: 10,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).accentColor),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      onPressed: () {
                        addTrade(
                            pairController.text.toUpperCase(),
                            'id',
                            resultController.text.toLowerCase(),
                            descriptionController.text);
                        pairController.clear();
                        resultController.clear();
                        descriptionController.clear();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()));
                      },
                      child: Text(
                        "Submit",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    )
                  ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
