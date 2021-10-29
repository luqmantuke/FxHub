import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pipshub/models/course_model.dart';
import 'package:pipshub/provider/course.dart';
import 'package:pipshub/screens/course/course_details.dart';
import 'package:provider/provider.dart';

final List<String> imgList = [
  'https://firebasestorage.googleapis.com/v0/b/fluttertodo-35aa8.appspot.com/o/assets%2FcourseSlider%2Ffd0fef8d620143c0147ca41763c0b596.png?alt=media&token=f1bf8861-9992-43dd-b797-302344efffd7',
  'https://firebasestorage.googleapis.com/v0/b/fluttertodo-35aa8.appspot.com/o/assets%2FcourseSlider%2Fforex-courses.jpg?alt=media&token=fb78e2c1-87c6-44a4-b606-477a35db1cf1',
  'https://firebasestorage.googleapis.com/v0/b/fluttertodo-35aa8.appspot.com/o/assets%2FcourseSlider%2F800_5fc6036eae37a.png?alt=media&token=8c010ae7-95e5-443d-99f5-965c51376d8b',
  'https://firebasestorage.googleapis.com/v0/b/fluttertodo-35aa8.appspot.com/o/assets%2FcourseSlider%2FPriceActionBannerv2.png?alt=media&token=63004f65-566d-47e5-b1fb-2d0a6875ec46',
  'https://firebasestorage.googleapis.com/v0/b/fluttertodo-35aa8.appspot.com/o/assets%2FcourseSlider%2Fmaxresdefault.jpg?alt=media&token=3e083496-0c4b-4f55-a096-01cb611b5080',
];

class CourseList extends StatefulWidget {
  const CourseList({Key? key}) : super(key: key);

  @override
  _CourseListState createState() => _CourseListState();
}

class _CourseListState extends State<CourseList> {
  final List<Widget> imageSliders = imgList
      .map((item) => Container(
            child: Container(
              margin: EdgeInsets.all(5.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: Stack(
                    children: <Widget>[
                      Image.network(item, fit: BoxFit.cover, width: 1000.0),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(200, 0, 0, 0),
                                Color.fromARGB(0, 0, 0, 0)
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          child: Text(
                            '',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ))
      .toList();
  @override
  Widget build(BuildContext context) {
    final courseProvider = Provider.of<CourseFirestoreModel>(context);
    return Scaffold(
      body: Column(
        children: [
          Container(
              child: CarouselSlider(
            options: CarouselOptions(
              aspectRatio: 2.0,
              enlargeCenterPage: false,
              scrollDirection: Axis.horizontal,
              autoPlay: true,
            ),
            items: imageSliders,
          )),
          Container(
              padding: EdgeInsets.only(top: 15, right: 10, left: 10),
              height: MediaQuery.of(context).size.height / 1.8,
              child: StreamBuilder<QuerySnapshot>(
                  stream: courseProvider.fetchCourses(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final course = snapshot.data!.docs
                          .map((course) => CourseModel.fromMap(
                              course.data() as Map<String, dynamic>))
                          .toList();
                      if (snapshot.data!.size == 0) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "assets/images/oops.svg",
                                height: MediaQuery.of(context).size.height / 4,
                              ),
                              SizedBox(height: 17),
                              Text(
                                "Sorry No Courses Right Now!!",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        );
                      }
                      return ListView.builder(
                          itemCount: course.length,
                          itemBuilder: (context, index) {
                            final docSnapshot = course[index];
                            final courseSnapshot = snapshot.data!.docs[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => CourseDetails(
                                          courseName: docSnapshot.courseName,
                                          courseDetails:
                                              docSnapshot.courseDetails,
                                          courseImage: docSnapshot.courseImage,
                                          courseId: courseSnapshot.id,
                                          hasPdf: docSnapshot.hasPdf,
                                          hasVideo: docSnapshot.hasVideo,
                                        )));
                              },
                              child: Card(
                                child: ListTile(
                                  trailing: Icon(Icons.arrow_right_alt_sharp,
                                      size: 35),
                                  title: Text(docSnapshot.courseName,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17)),
                                ),
                              ),
                            );
                          });
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }))
        ],
      ),
    );
  }
}
