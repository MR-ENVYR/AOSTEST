import 'package:google_fonts/google_fonts.dart';
import 'package:style_of_agent/connection.dart';
import 'package:style_of_agent/progress.dart';
import 'package:style_of_agent/utils/utils.dart';
import 'package:flutter/material.dart';

//import '../progress.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  GlobalKey<FormState> _key = new GlobalKey<FormState>();
  TextEditingController subjectController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  FocusNode subjectNode = FocusNode();
  FocusNode emailNode = FocusNode();
  FocusNode descriptionNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    checkConnection(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffe1f3ff),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Color.fromRGBO(3, 9, 23, 1),
          resizeToAvoidBottomPadding: true,
//          resizeToAvoidBottomInset: fa,
          primary: false,
          appBar: AppBar(
            elevation: 0,

            backgroundColor: Color(0xffe1f3ff),
            title: Align(
              alignment: Alignment.topCenter,
              child: Text(
                "Contact Us",
                style: GoogleFonts.amiri(
                  letterSpacing: 2,
                  fontSize: 30,
                  color: Color(0xFFE5CF73),
//                  fontFamily: "Helvetica",
                ),
              ),
            ),
//
//          bottom: PreferredSize(
//              child: Container(
//                height: 250,
//                child: Stack(children: <Widget>[
//                  ClipPath(
//                      clipBehavior: Clip.hardEdge,
//                      c1lipper: TopHeader(),
//                      child: Container(
//                        color: Color(0xffe1f3ff),
//                      )),
//                ]),
//              ),
//              preferredSize: Size(MediaQuery.of(context).size.width, 250)),
          ),
          body: SafeArea(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 330,
                      child: Stack(
                        children: <Widget>[
                          ClipPath(
                              clipBehavior: Clip.hardEdge,
                              clipper: TopHeader(),
                              child: Container(
                                color: Color(0xffe1f3ff),
                              )),
                          Align(
                              alignment: Alignment.topCenter,
//                right: 13,
//                bottom: 10,
//                              top: -40.5,
//                left: 50,
                              child: Image.asset(
                                "assets/images/logos/logonew.png",
//                                height: 210,
//                                width: 300,
                                scale: 3.5,
                              )),
                          Align(
//                          alignment: Alignment.topLeft,
                            child: Container(
//
//                            color: Colors.pink,
                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      "How can we help you?",
//                                  textAlign: TextAlign.center,
                                      style: headlineStyle,
                                    ),
//                                    SizedBox(
//                                      height: 15,
//                                    ),
//                                    Text(
//                                        "It looks like you have problems with our system.",
////                                    textAlign: TextAlign.center,
//                                        style: TextStyle(
//                                            color: Color(0xFFE5CF73))),
//                                    Text("We are here to help you, so please",
////                                    textAlign: TextAlign.center,
//                                        style: TextStyle(
//                                            color: Color(0xFFE5CF73))),
//                                    Text("get in touch with us",
////                                    textAlign: TextAlign.center,
//                                        style: TextStyle(
//                                            color: Color(0xFFE5CF73))),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Form(
                        key: _key,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                autofocus: false,
                                controller: subjectController,
                                cursorColor: Colors.grey,
                                validator: (String val) {
                                  val = val.trim();
                                  if (val.isEmpty) {
                                    return "Enter subject";
                                  }
                                  return null;
                                },
                                focusNode: subjectNode,
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context)
                                      .requestFocus(emailNode);
                                },
                                textInputAction: TextInputAction.next,
                                style: inputStyle,
                                decoration: InputDecoration(
//                            focusedErrorBorder: errorBorder,
                                    border: OutlineInputBorder(
                                        gapPadding: 0.5,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide: BorderSide(
                                            color: Color(0xFFE5CF73),
                                            width: 2)),
                                    hintText: 'Subject',
                                    hintStyle: inputStyle,
                                    errorBorder: OutlineInputBorder(
                                        gapPadding: 0.5,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide: BorderSide(
                                            color: Colors.redAccent, width: 2)),
                                    enabledBorder: OutlineInputBorder(
                                        gapPadding: 0.5,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide: BorderSide(
                                            color: Color(0xFFE5CF73),
                                            width: 2)),
                                    enabled: true,
                                    focusedBorder: OutlineInputBorder(
                                        gapPadding: 0.5,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide: BorderSide(
                                            color: Color(0xFFE5CF73),
                                            width: 2)),
                                    focusColor: Color(0xFFffffff),
                                    filled: true,
                                    fillColor: Color(0xff1e1b24),
                                    errorStyle: errorStyle),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                autofocus: false,
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                cursorColor: Colors.grey,
                                validator: (String val) {
                                  val = val.trim();
                                  if (val.isEmpty) {
                                    return "Enter email";
                                  }
                                  return null;
                                },
                                focusNode: emailNode,
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context)
                                      .requestFocus(descriptionNode);
                                },
                                textInputAction: TextInputAction.next,
                                style: inputStyle,
                                decoration: InputDecoration(
//                            focusedErrorBorder: errorBorder,
                                    border: OutlineInputBorder(
                                        gapPadding: 0.5,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide: BorderSide(
                                            color: Color(0xFFE5CF73),
                                            width: 2)),
                                    hintText: 'Email',
                                    hintStyle: inputStyle,
                                    errorBorder: OutlineInputBorder(
                                        gapPadding: 0.5,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide: BorderSide(
                                            color: Colors.redAccent, width: 2)),
                                    enabledBorder: OutlineInputBorder(
                                        gapPadding: 0.5,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide: BorderSide(
                                            color: Color(0xFFE5CF73),
                                            width: 2)),
                                    enabled: true,
                                    focusedBorder: OutlineInputBorder(
                                        gapPadding: 0.5,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide: BorderSide(
                                            color: Color(0xFFE5CF73),
                                            width: 2)),
                                    focusColor: Color(0xFFffffff),
                                    filled: true,
                                    fillColor: Color(0xff1e1b24),
                                    errorStyle: errorStyle),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                autofocus: false,
                                maxLines: 5,
                                controller: descriptionController,
                                cursorColor: Colors.grey,
                                validator: (String val) {
                                  val = val.trim();
                                  if (val.isEmpty) {
                                    return "Enter description";
                                  }
                                  return null;
                                },
//                        focusNode: subjectNode,
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context).unfocus();
                                },
                                textInputAction: TextInputAction.done,
                                style: inputStyle,
                                decoration: InputDecoration(
//                            focusedErrorBorder: errorBorder,
                                    border: OutlineInputBorder(
                                        gapPadding: 0.5,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide: BorderSide(
                                            color: Color(0xFFE5CF73),
                                            width: 2)),
                                    hintText: 'Type the message...',
                                    hintStyle: inputStyle,
                                    errorBorder: OutlineInputBorder(
                                        gapPadding: 0.5,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide: BorderSide(
                                            color: Colors.redAccent, width: 2)),
                                    enabledBorder: OutlineInputBorder(
                                        gapPadding: 0.5,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide: BorderSide(
                                            color: Color(0xFFE5CF73),
                                            width: 2)),
                                    enabled: true,
                                    focusedBorder: OutlineInputBorder(
                                        gapPadding: 0.5,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide: BorderSide(
                                            color: Color(0xFFE5CF73),
                                            width: 2)),
                                    focusColor: Color(0xFFffffff),
                                    filled: true,
                                    fillColor: Color(0xff1e1b24),
                                    errorStyle: errorStyle),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              RaisedButton(
                                elevation: 10,
                                padding: EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 8.0),
                                splashColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  'Send',
                                  style: GoogleFonts.amiri(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
//                                padding: EdgeInsets.all(15),
//                                shape: RoundedRectangleBorder(
////                                  borderRadius:
////                                      BorderRadius.all(Radius.circular(20)),
//                                    side: BorderSide(
//                                        color: Color(0xFFfb4545), width: 3)),
                                color: Color(0xFFfb4545),
                                onPressed: () {
                                  FocusScope.of(context).unfocus();
                                  if (_key.currentState.validate()) {
                                    checkConnection(context);
                                    setState(() {
                                      descriptionController.text = '';
                                      emailController.text = '';
                                      subjectController.text = '';
                                    });
                                    showSendDialog(context, "Infomation Sent");
                                    Future.delayed(Duration(milliseconds: 800),
                                        () {
                                      setState(() {
                                        Navigator.pop(context);
                                      });
                                    });
                                  }

//                            Navigator.push(
//                                context,
//                                PageTransition(
//                                    type: PageTransitionType.rightToLeftWithFade,
//                                    child: QueOne()));
                                },
//                        textColor: ,
//                                child: Text(
//                                  "Send",
//                                  style: TextStyle(
//                                      fontSize: 15,
//                                      fontFamily: "FreigSanPro",
//                                      color: Colors.white),
//                                ),
                              ),
                              SizedBox(
                                height: 10,
                              )
                            ],
                          ),
                        ))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TopHeader extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    var path = Path()
      ..lineTo(0.0, 250)
      ..quadraticBezierTo(0.6 * size.width / 6, 202, size.width / 3, 203)
//      ..quadraticBezierTo(size.width / 2, 222, 3.45 * size.width / 6, 170)
      ..quadraticBezierTo(5 * size.width / 6, 182, size.width, 250)
      ..lineTo(size.width, 0.0)
      ..close();
//    throw UnimplementedError();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
