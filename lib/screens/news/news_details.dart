// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pipshub/ad_helper.dart';

// ignore: must_be_immutable
class NewsDetails extends StatefulWidget {
  String image;
  String title;
  String sentiment;
  String prediction;
  String details;
  String dateTime;
  String pair;

  NewsDetails(
      {required this.title,
      required this.image,
      required this.details,
      required this.sentiment,
      required this.dateTime,
      required this.pair,
      required this.prediction});

  @override
  State<NewsDetails> createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  TextStyle sentimentStyle() {
    if (widget.sentiment == 'MOD') {
      return TextStyle(
          backgroundColor: Colors.orangeAccent,
          color: Colors.black,
          fontSize: 15,
          fontWeight: FontWeight.bold);
    } else if (widget.sentiment == 'LOW') {
      return TextStyle(
          backgroundColor: Colors.greenAccent,
          color: Colors.black,
          fontSize: 15,
          fontWeight: FontWeight.bold);
    } else {
      return TextStyle(
          backgroundColor: Colors.red,
          color: Colors.black,
          fontSize: 15,
          fontWeight: FontWeight.bold);
    }
  }

  late BannerAd _bottomBannerAd;

  bool _isBottomBannerAdLoaded = false;

  late BannerAd _inlineBannerAd;

  bool _isInlineBannerAdLoaded = false;
  void _createInlineBannerAd() {
    _inlineBannerAd = BannerAd(
      size: AdSize.mediumRectangle,
      adUnitId: AdHelper.bannerAdUnitId,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isInlineBannerAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    );
    _inlineBannerAd.load();
  }

  void _createBottomBannerAd() {
    _bottomBannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBottomBannerAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    );
    _bottomBannerAd.load();
  }

  @override
  void initState() {
    super.initState();
    _createBottomBannerAd();
    _createInlineBannerAd();
  }

  @override
  void dispose() {
    super.dispose();
    _bottomBannerAd.dispose();
    _inlineBannerAd.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent.withOpacity(1),
        title: Text(widget.pair),
        centerTitle: true,
      ),
      persistentFooterButtons: _isBottomBannerAdLoaded
          ? [
              Container(
                height: _bottomBannerAd.size.height.toDouble(),
                width: _bottomBannerAd.size.width.toDouble(),
                child: AdWidget(ad: _bottomBannerAd),
              )
            ]
          : null,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(height: 10),
              Container(
                child: Text("News:  ${widget.title}",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 10),
              Container(
                child: Text("Currency:  ${widget.pair}",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 10),
              Container(
                child: Text(
                  "DateTime:  ${widget.dateTime}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),
              Container(
                child: Text(
                  "Impact:  ${widget.sentiment}",
                  style: sentimentStyle(),
                ),
              ),
              SizedBox(height: 10),
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(right: 13, left: 20),
                  height: orientation == Orientation.portrait
                      ? MediaQuery.of(context).size.height / 1.4
                      : MediaQuery.of(context).size.height / 2,
                  child: SingleChildScrollView(
                    child: Text(
                      widget.details,
                      style: TextStyle(
                        fontSize: 18,
                        wordSpacing: 4,
                        letterSpacing: 2,
                      ),
                      softWrap: true,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
