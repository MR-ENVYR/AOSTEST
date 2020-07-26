import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:style_of_agent/Login.dart';
import 'introwidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';

class OnBoardingCircle extends StatefulWidget {
  @override
  _OnBoardingCircleState createState() => _OnBoardingCircleState();
}

class _OnBoardingCircleState extends State<OnBoardingCircle> {
  double screenWidth = 0.0;
  double screenheight = 0.0;
  int currentPageValue = 0;
  int previousPageValue = 0;
  PageController controller;
  double _moveBar = 0.0;
  SharedPreferences prefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
          image: 'assets/images/woman4.jpg',
          type: 'Create your personal profile',
          startGradientColor: Color(0xFFc0a948),
          endGradientColor: Colors.amber,
          subText:
              'Connect with fashion professionals from the comfort of your home'),
      IntroWidget(
          screenWidth: screenWidth,
          screenheight: screenheight,
          image: 'assets/images/man1.jpg',
          type: 'Upload your outfit selfie',
          startGradientColor: Color(0xFFc0a948),
          endGradientColor: Colors.amber,
          subText:
              'Upload your outfit selfie and get the best suited recommendations on what to wear today'),
      IntroWidget(
          screenWidth: screenWidth,
          screenheight: screenheight,
          image: 'assets/images/woman3.jpg',
          type: 'Get instant style device',
          startGradientColor: Color(0xFFc0a948),
          endGradientColor: Colors.amber,
          subText:
              "Upload your pic and get the best suited recommendations from our stylists"),
//      IntroWidget(
//          screenWidth: screenWidth,
//          screenheight: screenheight,
//          image: 'assets/images/man2.jpg',
//          type: 'Secure end to end chats',
//          startGradientColor: Colors.orange,
//          endGradientColor: Colors.red,
//          subText:
//              'Acess your chats with stylists anytime you need them.Our secure end to end framework keeps your chats personal'),
//      IntroWidget(
//          screenWidth: screenWidth,
//          screenheight: screenheight,
//          image: 'assets/images/woman3.jpg',
//          type: 'Experience modern styling',
//          startGradientColor: Colors.orange,
//          endGradientColor: Colors.red,
//          subText:
//              'The Agents of Style are ready to deduce your requirement.Lets get started'),
    ];
//    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: Container(
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: <Widget>[
                PageView.builder(
                  physics: ClampingScrollPhysics(),
                  itemCount: introWidgetsList.length,
                  onPageChanged: (int page) {
                    setState(() {
                      currentPageValue=page;
                    });
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
                      margin: EdgeInsets.only(bottom: 30, left: 30),
                      alignment: Alignment.bottomLeft,
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
                        backgroundColor: Colors.deepOrange,
                        onPressed: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                               await prefs.setInt("initScreen", 1);
                          Route route = MaterialPageRoute(
                              builder: (context) => LoginScreen());
                          Navigator.pushReplacement(context, route);
                        },
                        shape: BeveledRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(26))),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
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
      curve: Curves.easeIn,
      margin: EdgeInsets.symmetric(horizontal: 6.0),
      height: 8.0,
      width: isActive ? 35.0 : 25.0,
      decoration: BoxDecoration(
        color: isActive ? Color(0xFFc0a948): Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    );
  }
}
