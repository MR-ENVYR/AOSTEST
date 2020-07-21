import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'package:shimmer/shimmer.dart';
import 'package:style_of_agent/phoneauthpage.dart';
import 'package:style_of_agent/welcomescreen.dart';
import 'Login.dart';
import 'newonboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

int initScreen;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _mockCheckForSession().then((value) {
      if (value == 0 || value == null) {
        _navigateToonboard();
      } else if(value==1) {
        _navigateToLogin();
      }
      else if(value==2){
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => PhoneVerificationScreen()));
      }
      else if(value==3){
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => Welcomescreen()));
      }
    });

    super.initState();
  }

  Future<int> _mockCheckForSession() async {
    await Future.delayed(Duration(milliseconds: 1000), () {});
    SharedPreferences prefs = await SharedPreferences.getInstance();
    initScreen = await prefs.getInt("initScreen");
    if(initScreen==null || initScreen==0){
      await prefs.setInt("initScreen",1);
    }
    print('initScreen ${initScreen}');
    return initScreen;
  }

  void _navigateToonboard() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => OnBoardingCircle()));
  }

  void _navigateToLogin() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.black,
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Shimmer.fromColors(
              period: Duration(milliseconds: 2500),
              baseColor: Colors.white,
              highlightColor: Color(0xFFc0a948),
              child: Container(
                  padding: EdgeInsets.all(16.0),
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: "AGENTS OF\n",
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: "Helvetica",
                          fontWeight: FontWeight.w200,
                          color: Colors.black,
                          letterSpacing: 3,
                        )),
                    TextSpan(
                        text: "STYLE",
                        style: TextStyle(
                            letterSpacing: 3,
                            fontSize: 60,
                            color: Color(0xFFc0a948),
                            fontFamily: "PlayfairDisplay"))
                  ]))),
            )
          ],
        ),
      ),
    ));
  }
}
