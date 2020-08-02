import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:style_of_agent/Login.dart';
import 'package:style_of_agent/progress.dart';
import 'package:style_of_agent/welcomescreen.dart';
import 'utils.dart';

class PhoneVerificationScreen extends StatefulWidget {
  FirebaseUser user;
  PhoneVerificationScreen({this.user});

  @override
  _PhoneVerificationScreenState createState() =>
      _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends State<PhoneVerificationScreen> {
  String uid;
  FirebaseAuth auth=FirebaseAuth.instance;
  GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  FocusNode phoneNode = FocusNode();
  FocusNode codeNode = FocusNode();

  @override
  void initState() {
    super.initState();
    if(widget.user==null){
      getuid();
    }
    else{
        uid=widget.user.uid;
    }
  }

  Future<void>getuid() async {
    await Future.delayed(Duration(milliseconds: 2000), () {});
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String currentuseruid = await prefs.getString("uid");
    if(currentuseruid==null){
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => LoginScreen()));
    }
    else{
      uid=currentuseruid;
    }
  }


  sendCodeToPhoneNumber({@required String phonenumber,BuildContext context}) {
    PHONE_NO = phonenumber;
    auth.verifyPhoneNumber(
        phoneNumber: phonenumber,
        timeout: Duration(seconds: 6),
        verificationCompleted: (AuthCredential authCredentials) {
        },
        verificationFailed: (AuthException authException) {
          showToast(msg: authException.message);
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          TextEditingController smsController = TextEditingController();
          GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
                  key: formKey,
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
                    color:Color(0xFFfb4545),
                    child: Text(
                      "Done",
                      style: TextStyle(
                          color:Colors.white,
                          fontFamily: "Helvetica",
                          fontSize: 10.0,
                          fontWeight: FontWeight.w200),
                    ),
                    onPressed: () async {
                      showAlertDialog(context,"Please wait..");
                      FocusScope.of(context).unfocus();
                      if (_formKey.currentState.validate()) {
                        String sms = smsController.text.trim();
                        AuthCredential _credentials;
                        _credentials = PhoneAuthProvider.getCredential(
                            verificationId: verificationId, smsCode: sms);
                        auth
                            .signInWithCredential(_credentials)
                            .then((AuthResult result) async {
                          if (result.user != null) {
                            Navigator.pop(context);
                            final snackbar = SnackBar(
                              backgroundColor: Colors.black54,
                              content: Text("Congrats! Your Phone number is verified ",style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Helvetica",
                                  fontWeight: FontWeight.w200),),
                            );
                            scaffoldkey.currentState.showSnackBar(snackbar);
                            await usersref.document(uid).updateData({
                              "phonenumber":phonenumber,
                              "isphoneverified":true
                            });
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            await prefs.setInt("initScreen",3);
                            Future.delayed(const Duration(milliseconds: 1000), () {
                              setState(() {
                                Navigator.of(context).pushReplacement(MaterialPageRoute(
                                    builder: (BuildContext context) => Welcomescreen()));
                              });
                            });
                          } else {
                            Navigator.pop(context);
                            final snackbar = SnackBar(
                              backgroundColor: Colors.black54,
                              content: Text("Your Phone number is not verified ",style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Helvetica",
                                  fontWeight: FontWeight.w200),),
                            );
                            scaffoldkey.currentState.showSnackBar(snackbar);
                          }
                        }).catchError((onError) {
                          Navigator.pop(context);
                          final snackbar = SnackBar(
                            backgroundColor: Colors.black54,
                            content: Text(onError.toString(),style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Helvetica",
                                fontWeight: FontWeight.w200),),
                          );
                          scaffoldkey.currentState.showSnackBar(snackbar);
                        });
                      }
                    },
                  )
                ],
              ));
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          verificationId = verificationId;
        });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff030b2f),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.only(top: 10.0),
          child:  RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: "AGENTS OF\n",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      letterSpacing: 3,
                    )),
                TextSpan(
                    text: "STYLE",
                    style: TextStyle(
                        letterSpacing: 3,
                        fontSize: 30,
                        fontWeight: FontWeight.w200,
                        color: Color(0xFFc0a948),
                        fontFamily: "Playfairdisplay"))
              ])),
        ),
        centerTitle: true,
      ),
      key: scaffoldkey,
      resizeToAvoidBottomInset: false,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Container(
            child: Stack(
              children: <Widget>[
                Container(
                  height: double.infinity,
                  width: double.infinity,
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      children: <Widget>[
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Phone Verification',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.0,
                              fontFamily: "Playfairdisplay",
                              fontWeight: FontWeight.w200),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: codeController,
                          focusNode: codeNode,
                          validator: (String code) => codeValidation(code),
                          cursorColor: Colors.white,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(phoneNode);
                          },
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Helvetica",
                              fontWeight: FontWeight.w200),
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.outlined_flag,color: Colors.white,),
                              hintText: "91",
                              hintStyle: TextStyle(
                                  color: Colors.white54,
                                  fontFamily: "Helvetica",
                                  fontWeight: FontWeight.w200),
                              labelText: "Country Code",
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
                              fillColor: Colors.white12),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: phoneController,
                          focusNode: phoneNode,
                          validator: (String phone) => phoneValidation(phone),
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
                            prefixIcon: Icon(Icons.perm_phone_msg,color: Colors.white,),
                            hintStyle: TextStyle(
                                color: Colors.white54,
                                fontFamily: "Helvetica",
                                fontWeight: FontWeight.w200),
                            labelText: "Phone number",
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
                          height: 20,
                        ),
                        FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color:Color(0xFFfb4545),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Text(
                              'Send Code',
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
                              phoneController.text = phoneController.text.trim();
                              codeController.text = codeController.text.trim();
                              print(phoneController.text + " " + codeController.text);
                              String phoneNumber = "+" +
                                  codeController.text.trim() +
                                  phoneController.text.trim();
                               sendCodeToPhoneNumber(
                                  phonenumber: phoneNumber, context: context);
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