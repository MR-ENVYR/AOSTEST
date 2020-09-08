import 'package:style_of_agent/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  List<String> labels = [
    "Select your favorite store",
    "Select your favorite stylist",
    "Clothing delivery"
  ];

  List<String> desc = [
    "Select your favorite local store and start shopping from the comfort of your home.",
    "Get matched with one of the stylist from your favourite local store and start your styling session.",
    "Pick up your outfit from your local store or get it delivered to your house via your local store"
  ];

  List<String> assets = [
    "assets/images/logos/stores.svg",
    "assets/images/logos/select.svg",
    "assets/images/logos/delivary.svg",
  ];

  var h;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    setState(() {
//      h = Image.asset("assets/images/logos/kk.jpg").height;
//    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

//    print(h);
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Color.fromRGBO(3, 9, 23, 1),
//              borderRadius: BorderRadius.circular(40.0),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color.fromRGBO(3, 9, 23, 1),
          title: Text(
            " About Us",
            style: GoogleFonts.amiri(
              letterSpacing: 2,
              fontSize: 30,
              color: Color(0xFFE5CF73),
//              fontFamily: "Helvetica",
            ),
          ),
          centerTitle: true,
        ),
//        appBar: PreferredSize(
//            child: Container(
//              height: height / 2,
//              width: width,
//              decoration: BoxDecoration(
//                  image: DecorationImage(
//                      image: AssetImage(
//                        "assets/images/logos/kk.jpg",
//                      ),
//                      fit: BoxFit.fill)),
////              alignment: Alignment.center + Alignment(0, 1),
//              padding: EdgeInsets.only(
//                top: height * 0.15,
////                left: height * 0.05,
//              ),
//              child: Column(
////                mainAxisAlignment: MainAxisAlignment.center,
//                crossAxisAlignment: CrossAxisAlignment.center,
//                children: <Widget>[
//                  Text(
//                    "About Us",
//                    style: GoogleFonts.amiri(
//                      letterSpacing: 2,
//                      fontSize: 40,
//                      color: Color(0xFFE5CF73),
////                      fontFamily: "Helvetica",
//                    ),
//                  )
//                ],
//              ),
//            ),
//            preferredSize: Size(width, height / 2)),
        resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: true,
        body: Container(
          height: height,
          width: width,

//            padding: EdgeInsets.all(40),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text(
                        ''' 
Everyday women spent a lot of time on what to wear today. It is our mission to connect customers with online stylists. To bring real time advice from fashion enthusiasts and professionals to everybody. We are a fashion tech company located in the Netherlands and we love to bring a smile on your face with fashion. 

Warm regards ,

The team from Agents of Style 


''',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: "FreigSanPro"),
                      ),
                      Align(
                        alignment: Alignment.topCenter,

//                right: 13,
//                bottom: 10,
//                top: -40.5,
//                left: 50,
                        child: SvgPicture.asset(
                          "assets/images/aoslogo.svg",
//                            height: 50,
//              width: 10,
                        ),
                      ),
                    ],
                  ),
                )
//                Text(
//                  "How does it work?",
//                  textAlign: TextAlign.center,
//                  style: headlineStyle,
//                ),
//                SizedBox(
//                  height: height * 0.03,
//                ),
//                CarouselSlider.builder(
//                    itemCount: 3,
//                    itemBuilder: (context, i) {
//                      return Container(
////                  height: 500,
////                  width: 500,
//                        child: Stack(
//                          fit: StackFit.loose,
//                          children: <Widget>[
//                            Card(
////                        color: Colors.white,
//
//                              child: Container(
//                                height: 200,
//
//                                color: Colors.white,
//                                width: 300,
////                          padding: EdgeInsets.all(8),
////                          margin: EdgeInsets.all(10),
////padding: EdgeInsets.only(left: ),
////                          alignment: ,
////                                child: ,
//                              ),
////                        margin:
////                            EdgeInsets.only(left: 20, bottom: 10, right: 10),
//                            ),
//                            Positioned(
//                              top: 20,
//                              left: -2,
//                              child: Container(
//                                child: SvgPicture.asset(
//                                  assets[i],
//                                  fit: BoxFit.fill,
////                        width: 100,
//                                ),
//                                height: 190,
//                                width: 150,
//                              ),
//                            ),
//                            Padding(
//                              padding: EdgeInsets.only(
//                                  left: (width) / 2.4, right: 10, top: 20),
//                              child: Column(
//                                mainAxisAlignment: MainAxisAlignment.start,
////                                crossAxisAlignment: CrossAxisAlignment.center,
//                                children: <Widget>[
////                                  SizedBox(height: 20),
//                                  Text(
//                                    labels[i],
//                                    style: GoogleFonts.amiri(
//                                        color: Color(0xFFE5CF73),
//                                        height: 1.2,
//
////                                            fontFamily: "Helvetica",
//                                        fontWeight: FontWeight.bold,
//                                        fontSize: 20),
//                                    textAlign: TextAlign.center,
//                                  ),
//                                  SizedBox(
//                                    height: 10,
//                                  ),
//                                  Text(
//                                    desc[i],
//                                    textAlign: TextAlign.justify,
//                                    style: TextStyle(
//                                        color: Colors.black,
//                                        fontFamily: "FreigSanPro",
//                                        fontWeight: FontWeight.w500,
//                                        fontSize: 13),
//                                  )
//                                ],
//                              ),
//                            )
//                          ],
//                        ),
//                      );
//                    },
//                    options: CarouselOptions(
//                        enableInfiniteScroll: false,
//                        initialPage: 0,
//                        autoPlay: true,
//                        enlargeCenterPage: true,
//                        height: 250)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
