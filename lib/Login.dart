import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:style_of_agent/Signup.dart';
import 'package:style_of_agent/utils.dart';
import 'package:style_of_agent/welcomescreen.dart';
import 'model/usermodel.dart';
import 'styles.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText=true;
  FirebaseAuth _auth = FirebaseAuth.instance;
  final usersref = Firestore.instance.collection("users");
  final DateTime time = DateTime.now();
  User currentuser;
  bool _rememberMe = false;
  GoogleSignIn _googleSignIn = new GoogleSignIn();
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

  Future<FirebaseUser> handleSignIn() async {
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    AuthResult result = (await _auth.signInWithCredential(credential));
    FirebaseUser _user = result.user;
    checkuserfromfirestore(_user);
  }

  checkuserfromfirestore(FirebaseUser user) async {
    QuerySnapshot result =
        await usersref.where("email", isEqualTo: user.email).getDocuments();
    final List<DocumentSnapshot> docs = result.documents;
    if (docs.length == 0) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Signup()));
      await _auth.signOut().then((onValue) {
        _googleSignIn.signOut();
      });
      Fluttertoast.showToast(
          msg: "New user ! Please Signup first",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black45,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: " Welcome Back !",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black45,
          textColor: Colors.white,
          fontSize: 16.0);

      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => Welcomescreen()));
    }
  }

  Widget _buildEmailTF() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
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
              contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              errorStyle: TextStyle(
                  color: Colors.deepOrange,
                  fontFamily: "Helvetica",
                  fontWeight: FontWeight.w200),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(12.3),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(12.3),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white38),
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
          child: TextFormField(
            controller: passController,
            validator: (String phone) => pwdValidator(phone),
            obscureText: _obscureText,
            style: TextStyle(
                color: Colors.white,
                fontFamily: "Helvetica",
                fontWeight: FontWeight.w200),
            decoration: InputDecoration(
              errorStyle: TextStyle(
                  color: Colors.deepOrange,
                  fontFamily: "Helvetica",
                  fontWeight: FontWeight.w200),
              suffixIcon: IconButton(
                icon:Icon(_obscureText?Icons.visibility:Icons.visibility_off),
                onPressed:_toggle,
                color: Colors.white38,
                focusColor: Colors.white70,
              ),
              filled: true,
              fillColor: Colors.white24,
              contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              prefixIcon: Icon(
                Icons.lock_outline,
                color: Colors.white,
              ),
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
              color: Colors.deepOrange),
        ),
      ),
    );
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
              checkColor: Colors.deepOrange,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value;
                });
              },
            ),
          ),
//          Text(
//            'Remember me',
//            style: TextStyle(
//              color: Color(0xFFc0a948)
//            )
//          ),
        ],
      ),
    );
  }
  checkuser(FirebaseUser user)async{
    QuerySnapshot result =
    await usersref.where("email", isEqualTo: user.email).getDocuments();
    final List<DocumentSnapshot> docs = result.documents;
    if (docs.length == 0) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Signup()));
      await _auth.signOut();
      final snackbar = SnackBar(
        backgroundColor: Colors.black54,
        content: Text("New User! Please Signup first",style: TextStyle(
            color: Colors.white,
            fontFamily: "Helvetica",
            fontWeight: FontWeight.w200),),
      );
      scaffoldkey.currentState.showSnackBar(snackbar);
    } else {
      final snackbar = SnackBar(
        backgroundColor: Colors.black54,
        content: Text("Welcome Back! Let's connect",style: TextStyle(
            color: Colors.white,
            fontFamily: "Helvetica",
            fontWeight: FontWeight.w200),),
      );
      scaffoldkey.currentState.showSnackBar(snackbar);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt("initScreen", 3);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => Welcomescreen()));
    }
  }

  Future<FirebaseUser> login(
      {@required String email, @required String pwd}) async {
    try {
      FirebaseUser user = (await _auth.signInWithEmailAndPassword(
          email: email, password: pwd))
          .user;
      if(user!=null){
        checkuser(user);
      }

    } on PlatformException catch (e) {
      final snackbar = SnackBar(
        backgroundColor: Colors.black54,
        content: Text(e.message,style: TextStyle(
            color: Colors.white,
            fontFamily: "Helvetica",
            fontWeight: FontWeight.w200),),
      );
      scaffoldkey.currentState.showSnackBar(snackbar);
    }
  }

  validateandsend() async{
    if (_formKey.currentState.validate()) {
      email = emailController.text.trim();
      password=passController.text.trim();
      _formKey.currentState.save();
      await login(email: email, pwd: password);





    }
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 10.0,
        onPressed: () => validateandsend(),
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Colors.deepOrange,
        child: Text(
          'LOG IN',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.0,
            fontSize: 22.0,
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
          'Login with',
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
            () => print('Login with Facebook'),
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

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => Signup())),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t have an Account? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 13.0,
                fontFamily: "Helvetica",
                fontWeight: FontWeight.w200,
              ),
            ),
            TextSpan(
              text: ' Sign Up',
              style: TextStyle(
                fontFamily: "Helvetica",
                color: Colors.deepOrange,
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
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
                      vertical: 50.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Log in',
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
                                height: 30.0,
                              ),
                              _buildPasswordTF(),
                            ],
                          ),
                        ),
                        _buildForgotPasswordBtn(),
//                      _buildRememberMeCheckbox(),
                        _buildLoginBtn(),
                        _buildSignInWithText(),
                        _buildSocialBtnRow(),
                        SizedBox(
                          height: 5.0,
                        ),
                        _buildSignupBtn(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
