import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'firebasemethods.dart';
import 'utils.dart';

class PhoneVerificationScreen extends StatefulWidget {
  FirebaseUser user;
  PhoneVerificationScreen({this.user});

  @override
  _PhoneVerificationScreenState createState() =>
      _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends State<PhoneVerificationScreen> {
  FirebaseAuth auth=FirebaseAuth.instance;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  FocusNode phoneNode = FocusNode();
  FocusNode codeNode = FocusNode();

  FirebaseMethods _methods = FirebaseMethods();
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
              image: AssetImage("assets/images/woman1.jpg"),
              fit: BoxFit.cover,
            ),
          ),
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
                          height: 30,
                        ),
                        Text(
                          'Please verify your Mobile Number',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25.0,
                              fontFamily: "Helvetica",
                              fontWeight: FontWeight.w400),
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
                              hintText: "91",
                              hintStyle: TextStyle(
                                  color: Colors.white30,
                                  fontFamily: "Helvetica",
                                  fontWeight: FontWeight.w200),
                              labelText: "Enter your Country Code",
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
                            hintStyle: TextStyle(
                                color: Colors.white30,
                                fontFamily: "Helvetica",
                                fontWeight: FontWeight.w200),
                            labelText: "Enter your Phone number",
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
                          color: Colors.deepOrange,
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
                              _methods.sendCodeToPhoneNumber(widget.user,
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