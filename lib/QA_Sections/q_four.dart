import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:style_of_agent/QA_Sections/fadeAnimation.dart';
import 'package:style_of_agent/QA_Sections/moveAnimation.dart';
import 'package:style_of_agent/QA_Sections/moveLRAnimation.dart';
import 'package:style_of_agent/QA_Sections/q_five.dart';
import 'package:style_of_agent/QA_Sections/q_six.dart';
import 'package:style_of_agent/QA_Sections/q_two.dart';
import 'package:style_of_agent/connection.dart';
import 'package:style_of_agent/extension/string_extension.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:style_of_agent/animated_menu/menu_frame.dart';
import 'package:style_of_agent/model/usermodel.dart';
import 'package:style_of_agent/utils/utils.dart';

class QueFour extends StatefulWidget {
  Map<String, dynamic> ques = Map();
  FirebaseUser user;
  QueFour({this.ques, this.user});
  @override
  _QueFourState createState() => _QueFourState();
}

class _QueFourState extends State<QueFour> {
  String uid;
  UserModel userModel;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    showUid();
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
    setState(() {
      uid = prefs.getString("uid");
    });

//    Firestore.instance.collection("users").document(uid).get().then((value) {
//      setState(() {
//        userModel = UserModel.fromJson(value);
//      });
//    });
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
          body: FutureBuilder(
            future: Firestore.instance.collection("users").document(uid).get(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),

                      SizedBox(
                        height: 20,
                      ),

                      MoveAnimation(
                          1,
                          Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Container(
                              width: MediaQuery.of(context).size.height / 3,
                              height: MediaQuery.of(context).size.height / 3,
//                          width: 300,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      "assets/images/qa_section/q4_logo.jpg",
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                            ),
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      FadeAnimation(
                        1.5,
                        Text(
                          "Fantastic ${snapshot.data["username"].split(" ").first}.\n\n We are matching you to a stylist",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color(0xFFE5CF73),
                              fontFamily: "FreigSanPro",
                              letterSpacing: 2,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
//                    Spacer(),
                      SizedBox(
                        height: 15,
                      ),
                      MoveAnimation(
                        2,
                        FlatButton(
                          padding:
                              EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                  color: Color(0xFFfb4545), width: 3)),
                          color: Color(0xFFfb4545),
                          onPressed: () {
                            checkConnection(context);
                            Navigator.push(
                                context,
                                PageTransition(
                                    type:
                                        PageTransitionType.rightToLeftWithFade,
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
                );
              } else {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(
                            Color(0xFFE5CF73)),
                        backgroundColor: Colors.white,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        "Please wait...",
                        style: TextStyle(
                          fontFamily: "Helvetica",
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          )),
    );
  }
}
