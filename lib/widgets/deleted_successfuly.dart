import 'package:firebaseauth/screens/homepage.dart';
import 'package:firebaseauth/widgets/list_trades.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DeletedSuccess extends StatelessWidget {
  String pair;
  DeletedSuccess({required this.pair});
  final String success = 'assets/images/success.svg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body: Container(
        padding: EdgeInsets.only(right: 40, left: 40, top: 200),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width * 0.5,
              child: SvgPicture.asset(
                success,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                child: Text(
              "You've Successfully Deleted ${pair.toUpperCase()}. Press below to go to your trade list ",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            )),
            SizedBox(
              height: 20,
            ),
            Center(
              child: TextButton(
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                },
                child: Text(
                  "Trade List",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
