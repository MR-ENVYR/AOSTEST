import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:style_of_agent/model/usermodel.dart';
import 'package:style_of_agent/welcomescreen.dart';
import 'Signup.dart';
import 'utils.dart';

class FirebaseMethods {

  //PHONE NUMBER VERIFICATION
  sendCodeToPhoneNumber(FirebaseUser currentuser, {@required String phonenumber, BuildContext context}) {
    PHONE_NO = phonenumber;
    FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phonenumber,
        timeout: Duration(seconds: 15),
        verificationCompleted: (AuthCredential authCredentials) {
        },
        verificationFailed: (AuthException authException) {
          showToast(msg: authException.message);
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          TextEditingController smsController = TextEditingController();
          GlobalKey<FormState> _formKey = GlobalKey<FormState>();
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor: Colors.black54,
                title: Text("Enter SMS Code", style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Helvetica",
                    fontWeight: FontWeight.w400)),
                content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextFormField(
                        controller: smsController,
                        validator: (String code) => smsValidator(code),
                        cursorColor: Colors.white,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (value) {
                          FocusScope.of(context).unfocus();
                        },
                        style: labelStyle,
                        decoration: InputDecoration(
                          labelText: "SMS Code",
                          labelStyle: TextStyle(
                              color: Colors.white,
                              fontFamily: "Helvetica",
                              fontWeight: FontWeight.w200),
                          enabledBorder: labelBorder,
                          focusedBorder: labelBorder,
                          errorBorder: errorBorder,
                          border: labelBorder,
                          errorStyle: errorStyle,
                          filled: true,
                          fillColor: Colors.white12,
                        ),
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Colors.deepOrange,
                    child: Text(
                      "Done",
                      style: TextStyle(
                          color:Colors.white,
                          fontFamily: "Helvetica",
                          fontSize: 10.0,
                          fontWeight: FontWeight.w200),
                    ),
                    onPressed: () async {
                      FocusScope.of(context).unfocus();
                      if (_formKey.currentState.validate()) {
                        String sms = smsController.text.trim();
                        AuthCredential _credentials;
                        _credentials = PhoneAuthProvider.getCredential(
                            verificationId: verificationId, smsCode: sms);
                        _firebaseAuth
                            .signInWithCredential(_credentials)
                            .then((AuthResult result) async {
                          if (result.user != null) {
                            showToast(
                                msg:
                                "Congrats, your phone number is verified");
                            await usersref.document(currentuser.uid).updateData({
                              "phonenumber":phonenumber,
                              "isphoneverified":true
                            });
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            await prefs.setInt("initScreen",3);
                            Navigator.of(context).pushReplacement(MaterialPageRoute(
                                builder: (BuildContext context) => Welcomescreen()));
                            await _firebaseAuth.signOut();
                          } else {
                            Navigator.pop(context);
                            showToast(msg: "Phone number is not verified");
                          }
                        }).catchError((onError) {
                          showToast(msg: onError.toString());
                          Navigator.pop(context);
                        });
                      }
                        //Navigator.pop(context);
                    },
                  )
                ],
              ));
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          verificationId = verificationId;
          print(verificationId);
          print("Timeout");
        });
  }


}