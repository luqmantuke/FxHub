import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pipshub/screens/course/video_details.dart';
import 'package:pipshub/ad_helper.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

const int maxFailedLoadAttempts = 3;

class VideosScreen extends StatefulWidget {
  final String courseId;
  const VideosScreen({Key? key, required this.courseId}) : super(key: key);

  @override
  _VideosScreenState createState() => _VideosScreenState();
}

class _VideosScreenState extends State<VideosScreen> {
  int _interstitialLoadAttempts = 0;
  InterstitialAd? _interstitialAd;

  void _createInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          _interstitialLoadAttempts = 0;
        },
        onAdFailedToLoad: (LoadAdError error) {
          _interstitialLoadAttempts += 1;
          _interstitialAd = null;
          if (_interstitialLoadAttempts <= maxFailedLoadAttempts) {
            _createInterstitialAd();
          }
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _createInterstitialAd();
    _createBottomBannerAd();
  }

  @override
  void dispose() {
    super.dispose();
    _interstitialAd?.dispose();
    _createBottomBannerAd();
  }

  void _showInterstitialAd() {
    if (_interstitialAd != null) {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (InterstitialAd ad) {
          ad.dispose();
          _createInterstitialAd();
        },
        onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
          ad.dispose();
          _createInterstitialAd();
        },
      );
      _interstitialAd!.show();
    }
  }

  late BannerAd _bottomBannerAd;
  bool _isBottomBannerAdLoaded = false;
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
  Widget build(BuildContext context) {
    bool isLoading = false;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent.withOpacity(1),
        title: Text("Videos"),
        centerTitle: true,
      ),
      body: Column(children: [
        Container(
          padding: EdgeInsets.only(top: 15, right: 10, left: 10),
          height: MediaQuery.of(context).size.height / 1.4,
          child: FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance
                  .collection('course')
                  .doc(widget.courseId)
                  .collection("videos")
                  .orderBy("videoName", descending: false)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  // <3> Retrieve `List<DocumentSnapshot>` from snapshot
                  final List<DocumentSnapshot> documents = snapshot.data!.docs;
                  return ListView(
                      children: documents
                          .map((doc) => GestureDetector(
                                onTap: isLoading == true
                                    ? null
                                    : () async {
                                        _showInterstitialAd();
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    VideoDetails(
                                                      videoUrl: doc['videoUrl'],
                                                      videoName:
                                                          doc['videoName'],
                                                    )));
                                        setState(() {
                                          isLoading = true;
                                        });
                                      },
                                child: Card(
                                  child: ListTile(
                                    title: isLoading == true
                                        ? Center(
                                            child: CircularProgressIndicator())
                                        : Text(
                                            isLoading == true
                                                ? "Opening...."
                                                : doc['videoName'],
                                            style: isLoading == true
                                                ? TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    backgroundColor: Colors
                                                        .tealAccent.shade100,
                                                    color: Colors.black,
                                                    fontSize: 17)
                                                : TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 17),
                                          ),
                                    trailing: Icon(Icons.arrow_right_alt_sharp,
                                        size: 35),
                                  ),
                                ),
                              ))
                          .toList());
                } else if (snapshot.hasError) {
                  return Text('Sorry Seems There is An Error. Plese report');
                  // ignore: unnecessary_null_comparison
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
        ),
        SizedBox(height: 25),
        _isBottomBannerAdLoaded
            ? Container(
                height: _bottomBannerAd.size.height.toDouble(),
                width: _bottomBannerAd.size.width.toDouble(),
                child: AdWidget(ad: _bottomBannerAd),
              )
            : Container(),
      ]),
    );
  }
}
