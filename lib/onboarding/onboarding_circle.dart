import 'package:flutter/material.dart';
import 'package:hotlines_afrca/UI_functions/shared_preference.dart';
import 'package:hotlines_afrca/pages/Profile_page/Login_Page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_colors.dart';
import 'intro_widget.dart';

class OnBoardingCircle extends StatefulWidget {
  @override
  _OnBoardingCircleState createState() => _OnBoardingCircleState();
}

class _OnBoardingCircleState extends State<OnBoardingCircle> {
  double screenWidth = 0.1;
  double screenheight = 0.1;
  int currentPageValue = 0;
  int previousPageValue = 0;
  PageController controller;
  double _moveBar = 0.0;
  SharedPreferences prefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _init();
  }

  void _init() async {
    prefs = await SharedPreferences.getInstance();
    controller = PageController(initialPage: currentPageValue);
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenheight = MediaQuery.of(context).size.height;

    final List<Widget> introWidgetsList = <Widget>[
      IntroWidget(
          screenWidth: screenWidth,
          screenheight: screenheight,
          image: 'images/fire2.PNG',
          type: 'Fire Agency',
          startGradientColor: kBlue,
          endGradientColor: kPruple,
          subText: 'Get Quick Access to Fire agencies in your location'),
      IntroWidget(
          screenWidth: screenWidth,
          screenheight: screenheight,
          image: 'images/s.jpg',
          type: 'Security Agency',
          startGradientColor: kOrange,
          endGradientColor: kYellow,
          subText: 'Get Quick Access to Security agencies in your location'),
      IntroWidget(
          screenWidth: screenWidth,
          screenheight: screenheight,
          image: 'images/health.PNG',
          type: 'Health Agency',
          startGradientColor: kGreen,
          endGradientColor: kBlue2,
          subText: "Get Quick Access to Health agencies in your location"),
      IntroWidget(
          screenWidth: screenWidth,
          screenheight: screenheight,
          image: 'images/transport.PNG',
          type: 'Transport Agency',
          startGradientColor: kLightOrange,
          endGradientColor: kLightRed,
          subText: 'Get Quick Access to Transport agencies in your location'),

      IntroWidget(
          screenWidth: screenWidth,
          screenheight: screenheight,
          image: 'icons/hotlines_logo.PNG',
          type: 'HOTLINES AFRICA',
          startGradientColor: kLightOrange,
          endGradientColor: kLightRed,
          subText: 'Welcome to Hotlines Africa,'
              'Kindly Switch on your data'),
    ];

    return Scaffold(
      body: SafeArea(
          child: Container(
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: <Widget>[
            PageView.builder(
              physics: ClampingScrollPhysics(),
              itemCount: introWidgetsList.length,
              onPageChanged: (int page) {
                getChangedPageAndMoveBar(page);
              },
              controller: controller,
              itemBuilder: (context, index) {
                return introWidgetsList[index];
              },
            ),
            Stack(
              alignment: AlignmentDirectional.topStart,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 35),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      for (int i = 0; i < introWidgetsList.length; i++)
                        if (i == currentPageValue) ...[circleBar(true)] else
                          circleBar(false),
                    ],
                  ),
                ),
              ],
            ),
            Visibility(
              visible: currentPageValue == introWidgetsList.length - 1
                  ? true
                  : false,
              child: Align(
                alignment: AlignmentDirectional.bottomEnd,
                child: Container(
                  margin: EdgeInsets.only(right: 16, bottom: 16),
                  child: FloatingActionButton(
                    onPressed: () {
                      Utility.setOnBoardingStatus(true, prefs);
                      Route route =
                          MaterialPageRoute(builder: (context) => LoginPage());
                      Navigator.pushReplacement(context, route);
                    },
                    shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(26))),
                    child: Icon(Icons.arrow_forward),
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }

  ///--------------------------------
  /// HELPER METHODS
  /// --------------------------------
  Widget circleBar(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8),
      height: isActive ? 12 : 8,
      width: isActive ? 12 : 8,
      decoration: BoxDecoration(
          color: isActive ? kOrange : klightGrey,
          borderRadius: BorderRadius.all(Radius.circular(12))),
    );
  }

  Widget expandingBar(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 8),
      height: 8,
      width: isActive ? 25 : 8,
      decoration: BoxDecoration(
          color: isActive ? kOrange : kLightRed,
          borderRadius: BorderRadius.all(Radius.circular(12))),
    );
  }

  void getChangedPageAndMoveBar(int page) {
    print('page is $page');

    currentPageValue = page;

    if (previousPageValue == 0) {
      previousPageValue = currentPageValue;
      _moveBar = _moveBar + 0.14;
    } else {
      if (previousPageValue < currentPageValue) {
        previousPageValue = currentPageValue;
        _moveBar = _moveBar + 0.14;
      } else {
        previousPageValue = currentPageValue;
        _moveBar = _moveBar - 0.14;
      }
    }

    setState(() {});
  }

  /// ----------------------------------------------------------
  /// All onpressed methods
  /// ----------------------------------------------------------
}
