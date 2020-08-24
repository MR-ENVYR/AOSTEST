import 'package:firebase_auth/firebase_auth.dart';
import 'package:style_of_agent/QA_Sections/fadeAnimation.dart';
import 'package:style_of_agent/QA_Sections/moveAnimation.dart';
import 'package:style_of_agent/QA_Sections/moveLRAnimation.dart';
import 'package:style_of_agent/QA_Sections/q_three.dart';
import 'package:style_of_agent/animated_menu/menu_frame.dart';
import 'package:style_of_agent/connection.dart';
import 'package:style_of_agent/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class QueTwo extends StatefulWidget {
  Map<String, dynamic> ques = Map();
//  FirebaseUser user;
  QueTwo({
    this.ques,
  });
  @override
  _QueTwoState createState() => _QueTwoState();
}

class _QueTwoState extends State<QueTwo> {
  bool isExpanded = false;
  String radioItem = "Today";
  List<String> images = [
    'assets/images/occasions/today.jpg',
    'assets/images/occasions/wedding.jpg',
    'assets/images/occasions/office.jpg',
    'assets/images/occasions/farewell.jpg',
    'assets/images/occasions/funeral.jpg',
    'assets/images/occasions/job_interview.jpg',
    'assets/images/occasions/party.jpg',
    'assets/images/occasions/anniversary.jpg',
    'assets/images/occasions/other.jpg',
  ];

  List<String> labels = [
    'Today',
    'Wedding',
    'Office',
    'Farewell',
    'Funeral',
    'Job\nInterview',
    'Party',
    'Anniversary',
    'Other',
  ];
  List<bool> selects = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  void initState() {
    // TODO: implement initState
    super.initState();
//    checkConnection(context);
//    print(widget.user.uid);
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color.fromRGBO(3, 9, 23, 1),
//        appBar: AppBar(
//          backgroundColor: Color.fromRGBO(3, 9, 23, 1),
//          title: Align(
//            alignment: Alignment.topRight,
//            child: SvgPicture.asset(
//              "assets/images/aoslogo.svg",
//              height: 55,
////              width: 10,
//            ),
//          ),
////          centerTitle: true,
//          leading: GestureDetector(
//            onTap: () {
//              Navigator.pushAndRemoveUntil(
//                  context,
//                  PageTransition(
//                      type: PageTransitionType.rightToLeftWithFade,
//                      child: MenuFrame(
////                                uid: id,
//                          )),
//                  (route) => false);
//            },
//            child: Align(
////              alignment: Alignment.bottomLeft,
//              child: Padding(
//                padding: const EdgeInsets.only(left: 20),
//                child: Text(
//                  "<",
//                  style: TextStyle(color: Colors.white, fontSize: 40),
//                ),
//              ),
//            ),
//          ),
//        ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Color.fromRGBO(3, 9, 23, 1),
            brightness: Brightness.dark,
            title: Align(
              alignment: Alignment.topRight,
              child: SvgPicture.asset(
                "assets/images/aoslogo.svg",
                height: 50,
//              width: 10,
              ),
            ),
            leading: GestureDetector(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeftWithFade,
                        child: MenuFrame(
//                                uid: id,
                            )),
                    (route) => false);
              },
              child: Align(
//              alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    "<",
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                ),
              ),
            ),
            floating: true,
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            Container(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
//                  Align(
//                    alignment: Alignment.topRight,
//                    child: SvgPicture.asset(
//                      "assets/images/aoslogo.svg",
//                    ),
//                  ),
//                  GestureDetector(
//                    onTap: () {
//                      Navigator.pushAndRemoveUntil(
//                          context,
//                          PageTransition(
//                              type: PageTransitionType.rightToLeftWithFade,
//                              child: MenuFrame(
////                                uid: id,
//                                  )),
//                          (route) => false);
//                    },
//                    child: Align(
//                      alignment: Alignment.bottomLeft,
//                      child: Padding(
//                        padding: const EdgeInsets.only(right: 20),
//                        child: Text(
//                          "<",
//                          style: TextStyle(color: Colors.white, fontSize: 40),
//                        ),
//                      ),
//                    ),
//                  ),
                    SizedBox(
                      height: 20,
                    ),
                    MoveAnimation(
                        1,
                        Container(
                          width: MediaQuery.of(context).size.height / 3,
                          height: MediaQuery.of(context).size.height / 3,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                    "assets/images/qa_section/q2_logo.jpg",
                                  ),
                                  fit: BoxFit.cover),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    FadeAnimation(
                      1.5,
                      Text(
                        "For which type of occasion would you like an opinion ?",
                        textAlign: TextAlign.center,
                        style: headlineStyle,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
//                  FadeAnimation(
//                    2,
//                    GridView.builder(
//                      shrinkWrap: true,
//                      physics: ScrollPhysics(),
//                      scrollDirection: Axis.vertical,
//                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                        crossAxisCount: 2,
//                        childAspectRatio: 0.55,
////                          crossAxisSpacing: 1,
////                          mainAxisSpacing: 20
//                      ),
//                      itemBuilder: (context, i) {
//                        if (i % 2 == 0) {
//                          return MoveAnimation(
//                            2.0 + 0.2 * i,
//                            GestureDetector(
//                              onTap: () {
//                                setState(() {
//                                  selects[i] = !selects[i];
//                                });
//                              },
//                              child: Card(
//                                elevation: 5,
////                              shape: ,
////                              color: Colors.transparent.withOpacity(0.2),
//                                child: Container(
//                                  height: 282,
//                                  child: Align(
//                                    child: Padding(
//                                      padding: const EdgeInsets.only(left: 5.0),
//                                      child: Row(
//                                        mainAxisAlignment:
//                                            MainAxisAlignment.spaceBetween,
//                                        crossAxisAlignment:
//                                            CrossAxisAlignment.center,
//                                        children: <Widget>[
////                                      SizedBox(width: 0.5),
//                                          Text(
//                                            labels[i],
////                                        textAlign: TextAlign.start,
//                                            style: GoogleFonts.workSans(
//                                                fontSize: 17,
//                                                color: Colors.red),
//                                          ),
//                                          Checkbox(
//                                              checkColor: Colors.white,
//                                              activeColor: Color(0xFFE5CF73),
//                                              hoverColor: Color(0xFFE5CF73),
//                                              value: selects[i],
//                                              onChanged: (bool val) {
//                                                setState(() {
//                                                  selects[i] = val;
//                                                });
//                                              }),
//                                        ],
//                                      ),
//                                    ),
//                                    alignment: Alignment.bottomCenter,
//                                  ),
//                                  decoration: BoxDecoration(
//                                      border: Border.all(
//                                          color: Colors.white, width: 2),
//                                      image: DecorationImage(
//                                          image: AssetImage(
//                                            images[i],
//                                          ),
//                                          fit: BoxFit.fill)),
//                                ),
//                              ),
//                            ),
//                          );
//                        } else {
//                          return MoveLRAnimation(
//                            2.0 + 0.2 * i,
//                            GestureDetector(
//                              onTap: () {
//                                setState(() {
//                                  selects[i] = !selects[i];
//                                });
//                              },
//                              child: Card(
//                                elevation: 5,
//                                child: Container(
//                                  height: 282,
//                                  child: Align(
//                                    child: Padding(
//                                      padding: const EdgeInsets.only(left: 2.0),
//                                      child: Row(
//                                        mainAxisAlignment:
//                                            MainAxisAlignment.spaceBetween,
//                                        crossAxisAlignment:
//                                            CrossAxisAlignment.center,
//                                        children: <Widget>[
////                                      SizedBox(width: 0.5),
//                                          Text(
//                                            labels[i],
////                                        textAlign: TextAlign.start,
//                                            style: GoogleFonts.workSans(
//                                                fontSize: 17,
//                                                color: Colors.red),
//                                          ),
//                                          Checkbox(
//                                              checkColor: Colors.white,
//                                              activeColor: Color(0xFFE5CF73),
//                                              hoverColor: Color(0xFFE5CF73),
//                                              value: selects[i],
//                                              onChanged: (bool val) {
//                                                setState(() {
//                                                  selects[i] = val;
//                                                });
//                                              }),
//                                        ],
//                                      ),
//                                    ),
//                                    alignment: Alignment.bottomCenter,
//                                  ),
//                                  decoration: BoxDecoration(
//                                      border: Border.all(
//                                          color: Colors.white, width: 2),
//                                      image: DecorationImage(
//                                          image: AssetImage(
//                                            images[i],
//                                          ),
//                                          fit: BoxFit.fill)),
//                                ),
//                              ),
//                            ),
//                          );
//                        }
//                      },
//                      itemCount: images.length,
//                    ),
//                  ),
                    FadeAnimation(
                      1.8,
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isExpanded = !isExpanded;
                          });
                        },
                        child: Card(
                          color: Colors.red,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          elevation: 0,
                          child: Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
//                    color: Colors.red,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  radioItem,
                                  style:
                                      GoogleFonts.workSans(color: Colors.white),
                                ),
                                isExpanded
                                    ? Icon(
                                        Icons.keyboard_arrow_up,
                                        color: Colors.white,
                                      )
                                    : Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.white,
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    isExpanded
                        ? Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: Color(0xffD32F2F),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(children: <Widget>[
                              RadioListTile(
                                activeColor: Colors.white,
                                groupValue: radioItem,
                                title: Text(
                                  'Today',
                                  style:
                                      GoogleFonts.workSans(color: Colors.white),
                                ),
                                value: 'Today',
                                onChanged: (val) {
                                  setState(() {
                                    radioItem = val;
                                    isExpanded = false;
                                  });
                                },
                              ),
                              RadioListTile(
                                activeColor: Colors.white,
                                groupValue: radioItem,
                                title: Text(
                                  'Wedding',
                                  style:
                                      GoogleFonts.workSans(color: Colors.white),
                                ),
                                value: 'Wedding',
                                onChanged: (val) {
                                  setState(() {
                                    radioItem = val;
                                    isExpanded = false;
                                  });
                                },
                              ),
//                              RadioListTile(
//                                activeColor: Colors.white,
//
//                                groupValue: radioItem,
//                                title: Text('Farewell',
//                                    style: TextStyle(color: Colors.white)),
//                                value: 'Farewell',
//                                onChanged: (val) {
//                                  setState(() {
//                                    radioItem = val;
//                                  });
//                                },
//                              ),
                              RadioListTile(
                                activeColor: Colors.white,
                                groupValue: radioItem,
                                title: Text(
                                  'Party',
                                  style:
                                      GoogleFonts.workSans(color: Colors.white),
                                ),
                                value: 'Party',
                                onChanged: (val) {
                                  setState(() {
                                    radioItem = val;
                                    isExpanded = false;
                                  });
                                },
                              ),
//                              RadioListTile(
//                                activeColor: Colors.white,
//                                groupValue: radioItem,
//                                title: Text('Anniversary',
//                                    style: TextStyle(color: Colors.white)),
//                                value: 'Anniversary',
//                                onChanged: (val) {
//                                  setState(() {
//                                    radioItem = val;
//                                  });
//                                },
//                              ),
//                              RadioListTile(
//                                activeColor: Colors.white,
//                                groupValue: radioItem,
//                                title: Text('Office',
//                                    style: TextStyle(color: Colors.white)),
//                                value: 'Office',
//                                onChanged: (val) {
//                                  setState(() {
//                                    radioItem = val;
//                                  });
//                                },
//                              ),
                              RadioListTile(
                                activeColor: Colors.white,
                                groupValue: radioItem,
                                title: Text(
                                  'Job Interview',
                                  style:
                                      GoogleFonts.workSans(color: Colors.white),
                                ),
                                value: 'Job Interview',
                                onChanged: (val) {
                                  setState(() {
                                    radioItem = val;
                                    isExpanded = false;
                                  });
                                },
                              ),
//                              RadioListTile(
//                                activeColor: Colors.white,
//                                groupValue: radioItem,
//                                title: Text('Funeral',
//                                    style: TextStyle(color: Colors.white)),
//                                value: 'Funeral',
//                                onChanged: (val) {
//                                  setState(() {
//                                    radioItem = val;
//                                  });
//                                },
//                              ),
//                              RadioListTile(
//                                activeColor: Colors.white,
//                                groupValue: radioItem,
//                                title: Text('Other',
//                                    style: TextStyle(color: Colors.white)),
//                                value: 'Other',
//                                onChanged: (val) {
//                                  setState(() {
//                                    radioItem = val;
//                                  });
//                                },
//                              ),
                            ]))
                        : Container(),
                    SizedBox(
                      height: 30,
                    ),
                    FadeAnimation(
                      2,
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: FlatButton(
                          padding:
                              EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                  color: Color(0xFFfb4545), width: 3)),
                          color: Color(0xFFfb4545),
                          onPressed: () {
                            if (radioItem.isNotEmpty) {
//                            var sel = labels.asMap().entries.map((i) {
//                              if (selects[i.key]) return i.value;
//                            }).toList();
                              widget.ques.putIfAbsent("ques2", () => radioItem);
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType
                                          .rightToLeftWithFade,
                                      child: QueThree(
//                                      user: widget.user,
                                        ques: widget.ques,
                                      )));
                            } else {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                backgroundColor: Colors.black,
                                content: Text(
                                  "Select one of occasion ",
                                  style: labelStyle,
                                ),
                                duration: Duration(milliseconds: 500),
                                elevation: 5,
                              ));
                            }
                          },

//                        textColor: ,
                          child: Text("Next",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: "FreigSanPro",
                                  color: Colors.white)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]))
        ],
      ),
    );
  }
}
