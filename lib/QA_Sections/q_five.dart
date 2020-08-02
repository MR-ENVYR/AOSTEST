import 'package:style_of_agent/QA_Sections/fadeAnimation.dart';
import 'package:style_of_agent/QA_Sections/moveAnimation.dart';
import 'package:style_of_agent/QA_Sections/moveLRAnimation.dart';
import 'package:style_of_agent/QA_Sections/q_six.dart';
import 'package:style_of_agent/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';

class QueFive extends StatefulWidget {
  @override
  _QueFiveState createState() => _QueFiveState();
}

class _QueFiveState extends State<QueFive> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(3, 9, 23, 1),
        body: Container(
          width: double.infinity,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: SvgPicture.asset(
                      "assets/images/aoslogo.svg",
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Text(
                          "<",
                          style: TextStyle(color: Colors.white, fontSize: 40),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MoveAnimation(
                      1,
                      Container(
                        height: 250,
                        decoration: BoxDecoration(
//                            image: DecorationImage(
//                                image: AssetImage(
//                                  "assets/images/qa_section/q5_logo.png",
//                                ),
//                                fit: BoxFit.cover),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  FadeAnimation(
                    1.5,
                    Text(
                      "Choose your favourite Communication method",
                      textAlign: TextAlign.center,
                      style: headlineStyle,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          MoveAnimation(
                            2,
                            FlatButton(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              shape: RoundedRectangleBorder(
//                                  borderRadius:
//                                      BorderRadius.all(Radius.circular(20)),
                                  side: BorderSide(
                                      color: Color(0xFFfb4545), width: 3)),
                              color: Color(0xFFfb4545),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType
                                            .rightToLeftWithFade,
                                        child: QueSix()));
                              },

//                        textColor: ,
                              child: Text(
                                "Direct\nChat",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: "PlayfairDisplay",
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          MoveLRAnimation(
                            3,
                            FlatButton(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 17),
                              shape: RoundedRectangleBorder(
//                                  borderRadius:
//                                      BorderRadius.all(Radius.circular(20)),
                                  side: BorderSide(
                                      color: Color(0xFFfb4545), width: 3)),
                              color: Color(0xFFfb4545),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType
                                            .rightToLeftWithFade,
                                        child: QueSix()));
                              },

//                        textColor: ,
                              child: Text(
                                "WhatsApp",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: "PlayfairDisplay",
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
