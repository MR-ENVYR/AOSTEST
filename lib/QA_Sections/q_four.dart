import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:style_of_agent/QA_Sections/fadeAnimation.dart';
import 'package:style_of_agent/QA_Sections/moveAnimation.dart';
import 'package:style_of_agent/QA_Sections/moveLRAnimation.dart';
import 'package:style_of_agent/QA_Sections/q_five.dart';
import 'package:style_of_agent/QA_Sections/q_six.dart';
import 'package:style_of_agent/QA_Sections/q_two.dart';
import 'package:style_of_agent/extension/string_extension.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:style_of_agent/animated_menu/menu_frame.dart';
import 'package:style_of_agent/utils/utils.dart';

class QueFour extends StatefulWidget {
  Map<String, dynamic> ques = Map();
  FirebaseUser user;
  QueFour({this.ques, this.user});
  @override
  _QueFourState createState() => _QueFourState();
}

class _QueFourState extends State<QueFour> {
  String name = "";
  @override
  void initState() {
    // TODO: implement initState

    showUid();
    super.initState();
//    print(widget.user.uid);
//    Firestore.instance
//        .collection("users")
//        .document(widget.user.uid)
//        .get()
//        .then((value) {
//      setState(() {
//        name = value.data["username"];
//      });
//    });
  }

  showUid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString("uid");
    Firestore.instance.collection("users").document(uid).get().then((value) {
      setState(() {
        name = value.data["username"];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Container(
//      height: height,
//      width: width,
      color: Color.fromRGBO(3, 9, 23, 1),
//      decoration: BoxDecoration(
//          image: DecorationImage(
//              image: AssetImage("assets/images/qa_section/q4_logo.jpg"),
//              fit: BoxFit.fill)),
      child: Scaffold(
//        backgroundColor: Colors.transparent,
        backgroundColor: Color.fromRGBO(3, 9, 23, 1),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(3, 9, 23, 1),
          title: Align(
            alignment: Alignment.topRight,
            child: SvgPicture.asset(
              "assets/images/aoslogo.svg",
              height: 55,
//              width: 10,
            ),
          ),
//          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeftWithFade,
                      child: MenuFrame(
//                                uid: id,
                          )),
                  (route) => false);
            },
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  "<",
                  style: TextStyle(color: Colors.white, fontSize: 40),
                ),
              ),
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
//                    Align(
//                      alignment: Alignment.topRight,
//                      child: SvgPicture.asset(
//                        "assets/images/aoslogo.svg",
//                      ),
//                    ),
//                    GestureDetector(
//                      onTap: () {
//                        Navigator.pushAndRemoveUntil(
//                            context,
//                            PageTransition(
//                                type: PageTransitionType.rightToLeftWithFade,
//                                child: MenuFrame(
////                                  uid: id,
//                                    )),
//                            (route) => false);
//                      },
//                      child: Align(
//                        alignment: Alignment.bottomLeft,
//                        child: Padding(
//                          padding: const EdgeInsets.only(right: 20),
//                          child: Text(
//                            "<",
//                            style: TextStyle(color: Colors.white, fontSize: 40),
//                          ),
//                        ),
//                      ),
//                    ),
              SizedBox(
                height: 20,
              ),
//                  MoveAnimation(
//                      1,
//                      Container(
//                        height: 250,
//                        decoration: BoxDecoration(
//                            image: DecorationImage(
//                                image: AssetImage(
//                                  "assets/images/qa_section/q4_logo.png",
//                                ),
//                                fit: BoxFit.cover),
//                            borderRadius:
//                                BorderRadius.all(Radius.circular(20))),
//                      )),
              MoveAnimation(
                  1,
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Container(
                      height: 250,
                      width: 250,
//                          width: 300,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              "assets/images/qa_section/q4_logo.jpg",
                            ),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
//                            child: Image.asset(
//                              "assets/images/qa_section/q1_logo.jpg",
//                              scale: 2,
//                              fit: BoxFit.cover,
////                              fit: BoxFit.cover,
//
////                              height: 300,
//                              width: 300,
//                            )
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              FadeAnimation(
                1.5,
                Text(
                  "Fantastic ${name.split(" ").first}.\n\n We are matching you to a stylist",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xFFc0a948),
                      fontFamily: "Helvetica",
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold,
                      fontSize: 35),
                ),
              ),
//                    Spacer(),
              SizedBox(
                height: 15,
              ),
              MoveAnimation(
                2,
                FlatButton(
                  padding: EdgeInsets.symmetric(
                      horizontal: 50, vertical: 5),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Color(0xFFfb4545), width: 3)),
                  color: Color(0xFFfb4545),
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeftWithFade,
                            child: QueSix(
//                                      user: widget.user,
                                ques: widget.ques)));
                  },

//                        textColor: ,
                  child: Text(
                    "Next",
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: "FreigSanPro",
                        color: Colors.white),
                  ),
                ),
              ),
//                    SizedBox(
//                      height: 20,
//                    )
            ],
          ),
        ),
      ),
    );
  }
}
