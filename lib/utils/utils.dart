import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle labelStyle =
//    GoogleFonts.(color: Colors.white, fontWeight: FontWeight.w200);
    TextStyle(
        color: Colors.white,
        fontFamily: "FreigSanPro",
        fontWeight: FontWeight.w500);

TextStyle errorStyle = TextStyle(
    color: Colors.redAccent,
    fontFamily: "FreigSanPro",
    fontWeight: FontWeight.w500);

TextStyle inputStyle = TextStyle(
    color: Colors.white,
    fontFamily: "FreigSanPro",
    fontWeight: FontWeight.w400);

TextStyle headlineStyle = GoogleFonts.amiri(
    color: Color(0xFFc0a948),
//    fontFamily: "Helvetica",
    fontWeight: FontWeight.w300,
    fontSize: 25);

TextStyle waitlineStyle = GoogleFonts.amiri(
    color: Color(0xFFc0a948),
//    fontFamily: "Helvetica",
    fontWeight: FontWeight.w300,
    wordSpacing: 5,
    letterSpacing: 2,
    fontSize: 30);

TextStyle menuItemStyle = GoogleFonts.amiri(
//    shadows: [Shadow(color: Color(0xFFc0a948), blurRadius: 10)],
    color: Color(0xFFc0a948),
//    fontFamily: "Helvetica",
    fontWeight: FontWeight.bold,
    fontSize: 20);

OutlineInputBorder errorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(30)),
    borderSide: BorderSide(color: Colors.redAccent, width: 0.2));

OutlineInputBorder labelBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(30)),
    borderSide: BorderSide(color: Color(0xFF212121), width: 0.2));
