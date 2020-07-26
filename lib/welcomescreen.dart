import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:style_of_agent/Login.dart';
import 'package:style_of_agent/progress.dart';

import 'main.dart';



class Welcomescreen extends StatefulWidget {
  FirebaseUser user;
  Welcomescreen({this.user});

  @override
  _WelcomescreenState createState() => _WelcomescreenState();
}

class _WelcomescreenState extends State<Welcomescreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final usersref = Firestore.instance.collection("users");
  GoogleSignIn _googleSignIn = new GoogleSignIn();
  final facebookLogin = new FacebookLogin();

  Future<void> gooleSignout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    initScreen = await prefs.getInt("initScreen");
print("$initScreen");
    await prefs.setInt("initScreen", 1);
    showAlertDialog(context,initScreen.toString());
    await _auth.signOut().then((onValue) {
      _googleSignIn.signOut();
      facebookLogin.logOut();
    });
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => LoginScreen()));

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      width: 40.0,
      child: Center(
        child: RaisedButton(
          color: Colors.red,
          onPressed:()=>gooleSignout(),
        )
      ),
    );
  }
}
