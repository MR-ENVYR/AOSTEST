import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const Color white = Color(0xFFFFFFFF);
const Color notWhite = Color(0xFFF8F6F6);
const Color primary = Color(0xFFBDA94B);
const Color lightPrimary = Color(0xFFE2CF75);
const Color secondary = Color(0xFFF2423F);
const Color dark = Color.fromRGBO(3, 9, 23, 1);

const TextStyle textTheme3 = TextStyle(color: white, fontSize: 22);
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
