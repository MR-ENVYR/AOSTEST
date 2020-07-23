import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:style_of_agent/Login.dart';
import 'package:style_of_agent/phoneauthpage.dart';
import 'package:style_of_agent/utils.dart';
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
  bool _obscureText = true;
  GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmpassController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;
  bool _rememberMe = false;
  GoogleSignIn _googleSignIn = new GoogleSignIn();
  String email;
  String password;
  String confirmpassword;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

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
         // height: 60.0,
          child: TextFormField(
            controller: emailController,
            validator: (String email) => emailValidator(email),
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
                color: Colors.white,
                fontFamily: "Helvetica",
                fontWeight: FontWeight.w200),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white24,
              hintText: 'Enter your email',
              hintStyle: kHintTextStyle,
              contentPadding:
              EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              errorStyle: TextStyle(
                  color: Colors.deepOrange,
                  fontFamily: "Helvetica",
                  fontWeight: FontWeight.w200),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.deepOrange),
                borderRadius: BorderRadius.circular(12.3),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.deepOrange),
                borderRadius: BorderRadius.circular(12.3),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(12.3),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white38),
                borderRadius: BorderRadius.circular(12.3),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white38),
                borderRadius: BorderRadius.circular(12.3),
              ),
            ),
          ),
        ),
      ],
    );
  }
  Future<FirebaseUser> signUp(
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
      await prefs.setInt("initScreen", 2);
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
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


  Future<FirebaseUser> handleSignIn() async {
    try{
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
    on PlatformException catch (e) {
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

  Widget _buildPasswordTF() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
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
         // height: 60.0,
          child: TextFormField(
            textAlignVertical: TextAlignVertical.center,
            textAlign: TextAlign.left,
            controller: passController,
            validator: (String phone) => pwdValidator(phone),
            obscureText: _obscureText,
            style: TextStyle(
                color: Colors.white,
                fontFamily: "Helvetica",
                fontWeight: FontWeight.w200),
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off),
                onPressed:_toggle,
                color: Colors.white38,
                focusColor: Colors.white70,
              ),
              filled: true,
              fillColor: Colors.white24,
              contentPadding:
              EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              prefixIcon: Icon(
                Icons.lock_outline,
                color: Colors.white,
              ),
              errorStyle: TextStyle(
                  color: Colors.deepOrange,
                  fontFamily: "Helvetica",
                  fontWeight: FontWeight.w200),
              hintText: 'Enter your Password',
              hintStyle: kHintTextStyle,
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(12.3),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(12.3),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(12.3),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white38),
                borderRadius: BorderRadius.circular(12.3),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white38),
                borderRadius: BorderRadius.circular(12.3),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildconfirmPasswordTF() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
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
//          height: 60.0,
          child: TextFormField(
            textAlignVertical: TextAlignVertical.center,
            textAlign: TextAlign.left,
            controller: confirmpassController,
            validator: (String phone) => pwdValidator(phone),
            obscureText: _obscureText,
            style: TextStyle(
                color: Colors.white,
                fontFamily: "Helvetica",
                fontWeight: FontWeight.w200),
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon:Icon(_obscureText?Icons.visibility:Icons.visibility_off),
                onPressed: ()=> _toggle,
                color: Colors.white38,
                focusColor: Colors.white70,
              ),
              errorStyle: TextStyle(
                  color: Colors.deepOrange,
                  fontFamily: "Helvetica",
                  fontWeight: FontWeight.w200),
              filled: true,
              fillColor: Colors.white24,
              contentPadding:
              EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
             // contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock_outline,
                color: Colors.white,
              ),
              hintText: 'Enter your Password',
              hintStyle: kHintTextStyle,
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.deepOrange),
                borderRadius: BorderRadius.circular(12.3),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.deepOrange),
                borderRadius: BorderRadius.circular(12.3),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(12.3),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white38),
                borderRadius: BorderRadius.circular(12.3),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white38),
                borderRadius: BorderRadius.circular(12.3),
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
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));

      await _auth.signOut().then((onValue) {
        _googleSignIn.signOut();
      });
      final snackbar = SnackBar(
        backgroundColor: Colors.black54,
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

  Widget _buildRememberMeCheckbox() {
    return Container(
      height: 20.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.black),
            child: Checkbox(
              value: _rememberMe,
              checkColor: (Colors.deepOrange),
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

  validateandsend() {
    if (_formKey.currentState.validate()) {
      email = emailController.text.trim();
      password = passController.text.trim();
      confirmpassword = confirmpassController.text.trim();
      _formKey.currentState.save();
      if(password==confirmpassword){
        signUp(email: email, pwd: password);
      }
      else{
        final snackbar = SnackBar(
        backgroundColor: Colors.black54,
        content: Text(
          "Password does not match",
          style: TextStyle(
              color: Colors.white,
              fontFamily: "Helvetica",
              fontWeight: FontWeight.w200),
        ),
      );
      scaffoldkey.currentState.showSnackBar(snackbar);
      }

    }
  }

  Widget _buildSignupBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () => validateandsend(),
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
        key: scaffoldkey,
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
                              color: Colors.white,
                              fontFamily: "Playfairdisplay",
                              fontSize: 40.0,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Form(
                            key: _formKey,
                            child: ListView(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              children: <Widget>[
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
                              ],
                            ),
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
