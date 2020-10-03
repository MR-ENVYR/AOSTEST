import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:style_of_agent/connection.dart';
import 'package:style_of_agent/extension/string_extension.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:style_of_agent/Login.dart';
import 'package:style_of_agent/stylist/animated_menu/profile.dart';
//import 'package:style_of_agent/Splashscreen.dart';

class StyleMenuScreen extends StatefulWidget {
  final Function(int) menuCallback;

  StyleMenuScreen({this.menuCallback});
  @override
  _StyleMenuScreenState createState() => _StyleMenuScreenState();
}

class _StyleMenuScreenState extends State<StyleMenuScreen> {
  int selectedMenuIndex = 0;
  FirebaseAuth _auth = FirebaseAuth.instance;
  final usersref = Firestore.instance.collection("users");
  GoogleSignIn _googleSignIn = new GoogleSignIn();
  final facebookLogin = new FacebookLogin();

  @override
  initState() {
    super.initState();

//    checkConnection(context);

    showUid();
//    gooleSignout();
  }

// aI25I4rFCrdGKoz10gythVWBgz62
  String name, email, url;

  showUid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString("uid");
    Firestore.instance.collection("users").document(uid).get().then((value) {
      setState(() {
        name = value.data["username"];
        email = value.data["email"];
        url = value.data['url'];
      });
    });
  }

  Future<void> gooleSignout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
//    initScreen = await prefs.getInt("initScreen");
//    print("$initScreen");
    await prefs.setInt("initScreen", 1);
    await prefs.setString("uid", "");
    await prefs.setBool("isStylist", false);
    // showAlertDialog(context,initScreen.toString());
    await _auth.signOut().then((onValue) {
      _googleSignIn.signOut();
      facebookLogin.logOut();
    });
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
  }

  List<String> menuItems = [
    'Home',
    'Contact us',
    'FAQ',
    'Deliveries &\nShipment',
    'About us',
    'Rate us'
  ];

  Widget buildMenuRow(int index) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedMenuIndex = index;
          widget.menuCallback(index);
        });
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0),
        child: Row(
          children: <Widget>[
//            Image.asset(
//              icons[index],
//              color:
//                  selectedMenuIndex == index ? Colors.white : Color(0xFFE5CF73),
//            ),
//            SizedBox(
//              width: 8.0,
//            ),
            Text(
              menuItems[index],
              style: TextStyle(
                fontFamily: "FreigSanPro",
                color: selectedMenuIndex == index
                    ? Colors.white
                    : Color(0xFFE5CF73),
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    showUid();
    return Material(
      child: Container(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 24.0,
              horizontal: 20.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 24.0,
                      backgroundImage: url == null
                          ? AssetImage(
                              'assets/images/av.jpg',
                            )
                          : NetworkImage(url),
                    ),
                    SizedBox(
                      width: 16.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          name ?? " ".capitalises(),
                          style: TextStyle(
                            fontFamily: "FreigSanPro",
                            color: Colors.white.withOpacity(0.85),
                            fontWeight: FontWeight.w600,
                            fontSize: 17.0,
                          ),
                        ),
                        Text(
                          email ?? " ",
                          style: TextStyle(
                            fontFamily: "FreigSanPro",
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                            fontSize: 15.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: menuItems
                      .asMap()
                      .entries
                      .map((mapEntry) => buildMenuRow(mapEntry.key))
                      .toList(),
                ),
                Row(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StyleProfile(
//                                      check: true,
                                    )));
                      },
                      child: Text(
                        'Settings',
                        style: TextStyle(
                          fontFamily: "FreigSanPro",
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    VerticalDivider(),
                    InkWell(
                      onTap: () {
                        gooleSignout();
                      },
                      child: Text(
                        'Log out',
                        style: TextStyle(
                          fontFamily: "FreigSanPro",
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        color: Color.fromRGBO(3, 9, 23, 1),
      ),
    );
  }
}
