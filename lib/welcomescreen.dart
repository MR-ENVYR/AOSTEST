import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:style_of_agent/Login.dart';

import 'main.dart';



class Welcomescreen extends StatefulWidget {
  @override
  _WelcomescreenState createState() => _WelcomescreenState();
}

class _WelcomescreenState extends State<Welcomescreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final usersref = Firestore.instance.collection("users");
//  final DateTime time = DateTime.now();
//  User currentuser;
//  bool _rememberMe = false;
  GoogleSignIn _googleSignIn = new GoogleSignIn();

  Future<void> gooleSignout() async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("initScreen", 1);
    await _auth.signOut().then((onValue) {
      _googleSignIn.signOut();
//
    });

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
