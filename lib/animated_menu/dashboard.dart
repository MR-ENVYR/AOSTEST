//import 'package:convex_bottom_bar/convex_bottom_bar.dart';
//import 'package:convex_bottom_bar/';
//import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:style_of_agent/animated_menu/Library.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:style_of_agent/QA_Sections/q_one.dart';
import 'package:style_of_agent/animated_menu/payment.dart';
import 'package:style_of_agent/animated_menu/profile.dart';
import 'package:style_of_agent/animated_menu/recents_chats.dart';
import 'package:style_of_agent/animated_menu/style_diamonds.dart';
import 'package:style_of_agent/chatHomepage.dart';
import 'package:style_of_agent/connection.dart';
import 'package:style_of_agent/stylist/stylistChatHomepage.dart';
import 'package:style_of_agent/utils/utils.dart';
import 'package:style_of_agent/widgets/animate_appbar.dart';
import 'package:style_of_agent/widgets/fab_bottom_bar.dart';
import 'package:style_of_agent/widgets/circular_outer_notched_rectangle.dart';
import 'package:flutter/material.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard>
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
    var width = MediaQuery.of(context).size.width;
    return Container(
//      color: Color.fromRGBO(3, 9, 23, 1),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color.fromRGBO(3, 9, 23, 1),
//          image: DecorationImage(
//              image: AssetImage("assets/images/qa_section/dashboard.jpg"),
//              fit: BoxFit.cover)
      ),
      child: SafeArea(
        child: Scaffold(
//          appBar: AppBar(
//            elevation: 0,
//            backgroundColor: Colors.transparent,
//            title: Text(
//              "DashBoard",
//              style: GoogleFonts.amiri(
//                letterSpacing: 2,
//                fontSize: 30,
//                color: Color(0xFFc0a948),
////                fontFamily: "FreigSanPro",
//              ),
//            ),
//            centerTitle: true,
//          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.transparent,
            child: Stack(
              children: <Widget>[
                _onTapped == 2
                    ? Positioned(
                        top: -15,
//                        left: 100,
                        right: 0,
                        width: width,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
//                          Text(
//                            "DashBoard",
//                            style: GoogleFonts.amiri(
//                              letterSpacing: 2,
//                              fontSize: 30,
//                              color: Color(0xFFc0a948),
//                            ),
//                          ),
                                SizedBox(width: 30),
                                AnimationAppBar(height: 100, width: 200),

                                SizedBox(
                                  width: 55,
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/diamond.png',
                                        color: secondary,
                                        height: 30,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        '1',
                                        style: textTheme3,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.only(left: 10, right: 30),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: secondary),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      'You have received 5 Advices',
                                      style: textTheme3,
                                    ),
                                    Text(
                                      'Till ${date.day}-${date.month}-${date.year}',
                                      style: textTheme3,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(),
                _onTapped == 0 ? Library() : Container(),
                _onTapped == 1 ? Profile() : Container(),
                _onTapped == 3 ? ChatHomePage() : Container(),
                _onTapped == 4 ? PaymentPage() : Container(),
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
            animationCurve: Curves.bounceOut,
            items: <Widget>[
              Icon(
                Icons.photo_album,
                color: Colors.white,
              ),
              Icon(
                Icons.person,
                color: Colors.white,
              ),
              Icon(
                Icons.add,
                color: Colors.white,
              ),
              Icon(
                Icons.message,
                color: Colors.white,
              ),
              Image.asset(
                "assets/images/diamond.png",
                scale: 2,
                color: Colors.white,
              ),
//              Icon(Icons.favorite,color: Colors.red,),
            ],
            onTap: (index) {
              if (index == 2)
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => QueOne()),
                    (route) => false);
              setState(() {
                _onTapped = index;
              });
            },
          ),

//        body: _list[_page],
//        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//        floatingActionButton: FloatingActionButton(
//          onPressed: () {
//          },
//          child: Icon(Icons.add),
//          elevation: 2.0,
//        ),
//      ),
//          floatingActionButton: Tooltip(
//            message: 'New Advice',
//            child: FloatingActionButton(
//              child: Icon(Icons.add),
//              onPressed: () {},
//            ),
//          ),
////          persistentFooterButtons: <Widget>[],
//          floatingActionButtonLocation:
//              FloatingActionButtonLocation.centerDocked,
//        bottomNavigationBar: BottomAppBar(
//          notchMargin: 5,
//          shape: CircularNotchedRectangle(),
//          color: Colors.pink,
//          child: Row(
//            crossAxisAlignment: CrossAxisAlignment.center,
//            mainAxisAlignment: MainAxisAlignment.spaceAround,
//            children: <Widget>[
//              Tooltip(
//                message: 'Album',
//                child: IconButton(
//                  onPressed: () {},
//                  icon: Icon(Icons.photo_library),
//                ),
//              ),
//              Tooltip(
//                message: 'Profile',
//                child: IconButton(
//                  onPressed: () {},
//                  icon: Icon(Icons.person),
//                ),
//              ),
//              Tooltip(
//                message: 'Chats',
//                child: IconButton(
//                  onPressed: () {},
//                  icon: Icon(Icons.chat),
//                ),
//              ),
//              Tooltip(
//                message: 'App Settings',
//                child: IconButton(
//                  onPressed: () {},
//                  icon: Icon(Icons.settings),
//                ),
//              ),
//            ],
//          ),
//        ),
//          floatingActionButton: FloatingActionButton(
//            shape: RoundedRectangleBorder(),
//            backgroundColor: Color(0xFFfb4545),
//            isExtended: true,
//
//            onPressed: () {
//              Navigator.pushAndRemoveUntil(
//                  context,
//                  PageTransition(
//                      type: PageTransitionType.rightToLeftWithFade,
//                      child: QueOne()),
//                  (route) => false);
//            },
//          ),
//          floatingActionButtonLocation:
//              FloatingActionButtonLocation.centerFloat,
        ),
      ),
    );
  }
}

//class Style extends StyleHook {
//  @override
//  double get activeIconSize => 30;
//
//  @override
//  double get activeIconMargin => 10;
//
//  @override
//  double get iconSize => 20;
//
//  @override
//  TextStyle textStyle(Color color) {
//    return TextStyle(fontSize: 20, color: color);
//  }
//}
