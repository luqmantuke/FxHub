import 'package:flutter/material.dart';
import 'package:pipshub/models/onboard_model.dart';
import 'package:pipshub/screens/authentication/login_page.dart';
import 'package:pipshub/utils/contants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginSignUpScreen extends StatefulWidget {
  @override
  _LoginSignUpScreenState createState() => _LoginSignUpScreenState();
}

class _LoginSignUpScreenState extends State<LoginSignUpScreen> {
  int currentIndex = 0;

  late PageController _pageController;
  List<OnboardModel> screens = <OnboardModel>[
    OnboardModel(
      img: 'assets/images/pipshub.png',
      text: "Welcome To PipsHub",
      desc:
          "PipsHub is an application that aids you in your forex journey. We provide TRADE tracking system, NEWS alert system with notification together with COURSES such as ICT,BTMM, PRICE ACTION, e.t.c.",
      bg: Colors.white,
      button: Color(0xFF4756DF),
    ),
    OnboardModel(
      img: 'assets/images/add.jpg',
      text: "How To Add Trades",
      desc:
          "Press the add button on your right and fill the form fields such as pair(GBP/USD), result(PROFIT), amount(10) e.t.c.",
      bg: Colors.white,
      button: Color(0xFF4756DF),
    ),
    OnboardModel(
      img: 'assets/images/select.jpg',
      text: "Select The Trade To View/Update/Delete",
      desc:
          "To view/update/delete your trade, select the pair you wish and you will be redirected the pair details page.",
      bg: Colors.white,
      button: Color(0xFF4756DF),
    ),
    OnboardModel(
      img: 'assets/images/decide.jpg',
      text: "Decide To Update/Delete Trade",
      desc:
          "if you wish to update/delete a trade, select the pair and at the details bottom page you select your option. Get Started Now With Your Google Account.",
      bg: Colors.white,
      button: Color(0xFF4756DF),
    ),
  ];

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  _storeOnboardInfo() async {
    int isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onBoard', isViewed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhite,
      appBar: AppBar(
        backgroundColor: kwhite,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: PageView.builder(
            itemCount: screens.length,
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(),
            onPageChanged: (int index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (_, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      height: MediaQuery.of(context).size.height / 2.8,
                      child: Image.asset(screens[index].img)),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: ListView.builder(
                      itemCount: screens.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 3.0),
                                width: currentIndex == index
                                    ? MediaQuery.of(context).size.width * 0.05
                                    : MediaQuery.of(context).size.width * 0.03,
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                                decoration: BoxDecoration(
                                  color: currentIndex == index
                                      ? kbrown
                                      : kbrown300,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ]);
                      },
                    ),
                  ),
                  Text(
                    screens[index].text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 27.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                      color: kblack,
                    ),
                  ),
                  Text(
                    screens[index].desc,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                      color: kblack,
                    ),
                  ),
                  index != 0
                      ? InkWell(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30.0, vertical: 10),
                            decoration: BoxDecoration(
                                color: backColor,
                                borderRadius: BorderRadius.circular(15.0)),
                            child:
                                Row(mainAxisSize: MainAxisSize.min, children: [
                              Icon(Icons.arrow_back_sharp, color: Colors.white),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.02,
                              ),
                              Text("Back",
                                  style: TextStyle(color: Colors.white)),
                            ]),
                          ),
                          onTap: () {
                            _pageController.previousPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.bounceIn,
                            );
                          },
                        )
                      : Text(""),
                  InkWell(
                    onTap: () async {
                      if (index == screens.length - 1) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                        await _storeOnboardInfo();
                      }

                      _pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.bounceIn,
                      );
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
                      decoration: BoxDecoration(
                          color: kblue,
                          borderRadius: BorderRadius.circular(15.0)),
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        Text(
                          index == screens.length - 1
                              ? "Let's Get Started"
                              : "Next",
                          style: TextStyle(fontSize: 16.0, color: kwhite),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        Icon(
                          index == screens.length - 1
                              ? Icons.arrow_forward_sharp
                              : Icons.arrow_forward_sharp,
                          color: kwhite,
                        )
                      ]),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
