import 'dart:async';

import 'package:app_settings/app_settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:style_of_agent/connection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:style_of_agent/animated_menu/about.dart';
import 'package:style_of_agent/animated_menu/faq.dart';
import 'package:style_of_agent/animated_menu/menu_screen.dart';
import 'package:style_of_agent/animated_menu/contact_us.dart';
import 'package:style_of_agent/animated_menu/dashboard.dart';
import 'package:style_of_agent/animated_menu/policy.dart';
import 'package:style_of_agent/animated_menu/profile.dart';
import 'package:style_of_agent/animated_menu/rate_us.dart';
import 'package:flutter/material.dart';
import 'package:style_of_agent/model/usermodel.dart';
import 'package:style_of_agent/utils/utils.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MenuFrame extends StatefulWidget {
  int index;
  bool animate;
//  FirebaseUser user;
  String uid;
  MenuFrame({this.index = -1, this.animate = false, this.uid});
  @override
  _MenuFrameState createState() => _MenuFrameState();
}

class _MenuFrameState extends State<MenuFrame>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> scaleAnimation, smallerScaleAnimation;
  Duration duration = Duration(milliseconds: 500);
  bool menuOpen = false;
  static UserModel userModel;
  List<Animation> scaleAnimations;

  @override
  void initState() {
    super.initState();
//    checkConnection(context);
    setupUid();
    showUid();
    _animationController = AnimationController(vsync: this, duration: duration);
    scaleAnimation =
        Tween<double>(begin: 1.0, end: 0.7).animate(_animationController);
    smallerScaleAnimation =
        Tween<double>(begin: 1.0, end: 0.6).animate(_animationController);

    scaleAnimations = [
      Tween<double>(begin: 1.0, end: 0.7).animate(_animationController),
      Tween<double>(begin: 1.0, end: 0.65).animate(_animationController),
      Tween<double>(begin: 1.0, end: 0.6).animate(_animationController),
      Tween<double>(begin: 1.0, end: 0.55).animate(_animationController),
      Tween<double>(begin: 1.0, end: 0.5).animate(_animationController),
      Tween<double>(begin: 1.0, end: 0.45).animate(_animationController),
    ];

//    _animationController.reverse();
    screenSnapshot = screens.values.toList();
    colors1 = colors.toList();
//    FirebaseAuth.instance.signOut();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
  }

  void setupUid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

//    await prefs.setInt("initScreen", 10);
    String uid = await prefs.getString("uid");
    if (uid == null) {
      await prefs.setString("uid", widget.uid);
      print("uid menu ${widget.uid}");
    } else {
      setState(() {
        widget.uid = uid;
      });
    }
  }

  showUid() async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    String id = prefs.getString("uid");
    Firestore.instance
        .collection("users")
        .document(widget.uid)
        .get()
        .then((value) {
      setState(() {
        print("uid  show   ${widget.uid}");
//        uid = id;
        userModel = UserModel.fromJson(value);
      });
    });
  }

  Map<int, Widget> screens = {
    0: DashBoard(),
    1: ContactUs(),
    2: FAQ(),
    3: Policy(),
    4: About(),
    5: RateUs(),
  };
  List<Color> colors = [
    Colors.yellow,
    Colors.blue,
    Colors.brown,
    Colors.deepOrange,
    Colors.greenAccent,
    Colors.lightBlueAccent
  ];
  List<Widget> screenSnapshot;
  List<Color> colors1;
  List<Widget> finalStack() {
    List<Widget> stackToReturn = [];
    stackToReturn.add(MenuScreen(
      menuCallback: (selectedIndex) {
        setState(() {
          screenSnapshot = screens.values.toList();
          colors1 = colors.toList();
          final color = colors1.removeAt(selectedIndex);
          final selectedWidget = screenSnapshot.removeAt(selectedIndex);
          screenSnapshot.insert(0, selectedWidget);
          colors1.insert(0, color);
          menuOpen = false;
          _animationController.reverse();
        });
      },
    ));

    screenSnapshot
        .asMap()
        .entries
        .map((screenEntry) => buildScreenStack(screenEntry.key))
        .toList()
        .reversed
      ..forEach((screen) {
        stackToReturn.add(screen);
      });

    return stackToReturn;
  }

  Widget buildScreenStack(int position) {
//    checkConnection();

    final deviceWidth = MediaQuery.of(context).size.width;
    return AnimatedPositioned(
      curve: Curves.fastOutSlowIn,
      duration: duration,
      top: 0,
      bottom: 0,
      left: menuOpen ? deviceWidth * 0.55 - (position * 30) : 0.0,
      right: menuOpen ? deviceWidth * -0.45 + (position * 30) : 0.0,
      child: ScaleTransition(
        scale: scaleAnimations[position],
        child: GestureDetector(
          onTap: () {
//            FocusScope.of(context).unfocus();
            setState(() {
              if (menuOpen) {
                _animationController.reverse();
                menuOpen = false;
              }
//              else
//                _animationController.forward();
            });
//            print("${position} -- ${scaleAnimations[position]}");
          },
          child: Material(
            animationDuration: duration,
            type: MaterialType.transparency,
//            clipBehavior: Clip.antiAliasWithSaveLayer,
//            borderRadius: !menuOpen
//                ? new BorderRadius.circular(
//                    (1 - scaleAnimations[position].value) * 40)
//                : BorderRadius.circular(40),
            child: Stack(
              children: <Widget>[
                Container(
//                    duration: Duration(milliseconds: 100),
                    decoration: BoxDecoration(
                      border: menuOpen
                          ? Border.all(color: colors1[position], width: 2)
                          : Border.all(
                              color: colors1[position],
                              width: scaleAnimations[position].isDismissed
                                  ? (1 - scaleAnimations[position].value) * 2
                                  : 0),
                      borderRadius: menuOpen
                          ? BorderRadius.circular(40.0)
                          : new BorderRadius.circular(
                              scaleAnimations[position].isDismissed
                                  ? (1 - scaleAnimations[position].value) * 40
                                  : 0),
                    ),
                    child: menuOpen
                        ? new ClipRRect(
                            borderRadius: new BorderRadius.circular(40),
                            child: screenSnapshot[position])
                        : new ClipRRect(
                            borderRadius: new BorderRadius.circular(
                                scaleAnimations[position].isDismissed
                                    ? (1 - scaleAnimations[position].value) * 40
                                    : 0),
                            child: screenSnapshot[position])),
                GestureDetector(
                  onTap: () {
                    print("${position} -- ${scaleAnimations[position]}");
                    setState(() {
                      FocusScope.of(context).unfocus();
                      if (!menuOpen)
//                        _animationController.reverse();
//                      else
                      {
                        _animationController.forward();
                        menuOpen = true;
                      } else {
                        _animationController.reverse();
                        menuOpen = false;
                      }
//                      _animationController.stop();
                      print("${position} -- ${scaleAnimations[position]}");
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40.0, left: 30),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: menuOpen
                          ? Icon(
                              Icons.arrow_forward,
                              color: Color(0xFFE5CF73),
                            )
                          : Icon(
                              Icons.menu,
                              color: Color(0xFFE5CF73),
                            ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: DoubleBackToCloseApp(
          child: Stack(
            children: finalStack(),
          ),
          snackBar: const SnackBar(
            backgroundColor: Colors.black54,
            content: Text(
              'Tap back again to leave',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Helvetica",
                  fontWeight: FontWeight.w200),
            ),
          )),
    );
  }
}
