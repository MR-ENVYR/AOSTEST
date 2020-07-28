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
  @override
  _WelcomescreenState createState() => _WelcomescreenState();
}

class _WelcomescreenState extends State<Welcomescreen> {
  FirebaseAuth _auth=FirebaseAuth.instance;
  String uid;
  final usersref = Firestore.instance.collection("users");
  GoogleSignIn _googleSignIn = new GoogleSignIn();
  final facebookLogin = new FacebookLogin();

  @override
  void initState() {
    super.initState();
    getuid();
  }

  Future<void>getuid() async {
    await Future.delayed(Duration(milliseconds: 2000), () {});
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String currentuseruid = await prefs.getString("uid");
    if(currentuseruid==null){
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => LoginScreen()));
    }
    setState(() {
      uid=currentuseruid;
    });
  }

  Future<void> gooleSignout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    initScreen = await prefs.getInt("initScreen");
    await prefs.setInt("initScreen", 1);
    await prefs.setInt("uid",null);
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
        child: Column(
          children: <Widget>[
            RaisedButton(
                color: Colors.red,
                child: uid==null?IconButton(
                  onPressed: gooleSignout,
                  icon: Icon(Icons.alternate_email),
                  color: Colors.white,
                ):Text(
                  uid,
                  style: (TextStyle(
                      color: Colors.white
                  )),
                )
            ),
            RaisedButton(
                color: Colors.red,
                child:IconButton(
                  onPressed: gooleSignout,
                  icon: Icon(Icons.alternate_email),
                  color: Colors.white,
                )
            )
          ],
        )
      ),
    );
  }
}
