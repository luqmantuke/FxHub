import 'package:pipshub/models/trade.dart';
import 'package:pipshub/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/trades.dart';
import 'package:select_form_field/select_form_field.dart';

class AddTrade extends StatefulWidget {
  @override
  _AddTradeState createState() => _AddTradeState();
}

class _AddTradeState extends State<AddTrade> {
  final pairController = TextEditingController();
  final resultController = TextEditingController();
  final descriptionController = TextEditingController();
  String tradeResult = "profit";

  final List<Map<String, dynamic>> _results = [
    {
      'value': 'profit',
      'label': 'Profit',
      // 'icon': Icon(Icons.stop),
      'textStyle': TextStyle(color: Colors.green, fontSize: 18),
    },
    {
      'value': 'loss',
      'label': 'Loss',
      // 'icon': Icon(Icons.stop),
      'textStyle': TextStyle(color: Colors.red, fontSize: 18)
    },
  ];

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
          child: tradeForm(context),
        ),
      ),
    );
  }

  Container tradeForm(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 30),
            child: Center(
              child: Text(
                "Track Your New Trade",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 20, left: 20),
            // height: MediaQuery.of(context).size.height * 0.2,
            child: Column(children: [
              TextField(
                decoration: InputDecoration(
                    labelText: "Pair Example USD/JPY",
                    labelStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                controller: pairController,
                onChanged: (value) {
                  pairController.value = TextEditingValue(
                      text: value.toUpperCase(),
                      selection: pairController.selection);
                },
              ),
              SelectFormField(
                type: SelectFormFieldType.dropdown, // or can be dialog
                initialValue: 'profit',
                // icon: Icon(Icons.money),
                labelText: 'Results',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                items: _results,
                onChanged: (val) {
                  setState(() {
                    tradeResult = val;
                  });
                  print(tradeResult);
                },
                onSaved: (value) {
                  if (value == null) {
                    print("null");
                  } else
                    setState(() {
                      tradeResult = value;
                    });
                  print(tradeResult);
                },
              ),
              TextField(
                decoration: InputDecoration(
                    labelText: "Describe What Made You Take The Trade",
                    labelStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
                  backgroundColor:
                      MaterialStateProperty.all(Theme.of(context).accentColor),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                onPressed: () {
                  // print(tradeResult);
                  addTrade(pairController.text.toUpperCase(), 'id', tradeResult,
                      descriptionController.text);
                  pairController.clear();
                  descriptionController.clear();
                  final snackBar = SnackBar(
                    content: const Text('Trade Added Successfully!'),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
                child: Text(
                  "Submit",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ]),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          Container(
            child: Image.asset(
              "assets/images/motivation.jpg",
              fit: BoxFit.fill,
            ),
          )
        ],
      ),
    );
  }
}
