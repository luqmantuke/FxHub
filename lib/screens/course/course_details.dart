import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pipshub/ad_helper.dart';
import 'package:pipshub/screens/course/notes_screen.dart';
import 'package:pipshub/screens/course/videos_screen.dart';

class CourseDetails extends StatefulWidget {
  final String courseName;
  final String courseDetails;
  final String courseImage;
  final String courseId;
  final bool hasPdf;
  final bool hasVideo;
  const CourseDetails({
    Key? key,
    required this.courseName,
    required this.courseDetails,
    required this.courseId,
    required this.courseImage,
    required this.hasVideo,
    required this.hasPdf,
  }) : super(key: key);

  @override
  State<CourseDetails> createState() => _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails> {
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
  void initState() {
    super.initState();
    _createBottomBannerAd();
  }

  @override
  void dispose() {
    super.dispose();
    _bottomBannerAd.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent.withOpacity(1),
          title: Text(widget.courseName),
          centerTitle: true,
        ),
        body: Container(
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.only(left: 20, top: 10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      right: 30,
                    ),
                    height: size.height / 4,
                    width: size.width / 1.1,
                    child: CachedNetworkImage(
                      fit: BoxFit.fill,
                      height: MediaQuery.of(context).size.height / 3,
                      imageUrl: widget.courseImage,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(strokeWidth: 1.0),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 40,
                  ),
                  Container(
                    child: Text(widget.courseName,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        )),
                    height: size.height / 15,
                    width: size.width / 1.1,
                  ),
                  _isBottomBannerAdLoaded
                      ? Container(
                          height: _bottomBannerAd.size.height.toDouble(),
                          width: _bottomBannerAd.size.width.toDouble(),
                          child: AdWidget(ad: _bottomBannerAd),
                        )
                      : Container(),
                  Container(
                    child: Text(widget.courseDetails,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        )),
                    height: size.height / 2.8,
                    width: size.width / 1.1,
                  ),
                  GestureDetector(
                    onTap: widget.hasVideo == false
                        ? null
                        : () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => VideosScreen(
                                        courseId: widget.courseId,
                                      )),
                            );
                          },
                    child: Card(
                        child: ListTile(
                      title: Text(
                        widget.hasVideo == true
                            ? "Learn Through Videos"
                            : "Sorry No Videos For This Course :(",
                        style: TextStyle(
                            fontSize: 18,
                            color: widget.hasVideo == true
                                ? Colors.teal
                                : Colors.teal.shade300,
                            fontWeight: FontWeight.bold),
                      ),
                      trailing: widget.hasVideo == true
                          ? Icon(Icons.arrow_right_alt_sharp, size: 35)
                          : null,
                    )),
                  ),
                  GestureDetector(
                    onTap: widget.hasPdf == false
                        ? null
                        : () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => NotesScreen(
                                        courseId: widget.courseId,
                                      )),
                            );
                          },
                    child: Card(
                        child: ListTile(
                      title: Text(
                        widget.hasPdf == true
                            ? "Learn Through Notes"
                            : "Sorry No Notes For This Course :(",
                        style: TextStyle(
                            fontSize: 18,
                            color: widget.hasVideo == true
                                ? Colors.teal
                                : Colors.teal.shade300,
                            fontWeight: FontWeight.bold),
                      ),
                      trailing: widget.hasPdf == true
                          ? Icon(Icons.arrow_right_alt_sharp, size: 35)
                          : null,
                    )),
                  ),
                ],
              ),
            )));
  }
}
