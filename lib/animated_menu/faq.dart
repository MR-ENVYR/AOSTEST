import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FAQ extends StatefulWidget {
  @override
  _FAQState createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(3, 9, 23, 1),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
//        iconTheme: IconThemeData(color: Color(0xFFc0a948)),
        title: Text(
          "FAQ",
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
