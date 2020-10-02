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
    color: Color(0xFFE5CF73),
//    fontFamily: "Helvetica",
    fontWeight: FontWeight.w300,
    fontSize: 25);

TextStyle waitlineStyle = GoogleFonts.amiri(
    color: Color(0xFFE5CF73),
//    fontFamily: "Helvetica",
    fontWeight: FontWeight.w300,
    wordSpacing: 5,
    letterSpacing: 2,
    fontSize: 30);

TextStyle menuItemStyle = GoogleFonts.amiri(
//    shadows: [Shadow(color: Color(0xFFE5CF73), blurRadius: 10)],
    color: Color(0xFFE5CF73),
//    fontFamily: "Helvetica",
    fontWeight: FontWeight.bold,
    fontSize: 20);

OutlineInputBorder errorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(30)),
    borderSide: BorderSide(color: Colors.redAccent, width: 0.2));

OutlineInputBorder labelBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(30)),
    borderSide: BorderSide(color: Color(0xFF212121), width: 0.2));

const Color white = Color(0xFFFFFFFF);
const Color notWhite = Color(0xFFF8F6F6);
const Color primary = Color(0xFFBDA94B);
const Color lightPrimary = Color(0xFFE2CF75);

const Color secondary = Color(0xFFfb4545);
const Color dark = Color.fromRGBO(3, 9, 23, 1);
TextStyle textTheme3 = GoogleFonts.amiri(color: white, fontSize: 22);
const TextStyle chatText = TextStyle(color: white, fontSize: 18);
const TextStyle textTheme2 = TextStyle(color: Colors.black, fontSize: 22);
const TextStyle buttonStyle1 = TextStyle(color: Colors.black, fontSize: 18);
const TextStyle buttonStyle2 = TextStyle(color: white, fontSize: 18);

const sendButtonTextStyle = TextStyle(
  color: secondary,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const messageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  hintStyle: TextStyle(color: notWhite),
  border: InputBorder.none,
  fillColor: notWhite,
  focusColor: notWhite,
  counterStyle: TextStyle(color: notWhite),
);

const messageContainerDecoration = BoxDecoration(
  color: dark,
  border: Border(
    top: BorderSide(color: secondary, width: 2.0),
  ),
);
