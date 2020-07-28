import 'package:flutter/material.dart';

showAlertDialog(BuildContext context,String msg){
  AlertDialog alert=AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    backgroundColor: Colors.black54,
    content: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFFc0a948)),
        backgroundColor: Colors.white,),
        SizedBox(
          height: 20.0,
        ),
        Text("$msg" ,style:TextStyle(
          fontFamily: "Helvetica",
          color: Colors.white,
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
        ),),
      ],),
  );
  showDialog(barrierDismissible: false,
    context:context,
    builder:(BuildContext context){
      return alert;
    },
  );
}