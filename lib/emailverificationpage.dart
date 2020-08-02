import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'Login.dart';
import 'progress.dart';
import 'utils.dart';

class Emailverification extends StatefulWidget {

  @override
  _EmailverificationState createState() =>
      _EmailverificationState();
}

class _EmailverificationState extends State<Emailverification> {
  FirebaseAuth auth=FirebaseAuth.instance;
  GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  FocusNode emailNode = FocusNode();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff030b2f),
      key: scaffoldkey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed:(){
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title:
            Text(
              'Reset Password',
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Playfairdisplay",
                fontSize: 30.0,
                fontWeight: FontWeight.w800,),
            ),

      ),
      resizeToAvoidBottomInset: false,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xff030b2f),
          ),
            child: Stack(
              children: <Widget>[
                Container(
                  height: double.infinity,
                  width: double.infinity,
                ),

                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 150.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover, image: AssetImage(
                              'assets/images/email.png',
                            ),),
                            borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'We will mail you a link..Please click on that link to reset your password',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontFamily: "Helvetica",
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: emailController,
                          focusNode: emailNode,
                          validator: (String email) => emailValidator(email),
                          cursorColor: Colors.white,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).unfocus();
                          },
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Helvetica",
                              fontWeight: FontWeight.w200),
                          decoration: InputDecoration(
                            labelText: "Email",
                            hintStyle: TextStyle(
                                color: Colors.white60,
                                fontFamily: "Helvetica",
                                fontWeight: FontWeight.w200),
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
                        SizedBox(
                          height: 40,
                        ),
                        FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color:Color(0xFFfb4545),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Text(
                              '          Send          ',
                              style: TextStyle(
                                  color:Colors.white,
                                  fontSize: 20.0,
                                  fontFamily: "Helvetica",
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          onPressed: () async {
                            FocusScope.of(context).unfocus();
                            if (_formKey.currentState.validate()) {
                              showAlertDialog(context,"Email sent..Redirecting to Login page");
                              emailController.text = emailController.text.trim();
                             await auth.sendPasswordResetEmail(email: emailController.text).whenComplete(() async =>
                                 await Future.delayed(Duration(milliseconds: 2000), () async {
                                   await Navigator.pop(context);
                                   Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
                            }));
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )
          ),
        ),
      );
  }
}