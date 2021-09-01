import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pipshub/authentication/authentication.dart';
import 'package:pipshub/models/trade.dart';
import 'package:pipshub/provider/trades.dart';
import 'package:pipshub/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:select_form_field/select_form_field.dart';

class EditTrade extends StatefulWidget {
  String pair;
  String result;
  String description;
  QueryDocumentSnapshot<Object?> trade;

  EditTrade(
      {required this.pair,
      required this.result,
      required this.description,
      required this.trade});
  @override
  _EditTradeState createState() => _EditTradeState();
}

class _EditTradeState extends State<EditTrade> {
  final pairController = TextEditingController();
  final resultController = TextEditingController();
  final descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
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
  void initstate() {
    pairController.text = widget.pair;
    resultController.text = widget.result;
    descriptionController.text = widget.description;
    return super.initState();
  }

  void editTrades(
    String pair,
    String result,
    String description,
    Trade trade,
  ) {
    final edit = Provider.of<Trades>(context, listen: false);
    edit.editTrade(trade, pair, result, description);
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
                onPressed: () async {
                  final uID =
                      context.read<AuthenticationService>().getCurrentUID();
                  await FirebaseFirestore.instance
                      .collection("userData")
                      .doc(uID.toString())
                      .collection("trades")
                      .doc(widget.trade.id)
                      .update({
                    'pair': widget.pair,
                    'result': widget.result,
                    'description': widget.description,
                    'dateTime': DateTime.now()
                  });
                  final snackBar = SnackBar(
                    content: const Text('Trade Updated Successfully!'),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                },
                child: Text(
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
