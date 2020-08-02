//import 'package:convex_bottom_bar/convex_bottom_bar.dart';
//import 'package:convex_bottom_bar/';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:style_of_agent/animated_menu/Library.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:style_of_agent/QA_Sections/q_one.dart';
import 'package:style_of_agent/animated_menu/profile.dart';
import 'package:style_of_agent/animated_menu/recents_chats.dart';
import 'package:style_of_agent/animated_menu/style_diamonds.dart';
import 'package:style_of_agent/utils/utils.dart';
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
                    ? Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          "DashBoard",
                          style: GoogleFonts.amiri(
                            letterSpacing: 2,
                            fontSize: 30,
                            color: Color(0xFFc0a948),
                          ),
                        ),
                      )
                    : Container(),
                _onTapped == 0 ? Library() : Container(),
                _onTapped == 1 ? Profile() : Container(),
                _onTapped == 3 ? RecentsChats() : Container(),
                _onTapped == 4 ? StyleDiamonds() : Container(),
              ],
            ),
          ),
          backgroundColor: Colors.transparent,
//          bottomNavigationBar: StyleProvider(
//            style: Style(),
//            child: ConvexAppBar(
//              initialActiveIndex: 2,
//              activeColor: Colors.white,
//              height: 50,
//              top: -30,
//              curveSize: 100,
////              style: TabStyle.fixedCircle,
//              onTap: (int val) {
//                setState(() {
//                  _onTapped = val;
//                });
////                if (val == 0)
////                  Navigator.push(
////                    context,
////                    MaterialPageRoute(builder: (context) => Library()),
////                  );
////                else if (val == 1)
////                  Navigator.push(
////                    context,
////                    MaterialPageRoute(builder: (context) => Profile()),
////                  );
//                if (val == 2)
//                  Navigator.pushAndRemoveUntil(
//                      context,
//                      MaterialPageRoute(builder: (context) => QueOne()),
//                      (route) => false);
////                else if (val == 3)
////                  Navigator.push(
////                    context,
////                    MaterialPageRoute(builder: (context) => RecentsChats()),
////                  );
////                else
////                  Navigator.push(
////                    context,
////                    MaterialPageRoute(builder: (context) => StyleDiamonds()),
////                  );
//              },
//              items: [
////                TabItem(icon: Icons.link),
//                TabItem(icon: Icons.photo_album),
//                TabItem(icon: Icons.person),
//                TabItem(icon: Icons.add),
//                TabItem(icon: Icons.message),
//                TabItem(icon: Icons.attach_money),
////                TabItem(title: "2020", icon: Icons.work),
//              ],
//              backgroundColor: Color(0xfffb4545),
//            ),
//          ),

          bottomNavigationBar: CurvedNavigationBar(
            buttonBackgroundColor: Color(0xfffb4545),
            index: 2,
//            backgroundColor: Color(0xfffb4545),
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

class Style extends StyleHook {
  @override
  double get activeIconSize => 30;

  @override
  double get activeIconMargin => 10;

  @override
  double get iconSize => 20;

  @override
  TextStyle textStyle(Color color) {
    return TextStyle(fontSize: 20, color: color);
  }
}