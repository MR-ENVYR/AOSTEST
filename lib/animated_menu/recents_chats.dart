import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RecentsChats extends StatefulWidget {
  @override
  _RecentsChatsState createState() => _RecentsChatsState();
}

class _RecentsChatsState extends State<RecentsChats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(3, 9, 23, 1),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xFFc0a948)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Recent Chats",
          style: GoogleFonts.amiri(
            letterSpacing: 2,
            fontSize: 30,
            color: Color(0xFFc0a948),
//                fontFamily: "FreigSanPro",
          ),
        ),
        centerTitle: true,
      ),
    );
  }
}
