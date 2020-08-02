import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:style_of_agent/phoneauthpage.dart';
import 'package:style_of_agent/progress.dart';
import 'package:style_of_agent/utils.dart';
import 'package:style_of_agent/welcomescreen.dart';

import 'emailverificationpage.dart';
import 'model/usermodel.dart';


final usersref = Firestore.instance.collection("users");
final DateTime time = DateTime.now();
User currentuser;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  FirebaseAuth _auth = FirebaseAuth.instance;
  final usersref = Firestore.instance.collection("users");
  final DateTime time = DateTime.now();
  User currentuser;
  bool _rememberMe = false;
  GoogleSignIn _googleSignIn = new GoogleSignIn();
  final facebookLogin = new FacebookLogin();
  GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  String email;
  String password;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Future<FirebaseUser> firebaseAuthWithFacebook(
      {@required FacebookAccessToken token}) async {
    AuthCredential credential =
        FacebookAuthProvider.getCredential(accessToken: token.token);
    FirebaseUser firebaseUser =
        (await _auth.signInWithCredential(credential)).user;
    return firebaseUser;
  }

  handlefacebooklogin() async {
    showAlertDialog(context, "Getting credentials..");
    final facebookLoginResult =
        await facebookLogin.logIn(['email', 'public_profile']);
    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        Navigator.pop(context);
        final snackbar = SnackBar(
          backgroundColor: Colors.black45,
          content: Text(
            "Error! Please try again ",
            style: TextStyle(
                color: Colors.white,
                fontFamily: "Helvetica",
                fontWeight: FontWeight.w200),
          ),
        );
        scaffoldkey.currentState.showSnackBar(snackbar);
        break;

      case FacebookLoginStatus.cancelledByUser:
        Navigator.pop(context);
        final snackbar = SnackBar(
          backgroundColor: Colors.black45,
          content: Text(
            "Cancelled by you!",
            style: TextStyle(
                color: Colors.white,
                fontFamily: "Helvetica",
                fontWeight: FontWeight.w200),
          ),
        );
        scaffoldkey.currentState.showSnackBar(snackbar);

        break;

      case FacebookLoginStatus.loggedIn:

        /// calling the auth mehtod and getting the logged user
        var firebaseUser = await firebaseAuthWithFacebook(
            token: facebookLoginResult.accessToken);
        checkuserfromfirestore(firebaseUser);
    }
  }

  Future<void> handleSignIn() async {
    FocusScope.of(context).unfocus();
    showAlertDialog(context, "Please wait..");
    try {
      GoogleSignInAccount googleSignInAccount =
          await _googleSignIn.signIn().catchError((onError) {
        Navigator.pop(context);
        final snackbar = SnackBar(
          backgroundColor: Colors.black54,
          content: Text(
            onError.toString(),
            style: TextStyle(
                color: Colors.white,
                fontFamily: "Helvetica",
                fontWeight: FontWeight.w200),
          ),
        );
        scaffoldkey.currentState.showSnackBar(snackbar);
      });
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication.catchError((onError) {
        Navigator.pop(context);
        final snackbar = SnackBar(
          backgroundColor: Colors.black54,
          content: Text(
            onError.toString(),
            style: TextStyle(
                color: Colors.white,
                fontFamily: "Helvetica",
                fontWeight: FontWeight.w200),
          ),
        );
        scaffoldkey.currentState.showSnackBar(snackbar);
      });
      AuthCredential credential = GoogleAuthProvider.getCredential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);
      AuthResult result =
          (await _auth.signInWithCredential(credential).catchError((onError) {
        Navigator.pop(context);
        final snackbar = SnackBar(
          backgroundColor: Colors.black54,
          content: Text(
            onError.toString(),
            style: TextStyle(
                color: Colors.white,
                fontFamily: "Helvetica",
                fontWeight: FontWeight.w200),
          ),
        );
        scaffoldkey.currentState.showSnackBar(snackbar);
      }));
      FirebaseUser _user = result.user;
      checkuserfromfirestore(_user);
    } on PlatformException catch (e) {
      Navigator.pop(context);
      final snackbar = SnackBar(
        backgroundColor: Colors.black54,
        content: Text(
          e.message,
          style: TextStyle(
              color: Colors.white,
              fontFamily: "Helvetica",
              fontWeight: FontWeight.w200),
        ),
      );
      scaffoldkey.currentState.showSnackBar(snackbar);
    }
  }

  checkuserfromfirestore(FirebaseUser user) async {
    QuerySnapshot result =
        await usersref.where("email", isEqualTo: user.email).getDocuments();
    final List<DocumentSnapshot> docs = result.documents;
    if (docs.length == 0) {
      usersref.document(user.uid).setData({
        "id": user.uid,
        "profilename": user.displayName,
        "url": user.photoUrl,
        "email": user.email,
        "phonenumber": "",
        "isphoneverified": false,
        "timestamp": time
      });
      Navigator.pop(context);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("uid", user.uid);
      await prefs.setInt("initScreen", 2);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) =>
              PhoneVerificationScreen(user: user)));
    } else {
      Navigator.pop(context);
      final snackbar = SnackBar(
        backgroundColor: Colors.black54,
        content: Text(
          "Welcome Back! Let's connect ",
          style: TextStyle(
              color: Colors.white,
              fontFamily: "Helvetica",
              fontWeight: FontWeight.w200),
        ),
      );
      scaffoldkey.currentState.showSnackBar(snackbar);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt("initScreen", 3);
      await prefs.setString("uid", user.uid);
      Future.delayed(const Duration(milliseconds: 1000), () {
        setState(() {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => Welcomescreen()));
        });
      });
    }
  }




  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment:Alignment.topLeft,
      margin: EdgeInsets.only(left: 10.0),
      child: FlatButton(
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => Emailverification())),
        child: Text(
          'Forgot Password?',
          style: TextStyle(
              fontFamily: "Helvetica",
              fontWeight: FontWeight.w200,
              fontSize: 16.0,
              color: Colors.grey),
        ),
      ),
    );
  }


  checkuser(FirebaseUser user) async {
    QuerySnapshot result =
        await usersref.where("email", isEqualTo: user.email).getDocuments();
    final List<DocumentSnapshot> docs = result.documents;
    if (docs.length == 0) {
      final snackbar = SnackBar(
        backgroundColor: Colors.black54,
        content: Text(
          "New User! Please Signup first",
          style: TextStyle(
              color: Colors.white,
              fontFamily: "Helvetica",
              fontWeight: FontWeight.w200),
        ),
      );
      scaffoldkey.currentState.showSnackBar(snackbar);
      await _auth.signOut();
    } else {
      final snackbar = SnackBar(
        backgroundColor: Colors.black54,
        content: Text(
          "Welcome Back! Let's connect",
          style: TextStyle(
              color: Colors.white,
              fontFamily: "Helvetica",
              fontWeight: FontWeight.w200),
        ),
      );
      await scaffoldkey.currentState.showSnackBar(snackbar);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt("initScreen", 3);
      await prefs.setString("uid", user.uid);
      Future.delayed(const Duration(milliseconds: 1000), () {
        setState(() {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => Welcomescreen()));
        });
      });
    }
  }

  Future<FirebaseUser> login(
      {@required String email, @required String pwd}) async {
    try {
      FirebaseUser user =
          (await _auth.signInWithEmailAndPassword(email: email, password: pwd))
              .user;
      if (user != null) {
        checkuser(user);
      }
    } on PlatformException catch (e) {
      final snackbar = SnackBar(
        backgroundColor: Colors.black54,
        content: Text(
          e.message,
          style: TextStyle(
              color: Colors.white,
              fontFamily: "Helvetica",
              fontWeight: FontWeight.w200),
        ),
      );
      await scaffoldkey.currentState.showSnackBar(snackbar);
    }
  }

  validateandsend() async {
    if (_formKey.currentState.validate()) {
      showAlertDialog(context, "Loging in. Please wait");
      email = emailController.text.trim();
      password = passController.text.trim();
      _formKey.currentState.save();
      await login(email: email, pwd: password);
      Navigator.pop(context);
      FocusScope.of(context).requestFocus(new FocusNode());
      TextEditingController().clear(); //remove focus
    }
  }


  validateandsendsignup() async{
    FocusScope.of(context).unfocus();
    if (_formKey.currentState.validate()) {
      email = emailController.text.trim();
      password = passController.text.trim();
      _formKey.currentState.save();
        showAlertDialog(context,"Creating user.. Please wait");
        await signUp(email: email, pwd: password);
        Navigator.pop(context);
    }
  }
  Future<void> signUp(
      {@required String email, @required String pwd}) async {
    try {
      FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
          email: email, password: pwd))
          .user;
      if (user != null) {
        savedata(user);
      }
    } on PlatformException catch (e) {
      final snackbar = SnackBar(
        backgroundColor: Colors.black54,
        content: Text(
          e.message,
          style: TextStyle(
              color: Colors.white,
              fontFamily: "Helvetica",
              fontWeight: FontWeight.w200),
        ),
      );
      scaffoldkey.currentState.showSnackBar(snackbar);
    }
  }
  savedata(FirebaseUser user) async{
    QuerySnapshot result =
    await usersref.where("email", isEqualTo: user.email).getDocuments();
    final List<DocumentSnapshot> docs = result.documents;
    if (docs.length == 0) {
      usersref.document(user.uid).setData({
        "id": user.uid,
        "profilename": user.displayName,
        "url": user.photoUrl,
        "email": user.email,
        "phonenumber": "",
        "isphoneverified": false,
        "timestamp": time
      });
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) =>
              PhoneVerificationScreen(user: user)));
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("uid",user.uid);
      await prefs.setInt("initScreen", 2);
    } else {
      await _auth.signOut();
      final snackbar = SnackBar(
        backgroundColor: Colors.black45,
        content: Text(
          "Already a user! Please login",
          style: TextStyle(
              color: Colors.white,
              fontFamily: "Helvetica",
              fontWeight: FontWeight.w200),
        ),
      );
      scaffoldkey.currentState.showSnackBar(snackbar);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      resizeToAvoidBottomInset: false,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/log.jpeg"),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: Container(
                color: Colors.black.withOpacity(0.1),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          color: Colors.white54.withOpacity(0.50),
                        ),
                        child: Form(
                          key: _formKey,
                          child: ListView(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            children: <Widget>[
                              SizedBox(
                                height: 4.0,
                              ),
                              TextFormField(
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Helvetica",
                                    fontWeight: FontWeight.w200),
                                controller: emailController,
                                validator: (String email) => emailValidator(email),
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  errorStyle:TextStyle(
                                      color: Colors.red,
                                      letterSpacing: 1.0,
                                      fontFamily: "Helvetica",
                                      fontWeight: FontWeight.w200,
                                      fontSize: 14.0
                                  ),
                                  hintText: "Email",
                                  hintStyle:TextStyle(
                                      color: Colors.black54,
                                      fontFamily: "Helvetica",
                                      fontWeight: FontWeight.w200),
                                  contentPadding: EdgeInsets.all(20),
                                  prefixIcon: Icon(Icons.person_outline,color: Colors.black54,),
                                ),
                              ),
                              Divider(
                                thickness: 3,
                              ),
                              TextFormField(
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Helvetica",
                                    fontWeight: FontWeight.w200),
                                controller: passController,
                                validator: (String password) => pwdValidator(password),
                                obscureText: !_obscureText,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(20),
                                    prefixIcon: Icon(Icons.lock_outline,color: Colors.black54,),
                                    hintText: 'Password',
                                    errorStyle:TextStyle(
                                        color: Colors.red,
                                        letterSpacing: 1.0,
                                        fontFamily: "Helvetica",
                                        fontWeight: FontWeight.w200,
                                        fontSize: 14.0
                                    ),
                                    hintStyle: TextStyle(
                                        color: Colors.black54,
                                        fontFamily: "Helvetica",
                                        fontWeight: FontWeight.w200),
                                    suffixIcon: IconButton(
                                        color: Colors.black,
                                        icon: Icon(_obscureText
                                            ? Icons.visibility
                                            : Icons.visibility_off),
                                        onPressed: () {
                                          _toggle();
                                        })),
                              ),
                              SizedBox(
                                height: 6.0,
                              )
                            ],
                          ),
                        ),
                      ),
                      _buildForgotPasswordBtn(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          RaisedButton(
                            padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 8.0),
                            elevation: 10,
                            splashColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'Login',
                              style: GoogleFonts.playfairDisplay(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: ()=>validateandsend(),
                            color:Color(0xFFfb4545),
                          ),
                          RaisedButton(
                            elevation: 10,
                            padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 8.0),
                            splashColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'Sign Up',
                              style: GoogleFonts.playfairDisplay(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            onPressed:()=>validateandsendsignup(),
                            color:Color(0xFFfb4545),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 4.0,
                      ),
                      Text(
                        '------OR------',
                        style: GoogleFonts.pacifico(
                            fontStyle: FontStyle.italic,
                            fontSize: 12,
                            color: Colors.grey),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      SignInButton(
                        Buttons.Google,
                        text: 'Continue With Google',
                        onPressed:()=> handleSignIn(),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      SizedBox(
                        height: 3.0,
                      ),
                      SignInButton(
                        Buttons.Facebook,
                        text: 'Continue with Facebook',
                        onPressed: ()=>handlefacebooklogin(),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
                )),
          );
  }
}
