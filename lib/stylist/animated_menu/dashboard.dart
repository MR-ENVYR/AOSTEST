import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:style_of_agent/stylist/animated_menu/Library.dart';
import 'package:style_of_agent/model/clients_query_model.dart';

import 'package:style_of_agent/stylist/animated_menu/clients_screen.dart';
import 'package:style_of_agent/stylist/animated_menu/profile.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:style_of_agent/stylist/stylistChatHomepage.dart';
import 'package:style_of_agent/widgets/custom_expension_tile.dart' as custom;
import 'package:style_of_agent/utils/utils.dart';

class StyleDashBoard extends StatefulWidget {
  @override
  _StyleDashBoardState createState() => _StyleDashBoardState();
}

class _StyleDashBoardState extends State<StyleDashBoard>
    with SingleTickerProviderStateMixin {
  int _onTapped = 2;
  GlobalKey _toolTipKey = GlobalKey();
  var date = DateTime.now();
  Duration duration = Duration(milliseconds: 200);
  int _selectedIndex = 0;
  bool isClick = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _onTapped = 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    var margin = MediaQuery.of(context).size.height * 0.02;
    return Container(
//      color: Color.fromRGBO(3, 9, 23, 1),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color.fromRGBO(3, 9, 23, 1),
      ),
      child: SafeArea(
        child: Scaffold(
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.transparent,
            child: Stack(
              children: <Widget>[
                _onTapped == 2
                    ? Column(
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "DashBoard",
                                  style: GoogleFonts.amiri(
                                    letterSpacing: 2,
                                    fontSize: 30,
                                    color: Color(0xFFc0a948),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          StreamBuilder(
                              stream: Firestore.instance
                                  .collection("questions")
                                  .where("status", isEqualTo: "inactive")
                                  .snapshots(),
                              builder: (context, snapshots) {
                                if (snapshots.hasData) {
                                  var questions = snapshots.data.documents;
                                  print(snapshots.data.documents.length);
                                  List<ClientQuestion> clientQuerys = [];
                                  for (var question in questions) {
                                    final id =
                                        question.data[ClientQuery.ID_KEY];
                                    final uid =
                                        question.data[ClientQuery.UID_KEY];
                                    final username =
                                        question.data[ClientQuery.USERNAME_KEY];
                                    final phno =
                                        question.data[ClientQuery.PNO_KEY];
                                    final ques1 =
                                        question.data[ClientQuery.QUES1_KEY];
                                    final ques2 =
                                        question.data[ClientQuery.QUES2_KEY];
                                    final ques3 =
                                        question.data[ClientQuery.QUES3_KEY];

                                    final clientQuery = ClientQuery(
                                        id: id,
                                        uid: uid,
                                        username: username,
                                        phno: phno,
                                        ques1: ques1,
                                        ques2: ques2,
                                        ques3: ques3);
                                    clientQuerys.add(ClientQuestion(
                                        clientQuery: clientQuery));
                                  }
                                  return Expanded(
                                    child: ListView(
//                                        reverse: true,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 20),
                                        children: clientQuerys),
                                  );
                                } else {
                                  return SizedBox(
                                    height: 0,
                                  );
                                }
                              })
                        ],
                      )
                    : Container(),
                _onTapped == 0 ? Library() : Container(),
                _onTapped == 1 ? StyleProfile() : Container(),
                _onTapped == 3 ? StylistChatHomePage() : Container(),
              ],
            ),
          ),
          backgroundColor: Colors.transparent,
          bottomNavigationBar: CurvedNavigationBar(
            buttonBackgroundColor: Color(0xfffb4545),
            index: 2,
            backgroundColor: Colors.transparent,
            height: 50,
            color: Color(0xfffb4545),
            animationDuration: Duration(milliseconds: 300),
//            animationCurve: Curves.bounceOut,
            items: <Widget>[
              Icon(
                Icons.photo_album,
                color: Color.fromRGBO(3, 9, 23, 1),
                size: _onTapped == 0 ? 30 : 25,
              ),
              Icon(
                Icons.person,
                color: Color.fromRGBO(3, 9, 23, 1),
                size: _onTapped == 1 ? 30 : 25,
              ),
              Image.asset(
                "assets/images/me.png",
                scale: _onTapped == 2 ? 16 : 23,
                color: Color.fromRGBO(3, 9, 23, 1),
              ),
              Image.asset(
                "assets/images/customer.png",
                scale: _onTapped == 3 ? 16 : 23,
                color: Color.fromRGBO(3, 9, 23, 1),
              ),

//              Icon(Icons.favorite,color: Colors.red,),
            ],
            onTap: (index) {
              setState(() {
                _onTapped = index;
              });
            },
          ),
        ),
      ),
    );
  }
}

class ClientQuestion extends StatelessWidget {
  ClientQuery clientQuery;

  ClientQuestion({this.clientQuery});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firestore.instance
            .collection("users")
            .document(clientQuery.uid)
            .get(),
        builder: (context, snapshot) {
          var q3 = "";
          clientQuery.ques3.forEach((element) {
            q3 = q3 + element + ", ";
          });
          if (snapshot.hasData) {
            print(snapshot.data["url"]);
            return Card(
              color: Color.fromRGBO(3, 9, 23, 1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  custom.ExpansionTile(
                    iconColor: Color(0xFFc0a948),
                    headerBackgroundColor: Colors.transparent,
                    title: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: (snapshot.data["url"] == null)
                              ? AssetImage(
                                  'assets/images/av.png',
                                )
                              : NetworkImage(snapshot.data["url"]),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          clientQuery.username,
                          style: GoogleFonts.amiri(
                            letterSpacing: 2,
                            fontSize: 20,
                            color: Color(0xFFffffff),
                          ),
                        ),
                      ],
                    ),
                    children: <Widget>[
                      Text(
                        "Q1. Your current look",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.amiri(
                          letterSpacing: 2,
                          fontSize: 15,
                          color: Color(0xFFc0a948),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Ans. ",
                            style: GoogleFonts.amiri(
                              letterSpacing: 2,
                              fontSize: 15,
                              color: Color(0xFFc0a948),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
//                            margin: EdgeInsets.symmetric(horizontal: 90),
//                            constraints: BoxConstraints(minWidth: 20),
                            width: 150,
                            height: 150,

//                        width: 100,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                border: Border.all(
                                    color: Color(0xFFE5CF73), width: 2),
                                image: DecorationImage(
                                    image: NetworkImage(clientQuery.ques1))),
                          ),
                        ],
                      ),
//
                      Text(
                        "Q2. For which type of occasion would you like an opinion ?",
                        style: GoogleFonts.amiri(
                          letterSpacing: 2,
                          fontSize: 15,
                          color: Color(0xFFc0a948),
                        ),
                      ),
                      Text(
                        "Ans. " + clientQuery.ques2,
                        style: GoogleFonts.amiri(
                          letterSpacing: 2,
                          fontSize: 15,
                          color: Color(0xFFc0a948),
                        ),
                      ),
                      Text(
                        "Q3. How can we help you?",
                        style: GoogleFonts.amiri(
                          letterSpacing: 2,
                          fontSize: 15,
                          color: Color(0xFFc0a948),
                        ),
                      ),
                      Text(
                        "Ans. " + q3,
                        style: GoogleFonts.amiri(
                          letterSpacing: 2,
                          fontSize: 15,
                          color: Color(0xFFc0a948),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          RaisedButton(
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 8.0),
                            elevation: 10,
                            splashColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'Accept',
                              style: TextStyle(
                                fontSize: 15,
//                                  fontWeight:FontWeight.bold,
                                fontFamily: "FreigSanPro",
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              print(clientQuery.id);
                              print(clientQuery.id);
                              Firestore.instance
                                  .collection('questions')
                                  .document(clientQuery.id)
                                  .updateData({'status': 'active'});
                            },
                            color: Colors.lightGreen,
                          ),
                          RaisedButton(
                            elevation: 10,
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 8.0),
                            splashColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text('Decline',
                                style: TextStyle(
                                  fontSize: 15,
//                                    fontWeight:FontWeight.bold,
                                  fontFamily: "FreigSanPro",
                                  color: Colors.white,
                                )),
                            onPressed: () {
                              Firestore.instance
                                  .collection('questions')
                                  .document(clientQuery.id)
                                  .updateData({'status': 'complete'});
                            },
                            color: Color(0xFFfb4545),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else {
            return Card(
              color: Color.fromRGBO(3, 9, 23, 1),
              child: Shimmer.fromColors(
                baseColor: Color(0xFFc0a948).withOpacity(0.1),
                highlightColor: Color(0xFFc0a948).withOpacity(0.4),
                enabled: true,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
//                      Container(
//                        color: Colors.white,
////                        decoration: Box,
//                        child: CircleAvatar(),
//                      ),
                      CircleAvatar(),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              height: 8.0,
                              color: Colors.white,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 2.0),
                            ),
                            Container(
                              width: double.infinity,
                              height: 8.0,
                              color: Colors.white,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 2.0),
                            ),
                            Container(
                              width: 40.0,
                              height: 8.0,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }
        });
  }
}
