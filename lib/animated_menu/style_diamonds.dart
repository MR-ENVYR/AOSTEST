import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StyleDiamonds extends StatefulWidget {
  @override
  _StyleDiamondsState createState() => _StyleDiamondsState();
}

class _StyleDiamondsState extends State<StyleDiamonds> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(3, 9, 23, 1),
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xFFc0a948)),
        backgroundColor: Colors.transparent,
        title: Text(
          "Style Diamonds",
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
    ;
  }
}
