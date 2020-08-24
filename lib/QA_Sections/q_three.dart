import 'package:firebase_auth/firebase_auth.dart';
import 'package:style_of_agent/QA_Sections/fadeAnimation.dart';
import 'package:style_of_agent/QA_Sections/moveAnimation.dart';
import 'package:style_of_agent/QA_Sections/moveLRAnimation.dart';
import 'package:style_of_agent/QA_Sections/q_four.dart';
import 'package:style_of_agent/animated_menu/menu_frame.dart';
import 'package:style_of_agent/connection.dart';
import 'package:style_of_agent/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';

class QueThree extends StatefulWidget {
  Map<String, dynamic> ques = Map();
//  FirebaseUser user;
  QueThree({this.ques});
  @override
  _QueThreeState createState() => _QueThreeState();
}

class _QueThreeState extends State<QueThree> {
  List<bool> selects = [
    false,
    false,
    false,
    false,
  ];

  List<String> images = [
    'assets/images/qa_section/size.png',
    'assets/images/qa_section/suit.png',
    'assets/images/qa_section/color.png',
    'assets/images/qa_section/fit.png',
//    'assets/images/qa_section/op5.png',
//    'assets/images/qa_section/op6.png',
//    'assets/images/qa_section/op7.png',
//    'assets/images/qa_section/op8.png'
  ];
  List<String> labels = [
    'Size',
    'Does this suit me',
    'Colour',
    'Fits the occasion',
  ];

  List<bool> isHover = [
    false,
    false,
    false,
    false,
  ];

  void initState() {
    // TODO: implement initState
    super.initState();
//    checkConnection(context);
//    print(widget.user.uid);
  }

  String radioItem = "";
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Container(
      color: Color.fromRGBO(3, 9, 23, 1),
      child: Scaffold(
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
                width: double.infinity,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
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
//                        SizedBox(
//                          height: 20,
//                        ),
                        MoveAnimation(
                            1,
                            Container(
                              width: MediaQuery.of(context).size.height / 3,
                              height: MediaQuery.of(context).size.height / 3,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                        "assets/images/qa_section/q3_logo.jpg",
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
                            "How can we help you?",
                            textAlign: TextAlign.center,
                            style: headlineStyle,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        //                  FadeAnimation(
//                    1.8,
//                    GestureDetector(
//                      onTap: () {
//                        setState(() {
//                          isExpanded = !isExpanded;
//                        });
//                      },
//                      child: Card(
//                        color: Colors.red,
//                        shape: RoundedRectangleBorder(
//                            borderRadius:
//                                BorderRadius.all(Radius.circular(10.0))),
//                        elevation: 0,
//                        child: Container(
//                          padding: EdgeInsets.all(15),
//                          decoration: BoxDecoration(
//                            borderRadius: BorderRadius.all(Radius.circular(10)),
////                    color: Colors.red,
//                          ),
//                          child: Row(
//                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                            crossAxisAlignment: CrossAxisAlignment.center,
//                            children: <Widget>[
//                              Text(
//                                "Today",
//                                style: TextStyle(
//                                  color: Colors.white,
//                                ),
//                              ),
////                              isExpanded
////                                  ? Icon(
////                                      Icons.keyboard_arrow_up,
////                                      color: Colors.white,
////                                    )
////                                  : Icon(
////                                      Icons.keyboard_arrow_down,
////                                      color: Colors.white,
////                                    ),
//                            ],
//                          ),
//                        ),
//                      ),
//                    ),
//                  ),
////                  isExpanded
////                      ?
//                  MoveAnimation(
//                    1.8,
//                    Container(
//                        margin: EdgeInsets.symmetric(horizontal: 10),
//                        color: Color(0xffD32F2F),
//                        child: Column(children: <Widget>[
//                          RadioListTile(
//                            activeColor: Colors.white,
//                            groupValue: radioItem,
//                            title: Text(
//                              'Size',
//                              style: TextStyle(color: Colors.white),
//                            ),
//                            value: 'Size',
//                            onChanged: (val) {
//                              setState(() {
//                                radioItem = val;
//                              });
//                            },
//                          ),
//                          RadioListTile(
//                            activeColor: Colors.white,
//                            groupValue: radioItem,
//                            title: Text('Fitting',
//                                style: TextStyle(color: Colors.white)),
//                            value: 'Fitting',
//                            onChanged: (val) {
//                              setState(() {
//                                radioItem = val;
//                              });
//                            },
//                          ),
//                          RadioListTile(
//                            activeColor: Colors.white,
//                            groupValue: radioItem,
//                            title: Text('Colour',
//                                style: TextStyle(color: Colors.white)),
//                            value: 'Colour',
//                            onChanged: (val) {
//                              setState(() {
//                                radioItem = val;
//                              });
//                            },
//                          ),
//                          RadioListTile(
//                            activeColor: Colors.white,
//                            groupValue: radioItem,
//                            title: Text('Fit the occasion',
//                                style: TextStyle(color: Colors.white)),
//                            value: 'Fit the occasion',
//                            onChanged: (val) {
//                              setState(() {
//                                radioItem = val;
//                              });
//                            },
//                          ),
//                        ])),
//                  ),

//                      : Container(),

//                        FadeAnimation(
//                          2,
//                          GridView.builder(
//                            shrinkWrap: true,
//                            physics: ScrollPhysics(),
//                            scrollDirection: Axis.vertical,
////                            gridDelegate:Sli
//
//                            itemBuilder: (context, i) {
//                              if (i % 2 == 0) {
//                                return MoveAnimation(
//                                  2.0 + 1 * i,
//                                  GestureDetector(
//                                    onTap: () {
//                                      setState(() {
//                                        selects[i] = !selects[i];
//                                      });
//                                    },
//                                    onLongPress: () {
//                                      setState(() {
//                                        isHover[i] = true;
//                                      });
//                                    },
//                                    onLongPressEnd: (details) {
//                                      setState(() {
//                                        isHover[i] = false;
//                                      });
//                                    },
//                                    child: Container(
//                                      height: 10,
//                                      width: 10,
//                                      decoration: BoxDecoration(
//                                        shape: BoxShape.circle,
//                                        image: DecorationImage(
//                                            image: AssetImage(images[i]),
//                                            fit: BoxFit.cover),
////                                borderRadius:
////                                BorderRadius.all(Radius.circular(10)),
//                                      ),
//                                      child: isHover[i]
//                                          ? Container(
//                                              height: 10,
//                                              width: 10,
//                                              decoration: BoxDecoration(
//                                                  shape: BoxShape.circle,
//                                                  color: Colors.black54
//                                                      .withOpacity(0.7)),
//                                              child: Center(
//                                                child: Text(
//                                                  labels[i],
//                                                  textAlign: TextAlign.center,
//                                                  style: menuItemStyle,
//                                                ),
//                                              ),
//                                            )
//                                          : selects[i]
//                                              ? Icon(
//                                                  Icons.check,
//                                                  size: 100,
//                                                  color: Colors.white,
//                                                )
//                                              : Container(),
//                                    ),
//                                  ),
//                                );
//                              } else {
//                                return MoveLRAnimation(
//                                  2.0 + 1 * i,
//                                  GestureDetector(
//                                    onTap: () {
//                                      setState(() {
//                                        selects[i] = !selects[i];
//                                      });
//                                    },
//                                    onLongPress: () {
//                                      setState(() {
//                                        isHover[i] = true;
//                                      });
//                                    },
//                                    onLongPressEnd: (details) {
//                                      setState(() {
//                                        isHover[i] = false;
//                                      });
//                                    },
//                                    child: Container(
//                                      height: 50,
//                                      width: 50,
//                                      decoration: BoxDecoration(
//                                        shape: BoxShape.circle,
//                                        image: DecorationImage(
//                                            image: AssetImage(images[i]),
//                                            fit: BoxFit.cover),
////                                borderRadius:
////                                BorderRadius.all(Radius.circular(10)),
//                                      ),
//                                      child: isHover[i]
//                                          ? Container(
//                                              decoration: BoxDecoration(
//                                                  shape: BoxShape.circle,
//                                                  color: Colors.black54
//                                                      .withOpacity(0.7)),
//                                              child: Center(
//                                                child: Text(
//                                                  labels[i],
//                                                  textAlign: TextAlign.center,
//                                                  style: menuItemStyle,
//                                                ),
//                                              ),
//                                            )
//                                          : selects[i]
//                                              ? Icon(
//                                                  Icons.check,
//                                                  size: 100,
//                                                  color: Colors.white,
//                                                )
//                                              : Container(),
//                                    ),
//                                  ),
//                                );
//                              }
//                            },
//                            itemCount: images.length,
//                          ),
//                        ),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                MoveAnimation(
                                  2.0 + 1 * 0,
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selects[0] = !selects[0];
                                      });
                                    },
                                    onLongPress: () {
                                      setState(() {
                                        isHover[0] = true;
                                      });
                                    },
                                    onLongPressEnd: (details) {
                                      setState(() {
                                        isHover[0] = false;
                                      });
                                    },
                                    child: Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: AssetImage(images[0]),
                                            fit: BoxFit.cover),
//                                borderRadius:
//                                BorderRadius.all(Radius.circular(10)),
                                      ),
                                      child: isHover[0]
                                          ? Container(
                                              height: 100,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.black54
                                                      .withOpacity(0.7)),
                                              child: Center(
                                                child: Text(
                                                  labels[0],
                                                  textAlign: TextAlign.center,
                                                  style: menuItemStyle,
                                                ),
                                              ),
                                            )
                                          : selects[0]
                                              ? Icon(
                                                  Icons.check,
                                                  size: 100,
                                                  color: Colors.white,
                                                )
                                              : Container(),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                MoveAnimation(
                                  2.0 + 1 * 2,
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selects[2] = !selects[2];
                                      });
                                    },
                                    onLongPress: () {
                                      setState(() {
                                        isHover[2] = true;
                                      });
                                    },
                                    onLongPressEnd: (details) {
                                      setState(() {
                                        isHover[2] = false;
                                      });
                                    },
                                    child: Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: AssetImage(images[2]),
                                            fit: BoxFit.cover),
//                                borderRadius:
//                                BorderRadius.all(Radius.circular(10)),
                                      ),
                                      child: isHover[2]
                                          ? Container(
                                              height: 100,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.black54
                                                      .withOpacity(0.7)),
                                              child: Center(
                                                child: Text(
                                                  labels[2],
                                                  textAlign: TextAlign.center,
                                                  style: menuItemStyle,
                                                ),
                                              ),
                                            )
                                          : selects[2]
                                              ? Icon(
                                                  Icons.check,
                                                  size: 100,
                                                  color: Colors.white,
                                                )
                                              : Container(),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Column(
//                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                MoveLRAnimation(
                                  2.0 + 1 * 1,
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selects[1] = !selects[1];
                                      });
                                    },
                                    onLongPress: () {
                                      setState(() {
                                        isHover[1] = true;
                                      });
                                    },
                                    onLongPressEnd: (details) {
                                      setState(() {
                                        isHover[1] = false;
                                      });
                                    },
                                    child: Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: AssetImage(images[1]),
                                            fit: BoxFit.cover),
//                                borderRadius:
//                                BorderRadius.all(Radius.circular(10)),
                                      ),
                                      child: isHover[1]
                                          ? Container(
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.black54
                                                      .withOpacity(0.7)),
                                              child: Center(
                                                child: Text(
                                                  labels[1],
                                                  textAlign: TextAlign.center,
                                                  style: menuItemStyle,
                                                ),
                                              ),
                                            )
                                          : selects[1]
                                              ? Icon(
                                                  Icons.check,
                                                  size: 100,
                                                  color: Colors.white,
                                                )
                                              : Container(),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                MoveLRAnimation(
                                  2.0 + 1 * 3,
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selects[3] = !selects[3];
                                      });
                                    },
                                    onLongPress: () {
                                      setState(() {
                                        isHover[3] = true;
                                      });
                                    },
                                    onLongPressEnd: (details) {
                                      setState(() {
                                        isHover[3] = false;
                                      });
                                    },
                                    child: Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: AssetImage(images[3]),
                                            fit: BoxFit.cover),
//                                borderRadius:
//                                BorderRadius.all(Radius.circular(10)),
                                      ),
                                      child: isHover[3]
                                          ? Container(
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.black54
                                                      .withOpacity(0.7)),
                                              child: Center(
                                                child: Text(
                                                  labels[3],
                                                  textAlign: TextAlign.center,
                                                  style: menuItemStyle,
                                                ),
                                              ),
                                            )
                                          : selects[3]
                                              ? Icon(
                                                  Icons.check,
                                                  size: 100,
                                                  color: Colors.white,
                                                )
                                              : Container(),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                          3,
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: FlatButton(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 5),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                      color: Color(0xFFfb4545), width: 3)),
                              color: Color(0xFFfb4545),
                              onPressed: () {
                                checkConnection(context);
                                if (selects.contains(true)) {
                                  List<String> sel = List();
                                  for (int i = 0; i < 4; i++) {
                                    if (selects[i]) {
                                      sel.add(labels.elementAt(i));
                                    }
                                  }
                                  widget.ques.putIfAbsent("ques3", () => sel);
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType
                                              .rightToLeftWithFade,
                                          child: QueFour(
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
                              child: Text(
                                "Next",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: "FreigSanPro",
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ]))
          ],
        ),
      ),
    );
  }
}
