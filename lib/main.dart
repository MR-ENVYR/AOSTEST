import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:style_of_agent/Login.dart';
import 'package:style_of_agent/animated_menu/dashboard.dart';
import 'package:style_of_agent/phoneauthpage.dart';
import 'package:style_of_agent/animated_menu/menu_frame.dart';
import 'package:style_of_agent/profile_filling.dart';
import 'package:style_of_agent/stylist/animated_menu/dashboard.dart';
import 'package:style_of_agent/welcomescreen.dart';
import 'newonboard.dart';

int initScreen;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initScreen = await _mockCheckForSession();
  runApp(MyApp());
}

Future<int> _mockCheckForSession() async {
  await Future.delayed(Duration(milliseconds: 1000), () {});
  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = await prefs.getInt("initScreen");
  return initScreen;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: (initScreen == 0 || initScreen == null)
            ? OnBoardingCircle()
            : (initScreen == 1)
                ? LoginScreen()
                : (initScreen == 2)
                    ? PhoneVerificationScreen()
                    : (initScreen != 10)
                        ? ProfileFilling()
                        : (getUserType() == true)
                            ? StyleDashBoard()
                            : MenuFrame());
  }
}

Future<bool> getUserType() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool isStylist = prefs.getBool('isStylist');
  print(isStylist);
  print("get isStylist");
  return isStylist;
}
