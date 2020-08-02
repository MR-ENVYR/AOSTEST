import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Library extends StatefulWidget {
  @override
  _LibraryState createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(3, 9, 23, 1),
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xFFc0a948)),
        backgroundColor: Colors.transparent,
        title: Text(
          "Library",
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
