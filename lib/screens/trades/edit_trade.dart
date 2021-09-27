import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:pipshub/models/trade.dart';
import 'package:pipshub/provider/trades.dart';
import 'package:pipshub/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:date_time_picker/date_time_picker.dart';

// ignore: must_be_immutable
class EditTrade extends StatefulWidget {
  String pair;
  String result;
  String description;
  String dateTime;
  QueryDocumentSnapshot<Object?> trade;

  EditTrade(
      {required this.pair,
      required this.result,
      required this.description,
      required this.dateTime,
      required this.trade});
  @override
  _EditTradeState createState() => _EditTradeState();
}

class _EditTradeState extends State<EditTrade> {
  final pairController = TextEditingController();
  final resultController = TextEditingController();
  final descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  // String tradeResult = result;

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
  // ignore: override_on_non_overriding_member
  void initstate() {
    pairController.text = widget.pair;
    resultController.text = widget.result;
    descriptionController.text = widget.description;
    return super.initState();
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
          child: Form(key: _formKey, child: tradeForm(context)),
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
                "Edit Your  Trade",
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
                    hintText: widget.pair,
                    hintStyle:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    labelText: "Pair",
                    labelStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                controller:
                    TextEditingController(text: widget.pair.toUpperCase()),
                onChanged: (value) {
                  widget.pair = value.toUpperCase();
                },
              ),
              SelectFormField(
                type: SelectFormFieldType.dropdown, // or can be dialog
                initialValue: widget.result,
                // icon: Icon(Icons.money),
                labelText: 'Results',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                items: _results,
                onChanged: (val) {
                  setState(() {
                    widget.result = val;
                  });
                },
                onSaved: (value) {
                  if (value == null) {
                  } else
                    setState(() {
                      widget.result = value;
                    });
                },
              ),
              TextField(
                onChanged: (value) {
                  widget.description = value;
                },
                decoration: InputDecoration(
                    labelText: "Description",
                    hintText: widget.description,
                    labelStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                controller: TextEditingController(text: widget.description),
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                maxLines: 20,
                minLines: 2,
              ),
              DateTimePicker(
                type: DateTimePickerType.dateTimeSeparate,
                dateMask: 'd MMM, yyyy',
                initialValue: widget.dateTime,
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                icon: Icon(Icons.event),
                dateLabelText: 'Date',
                use24HourFormat: true,
                timeLabelText: "Hour",
                // selectableDayPredicate: (date) {
                //   // Disable weekend days to select from the calendar
                //   if (date.weekday == 6 || date.weekday == 7) {
                //     return false;
                //   }

                //   return true;
                // },
                onChanged: (val) => setState(() => widget.dateTime = val),
                validator: (val) {
                  return null;
                },
                onSaved: (val) {
                  setState(() {
                    widget.dateTime = val ?? '';
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
                        final editTrade =
                            Provider.of<Trades>(context, listen: false);
                        await editTrade.editTrade(
                            widget.trade.id,
                            TradeModel(
                                pair: widget.pair,
                                result: widget.result,
                                description: widget.description,
                                dateTime: DateFormat("yyyy-MM-dd hh:mm")
                                    .parse(widget.dateTime)));

                        final snackBar = SnackBar(
                          content: const Text('Trade Updated Successfully!'),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                        );
                      },
                child: isLoading == true
                    ? Center(
                        child: Text("UPDATING......",
                            style: TextStyle(
                              color: Colors.black,
                            )))
                    : Text(
                        "Update",
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
