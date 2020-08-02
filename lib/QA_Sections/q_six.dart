import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:style_of_agent/QA_Sections/fadeAnimation.dart';
import 'package:style_of_agent/QA_Sections/moveAnimation.dart';
import 'package:style_of_agent/QA_Sections/moveLRAnimation.dart';
import 'package:style_of_agent/animated_menu/menu_frame.dart';
import 'package:style_of_agent/model/usermodel.dart';
import 'package:style_of_agent/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';

class QueSix extends StatefulWidget {
  Map<String, dynamic> ques = Map();
  FirebaseUser user;
  QueSix({this.ques, this.user});
  @override
  _QueSixState createState() => _QueSixState();
}

class _QueSixState extends State<QueSix> {
  static final Firestore firestore = Firestore.instance;
  static final CollectionReference _quesCollection =
      firestore.collection("questions");

  UserModel _userModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showUid();
  }

  String id;
  showUid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString("uid");
    Firestore.instance.collection("users").document(uid).get().then((value) {
      setState(() {
//        name=value.data["username"];
        id = uid;
        _userModel = UserModel.fromJson(value);
      });
    });
//    setState(() {
//      uid = id;
//      print(id);
//      print("gg");
//    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
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
//              alignment: Alignment.bottomLeft,
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
//                  Align(
//                    alignment: Alignment.topRight,
//                    child: SvgPicture.asset(
//                      "assets/images/aoslogo.svg",
//                    ),
//                  ),
//                  GestureDetector(
//                    onTap: () {
//                      Navigator.pushAndRemoveUntil(
//                          context,
//                          PageTransition(
//                              type: PageTransitionType.rightToLeftWithFade,
//                              child: MenuFrame(
//                                uid: id,
//                              )),
//                          (route) => false);
//                    },
//                    child: Align(
//                      alignment: Alignment.bottomLeft,
//                      child: Padding(
//                        padding: const EdgeInsets.only(right: 20),
//                        child: Text(
//                          "<",
//                          style: TextStyle(color: Colors.white, fontSize: 40),
//                        ),
//                      ),
//                    ),
//                  ),
            SizedBox(
              height: 20,
            ),
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
                            "assets/images/qa_section/dashboard.jpg",
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
              height: 30,
            ),

            FadeAnimation(
              1.5,
              Text(
                "Get Your style advice",
                textAlign: TextAlign.center,
                style: headlineStyle,
              ),
            ),
            SizedBox(
              height: 60,
            ),
//                Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                MoveAnimation(
                  2,
                  FlatButton(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    shape: RoundedRectangleBorder(
//                              borderRadius:
//                                  BorderRadius.all(Radius.circular(20)),
                        side: BorderSide(color: Color(0xFFfb4545), width: 3)),
                    color: Color(0xFFfb4545),
                    onPressed: () async {
                      widget.ques.putIfAbsent("ques6", () => "Use diamonds");
                      widget.ques.putIfAbsent(
                        "uid",
                        () => id,
                      );
                      widget.ques
                          .putIfAbsent("username", () => _userModel.username);
                      widget.ques.putIfAbsent(
                          "phone no", () => _userModel.phonenumber);
                      await _quesCollection.document().setData(widget.ques);
                      Navigator.pushAndRemoveUntil(
                          context,
                          PageTransition(
                              type: PageTransitionType.rightToLeftWithFade,
                              child: MenuFrame(
                                uid: id,
                              )),
                          (route) => false);
                    },

//                        textColor: ,
                    child: Text(
                      "Use \ndiamonds",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: "FreigSanPro",
                          color: Colors.white),
                    ),
                  ),
                ),
                MoveLRAnimation(
                  2.3,
                  FlatButton(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    shape: RoundedRectangleBorder(
//                              borderRadius:
//                                  BorderRadius.all(Radius.circular(20)),
                        side: BorderSide(color: Color(0xFFfb4545), width: 3)),
                    color: Color(0xFFfb4545),
                    onPressed: () async {
//                          Navigator.pop(context);
                      widget.ques
                          .putIfAbsent("ques6", () => "Recharge your diamonds");
                      widget.ques.putIfAbsent(
                        "uid",
                        () => id,
                      );
                      widget.ques
                          .putIfAbsent("username", () => _userModel.username);
                      widget.ques.putIfAbsent(
                          "phone no", () => _userModel.phonenumber);
                      await _quesCollection.document().setData(widget.ques);
                      print(widget.ques);
                      Navigator.pushAndRemoveUntil(
                          context,
                          PageTransition(
                              type: PageTransitionType.rightToLeftWithFade,
                              child: MenuFrame(
//                                      user: widget.user,
                                uid: id,
                              )),
                          (route) => false);
                    },

//                        textColor: ,
                    child: Text(
                      "Recharge your \ndiamonds",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: "FreigSanPro",
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
