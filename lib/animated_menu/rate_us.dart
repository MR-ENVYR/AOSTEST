import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RateUs extends StatefulWidget {
  @override
  _RateUsState createState() => _RateUsState();
}

class _RateUsState extends State<RateUs> {
  int index = 0;
  List<String> reviews = [
    'Very Bad',
    'Bad',
    'Not Too Bad',
    'Good',
    'Very Good',
    'Excellent'
  ];

  List<String> assets = [
    "assets/images/emojis/very_bad.png",
    "assets/images/emojis/bad.png",
    "assets/images/emojis/not_too_bad.png",
    "assets/images/emojis/good.png",
    "assets/images/emojis/very_good.png",
    "assets/images/emojis/excellent.png",
  ];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Container(
      color: Color.fromRGBO(3, 9, 23, 1),
      child: SafeArea(
          child: Scaffold(
        backgroundColor: Color.fromRGBO(3, 9, 23, 1),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color.fromRGBO(3, 9, 23, 1),
          title: Text(
            " Rate Us",
            style: GoogleFonts.amiri(
              letterSpacing: 2,
              fontSize: 30,
              color: Color(0xFFc0a948),
//              fontFamily: "Helvetica",
            ),
          ),
          centerTitle: true,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
//            SizedBox(
//              height: height * 0.005,
//            ),
              Image.asset(
                "assets/images/rate_logo.png",
                color: Colors.white,
                height: 120,
                width: 130,
              ),
              SizedBox(
                height: 1,
              ),

              Text(
                "Please rate your",
//                                  textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "FreigSanPro",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                "experience with our app",
//                                  textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: "FreigSanPro"),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Tell us what do you feel about us, It will help us",
//                                  textAlign: TextAlign.center,
                style: TextStyle(
//                fontSize: 20,
//                fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: "FreigSanPro"),
              ),
              Text(
                "in making better platform",
//                                  textAlign: TextAlign.center,
                style: TextStyle(
//                fontSize: 20,
//                fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: "FreigSanPro"),
              ),
              SizedBox(height: 10),
//              Expanded(
//                child: Image.asset(
//                  assets[index],
//                  fit: BoxFit.cover,
//                ),
//              ),
              SizedBox(
                height: 40,
              ),
              Container(
//              padding: EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ButtonTheme(
                      minWidth: 0.1,
                      child: FlatButton(
                        color: Colors.transparent,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        onPressed: () {
                          setState(() {
//                        HitTestBehavior.translucent;
                            index = 0;
                          });
                          print(index);
                        },
                        child: index < 0
                            ? Container(
                                height: 9,
                                width: 9,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey,
                                ),
//                    child: Container(),
                              )
                            : Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                      ),
                    ),
                    ButtonTheme(
                      minWidth: 0.5,
                      child: FlatButton(
                        color: Colors.transparent,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        onPressed: () {
                          setState(() {
//                        HitTestBehavior.translucent;
                            index = 1;
                          });
                          print(index);
                        },
                        child: index < 1
                            ? Container(
                                height: 9,
                                width: 9,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey,
                                ),
//                    child: Container(),
                              )
                            : Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                      ),
                    ),
                    ButtonTheme(
                      minWidth: 0.5,
                      child: FlatButton(
                        color: Colors.transparent,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        onPressed: () {
                          setState(() {
//                        HitTestBehavior.translucent;
                            index = 2;
                          });
                          print(index);
                        },
                        child: index < 2
                            ? Container(
                                height: 9,
                                width: 9,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey,
                                ),
//                    child: Container(),
                              )
                            : Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                      ),
                    ),
                    ButtonTheme(
                      minWidth: 0.5,
                      child: FlatButton(
                        color: Colors.transparent,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        onPressed: () {
                          setState(() {
//                        HitTestBehavior.translucent;
                            index = 3;
                          });
                          print(index);
                        },
                        child: index < 3
                            ? Container(
                                height: 9,
                                width: 9,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey,
                                ),
//                    child: Container(),
                              )
                            : Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                      ),
                    ),
                    ButtonTheme(
                      minWidth: 0.5,
                      child: FlatButton(
                        color: Colors.transparent,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        onPressed: () {
                          setState(() {
//                        HitTestBehavior.translucent;
                            index = 4;
                          });
                          print(index);
                        },
                        child: index < 4
                            ? Container(
                                height: 9,
                                width: 9,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey,
                                ),
//                    child: Container(),
                              )
                            : Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                      ),
                    ),
                    ButtonTheme(
                      minWidth: 0.5,
                      child: FlatButton(
                        color: Colors.transparent,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        onPressed: () {
                          setState(() {
//                        HitTestBehavior.translucent;
                            index = 5;
                          });
                          print(index);
                        },
                        child: index < 5
                            ? Container(
                                height: 9,
                                width: 9,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey,
                                ),
//                    child: Container(),
                              )
                            : Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(reviews[index],
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: "FreigSanPro")),
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
              onPressed: () {},
              color: Color(0xFFfb4545),
            ),
//              RaisedButton(
//                padding: EdgeInsets.all(15),
//                shape: RoundedRectangleBorder(
//                    borderRadius: BorderRadius.all(Radius.circular(20)),
//                    side: BorderSide(color: Color(0xFFfb4545), width: 3)),
//                color: Color(0xFFfb4545),
//                onPressed: () {
////                FocusScope.of(context).unfocus();
////                if (_key.currentState.validate()) {}
//
////                            Navigator.push(
////                                context,
////                                PageTransition(
////                                    type: PageTransitionType.rightToLeftWithFade,
////                                    child: QueOne()));
//                },
////                        textColor: ,
//                child: Text(
//                  "Send",
//                  style:
//                      TextStyle(fontFamily: "FreigSanPro", color: Colors.white),
//                ),
//              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      )),
    );
  }
}
