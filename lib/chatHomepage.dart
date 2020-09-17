//import 'package:agent_of_style/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:style_of_agent/ChatHistory.dart';
import 'package:style_of_agent/inAppChat.dart';
import 'package:style_of_agent/utils/utils.dart';

class ChatHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(3, 9, 23, 1),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xFFc0a948)),
        backgroundColor: Colors.transparent,
        title: Center(
          child: Text(
            'Agents of Style',
            style: GoogleFonts.amiri(
              letterSpacing: 2,
              fontSize: 30,
              color: Color(0xFFc0a948),
//                fontFamily: "FreigSanPro",
            ),
          ),
        ),
      ),
      body: ChatLayout(),
    );
  }
}

class ChatLayout extends StatefulWidget {
  @override
  _ChatLayoutState createState() => _ChatLayoutState();
}

class _ChatLayoutState extends State<ChatLayout> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: dark,
      child: ChatHeads(),
    );
  }

  Widget ChatHeads() {
    return ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
//              Navigator.pushNamed(context, '/chat-window');
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ChatHistory()));
            },
            child: Container(
              margin: EdgeInsets.only(top: 10, left: 10, right: 10),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: secondary,
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 10.0,
                ),
              ], color: secondary, borderRadius: BorderRadius.circular(5)),
              child: ListTile(
                title: Text(
                  'Tracy MacMonday',
                  style: TextStyle(color: notWhite),
                ),
              ),
            ),
          );
        });
  }
}
