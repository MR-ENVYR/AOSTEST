import 'package:flutter/material.dart';

final kHintTextStyle = TextStyle(
  color: Colors.white,
  fontFamily: "Helvetica",
  fontWeight: FontWeight.w200
);

final kLabelStyle = TextStyle(
  letterSpacing: 2.0,
  color: Colors.white,
  fontFamily: "Helvetica",
    fontWeight: FontWeight.w400

);

final kBoxDecorationStyle = BoxDecoration(

  borderRadius: BorderRadius.circular(1.0),
  boxShadow: [
    BoxShadow(
      color: Colors.transparent,
      blurRadius: 3.0,
      offset: Offset(0, 2),
    ),
  ],
);