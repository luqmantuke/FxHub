import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CourseList extends StatefulWidget {
  const CourseList({Key? key}) : super(key: key);

  @override
  _CourseListState createState() => _CourseListState();
}

class _CourseListState extends State<CourseList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  "assets/images/course_background.jpg",
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "Learn Forex Best Strategies",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 3),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(left: 20),
                child: RichText(
                  text: TextSpan(
                    text: ' ',
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(
                        text: 'ICT,BTMM,WYCKOFF,PRICE ACTION ',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.lightBlueAccent.shade400,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: '  For Free',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),

              Container(
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width,
                child: SvgPicture.asset(
                  "assets/images/coming-soon.svg",
                ),
              ),
              // GridView.builder(
              //   physics: ScrollPhysics(),
              //   shrinkWrap: true,
              //   padding: EdgeInsets.symmetric(horizontal: 4),
              //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //     childAspectRatio: 9 / 10,
              //     crossAxisCount: 2,
              //   ),
              //   itemCount: 6,
              //   itemBuilder: (context, index) {
              //     return Container(
              //       margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(15),
              //         color: Colors.lightBlueAccent.withOpacity(1),
              //       ),
              //       child: Column(
              //         children: [
              //           Container(
              //             decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(15),
              //             ),
              //             margin: EdgeInsetsDirectional.only(
              //               bottom: 8,
              //             ),
              //             height: MediaQuery.of(context).size.width * 0.4,
              //             child: CachedNetworkImage(
              //               height: double.maxFinite,
              //               fit: BoxFit.fill,
              //               imageUrl:
              //                   "https://images.unsplash.com/photo-1535320903710-d993d3d77d29?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80",
              //               placeholder: (context, url) =>
              //                   CircularProgressIndicator(),
              //               errorWidget: (context, url, error) =>
              //                   Icon(Icons.error),
              //             ),
              //           ),
              //           Text(
              //             'ICT COURSE',
              //             style: TextStyle(
              //               fontSize: 16,
              //               fontWeight: FontWeight.bold,
              //             ),
              //           ),
              //         ],
              //       ),
              //     );
              //   },
              // )
              // Container(
              //   width: MediaQuery.of(context).size.width,
              //   padding: EdgeInsets.only(left: 20),
              //   child:
              //       Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              //     Container(
              //       width: 250,
              //       height: 200,
              //       color: Colors.green,
              //     ),
              //     Text(
              //       "INNER CIRCLE TRADER FULL COURSE",
              //       softWrap: true,
              //       style: TextStyle(
              //         fontSize: 17,
              //         fontWeight: FontWeight.bold,
              //       ),
              //     ),
              //   ]),
              // ),
            ],
          ),
        ),
      ),
    ));
  }
}
