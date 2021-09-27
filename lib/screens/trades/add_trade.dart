import 'package:intl/intl.dart';
import 'package:pipshub/models/trade.dart';
import 'package:pipshub/provider/trades.dart';
import 'package:pipshub/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:date_time_picker/date_time_picker.dart';

class AddTrade extends StatefulWidget {
  @override
  _AddTradeState createState() => _AddTradeState();
}

class _AddTradeState extends State<AddTrade> {
  final pairController = TextEditingController();
  final resultController = TextEditingController();
  final descriptionController = TextEditingController();
  String tradeResult = "profit";
  bool isLoading = false;
  DateTime nowDate =
      DateFormat("yyyy-MM-dd hh:mm").parse(DateTime.now().toString());
  String dateTime = '';

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
                },
                onSaved: (value) {
                  if (value == null) {
                  } else
                    setState(() {
                      tradeResult = value;
                    });
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
                maxLines: 20,
                minLines: 2,
              ),
              DateTimePicker(
                type: DateTimePickerType.dateTimeSeparate,
                dateMask: 'd MMM, yyyy',
                initialValue: DateTime.now().toString(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                icon: Icon(Icons.event),
                dateLabelText: 'Date',
                use24HourFormat: true,
                timeLabelText: "Hour",
                onChanged: (val) => setState(() => dateTime = val),
                validator: (val) {
                  return null;
                },
                onSaved: (val) {
                  setState(() {
                    dateTime = val ?? '';
                  });
                },
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
                onPressed: isLoading == true
                    ? null
                    : () async {
                        setState(() {
                          isLoading = true;
                        });
                        final addTrade =
                            Provider.of<Trades>(context, listen: false);
                        await addTrade.addTrade(TradeModel(
                            pair: pairController.text,
                            result: tradeResult,
                            description: descriptionController.text,
                            dateTime: dateTime == ''
                                ? DateTime.now()
                                : DateFormat("yyyy-MM-dd hh:mm")
                                    .parse(dateTime)));
                        final snackBar = SnackBar(
                          content: const Text('Trade Added Successfully!'),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()));
                        setState(() {
                          isLoading = false;
                        });
                      },
                child: isLoading == true
                    ? Center(
                        child: Text("UPLOADING......",
                            style: TextStyle(
                              color: Colors.black,
                            )))
                    : Text(
                        "Submit",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
