import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:style_of_agent/Login.dart';
import 'package:style_of_agent/phoneauthpage.dart';
import 'Splashscreen.dart';
import 'model/usermodel.dart';
import 'styles.dart';
import 'package:fluttertoast/fluttertoast.dart';

final usersref = Firestore.instance.collection("users");
final DateTime time = DateTime.now();
User currentuser;

class Signup extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<Signup> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool _rememberMe = false;
  GoogleSignIn _googleSignIn = new GoogleSignIn();

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'E-mail',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
                color: Colors.black,
                fontFamily: "Helvetica",
                fontWeight: FontWeight.w200),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white24,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.alternate_email,
                color: Colors.white,
              ),
              hintText: 'Enter your Email',
              hintStyle: kHintTextStyle,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white38),
                borderRadius: BorderRadius.circular(15.7),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white38),
                borderRadius: BorderRadius.circular(15.7),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<FirebaseUser> handleSignIn() async {
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    AuthResult result = (await _auth.signInWithCredential(credential));
    FirebaseUser _user = result.user;
    saveusertofirestore(_user);
  }

//  Future<void> gooleSignout() async {
//    Navigator.push(
//        context, MaterialPageRoute(builder: (context) => PhoneVerificationScreen(user:currentuser)));
////    await _auth.signOut().then((onValue) {
////      _googleSignIn.signOut();
////      setState(() {
////        issignin = true;
////      });
////    });
//
//  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            obscureText: true,
            style: TextStyle(
                color: Colors.black,
                fontFamily: "Helvetica",
                fontWeight: FontWeight.w200),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white24,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock_outline,
                color: Colors.white,
              ),
              hintText: 'Enter your Password',
              hintStyle: kHintTextStyle,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white38),
                borderRadius: BorderRadius.circular(15.7),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white38),
                borderRadius: BorderRadius.circular(15.7),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildconfirmPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Confirm password',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            obscureText: true,
            style: TextStyle(
                color: Colors.black,
                fontFamily: "Helvetica",
                fontWeight: FontWeight.w200),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white24,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Confirm your Password',
              hintStyle: kHintTextStyle,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white38),
                borderRadius: BorderRadius.circular(15.7),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white38),
                borderRadius: BorderRadius.circular(15.7),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () => print('Forgot Password Button Pressed'),
        padding: EdgeInsets.only(right: 0.0),
        child: Text(
          'Forgot Password?',
          style: TextStyle(
              fontFamily: "Helvetica",
              fontWeight: FontWeight.w200,
              fontSize: 15.0,
              color: Color(0xFFc0a948)),
        ),
      ),
    );
  }

  saveusertofirestore(FirebaseUser user) async {
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
      await prefs.setInt("initScreen", 2);
      print('initScreen ${initScreen}');
    }
    else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) =>
              LoginScreen()));

      await _auth.signOut().then((onValue) {
        _googleSignIn.signOut();
      });
      Fluttertoast.showToast(
          msg: "Already a user ! Login",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black45,
          textColor: Colors.white,
          fontSize: 16.0);
    }

    //currentuser=User.fromDocument(documentSnapshot);
  }

  Widget _buildRememberMeCheckbox() {
    return Container(
      height: 20.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.black),
            child: Checkbox(
              value: _rememberMe,
              checkColor: Color(0xFFc0a948),
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value;
                });
              },
            ),
          ),
          Text('Remember me',
              style: TextStyle(
                  fontFamily: "Helvetica",
                  fontWeight: FontWeight.w200,
                  color: Color(0xFFc0a948))),
        ],
      ),
    );
  }

  Widget _buildSignupBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () => handleSignIn(),
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Colors.deepOrange,
        child: Text(
          'SIGN UP',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.0,
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            fontFamily: "Playfairdisplay",
          ),
        ),
      ),
    );
  }

  Widget _buildSignInWithText() {
    return Column(
      children: <Widget>[
        Text(
          '- OR -',
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Helvetica",
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 15.0),
        Text(
          'Signup with',
          style: TextStyle(
              color: Colors.white,
              fontFamily: "Helvetica",
              fontWeight: FontWeight.w200),
        ),
      ],
    );
  }

  Widget _buildSocialBtn(Function onTap, AssetImage logo) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40.0,
        width: 40.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
          image: DecorationImage(
            image: logo,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialBtnRow() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildSocialBtn(
            () => print('Signup with Facebook'),
            AssetImage(
              'assets/images/facebook.jpg',
            ),
          ),
          _buildSocialBtn(
            () => handleSignIn(),
            AssetImage(
              'assets/images/google.jpg',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildloginBtn() {
    return GestureDetector(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen())),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Already have an account? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10.0,
                fontFamily: "Helvetica",
                fontWeight: FontWeight.w200,
              ),
            ),
            TextSpan(
              text: ' Login',
              style: TextStyle(
                fontFamily: "Playfairdisplay",
                color: Colors.deepOrange,
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.dark,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.black, Colors.black],
                    begin: FractionalOffset(0, 0),
                    end: FractionalOffset(0, 1),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
                image: DecorationImage(
                  image: AssetImage("assets/images/glitterwomen.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: <Widget>[
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                  ),
                  Container(
                    height: double.infinity,
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        horizontal: 30.0,
                        vertical: 40.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Sign up',
                            style: TextStyle(
                              letterSpacing: 2.0,
                              color: Color(0xFFe5cf73),
                              fontFamily: "Playfairdisplay",
                              fontSize: 40.0,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(height: 20.0),
                          _buildEmailTF(),
                          SizedBox(
                            height: 20.0,
                          ),
                          _buildPasswordTF(),
                          SizedBox(
                            height: 20.0,
                          ),
                          _buildconfirmPasswordTF(),
                          SizedBox(
                            height: 20.0,
                          ),
                          //_buildForgotPasswordBtn(),
                          _buildRememberMeCheckbox(),
                          _buildSignupBtn(),
                          _buildSignInWithText(),
                          _buildSocialBtnRow(),
                          SizedBox(
                            height: 5.0,
                          ),
                          _buildloginBtn(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )));
  }
}
