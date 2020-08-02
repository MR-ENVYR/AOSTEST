import 'package:flutter/material.dart';
import 'package:style_of_agent/model/usermodel.dart';
import 'package:style_of_agent/utils/utils.dart';

class EditMeasurement extends StatefulWidget {
  String uid;
  UserModel userModel;
  EditMeasurement({this.userModel, this.uid});
  @override
  _EditMeasurementState createState() => _EditMeasurementState();
}

class _EditMeasurementState extends State<EditMeasurement> {
  GlobalKey<FormState> _key1 = new GlobalKey<FormState>();
  TextEditingController clothController = TextEditingController();
  TextEditingController bustController = TextEditingController();
  TextEditingController waistController = TextEditingController();
  TextEditingController hipController = TextEditingController();
  TextEditingController shoeController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  FocusNode clothNode = FocusNode();
  FocusNode bustNode = FocusNode();
  FocusNode waistNode = FocusNode();
  FocusNode hipNode = FocusNode();
  FocusNode shoeNode = FocusNode();
  FocusNode heightNode = FocusNode();
  FocusNode weightNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key1,
      child: Column(
        children: <Widget>[
          TextFormField(
            autofocus: false,
            controller: heightController,
            cursorColor: Colors.grey,
            validator: (String val) {
              val = val.trim();
              if (val.isEmpty) {
                return "Enter your height";
              }
              return null;
            },
            focusNode: heightNode,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(weightNode);
            },
            textInputAction: TextInputAction.next,
            style: inputStyle,
            decoration: InputDecoration(
                focusedErrorBorder: errorBorder,
                border: labelBorder,
                labelText: "Height(in cm)",
                labelStyle: labelStyle,
                errorBorder: errorBorder,
                enabledBorder: labelBorder,
                enabled: true,
                focusedBorder: labelBorder,
                focusColor: Color(0xFFffffff),
                filled: true,
                fillColor: Color(0xff1e1b24),
                errorStyle: errorStyle),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            autofocus: false,
            controller: weightController,
            cursorColor: Colors.grey,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            focusNode: weightNode,
            validator: (String val) {
              if (val.isEmpty) {
                return "Enter your weight";
              }
              return null;
            },
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(clothNode);
            },
            textInputAction: TextInputAction.next,
            style: inputStyle,
            decoration: InputDecoration(
                focusedErrorBorder: errorBorder,
                border: labelBorder,
                labelText: "Weight(in cm)",
                labelStyle: labelStyle,
                errorBorder: errorBorder,
                enabledBorder: labelBorder,
                enabled: true,
                focusedBorder: labelBorder,
                focusColor: Color(0xFFffffff),
                filled: true,
                fillColor: Color(0xff1e1b24),
                errorStyle: errorStyle),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            autofocus: false,
            controller: clothController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
//                    keyboardType: TextInputType.text,
            validator: (String val) {
              val = val.trim();
              if (val.isEmpty) {
                return "Enter your clothing size";
              }
              return null;
            },
            focusNode: clothNode,
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(bustNode);
            },
            textInputAction: TextInputAction.next,
            cursorColor: Colors.grey,
            style: inputStyle,
            decoration: InputDecoration(
                border: labelBorder,
                labelText: "Clothing Size(in cm)",
                labelStyle: labelStyle,
                errorBorder: errorBorder,
                enabledBorder: labelBorder,
                enabled: true,
                focusedBorder: labelBorder,
                focusColor: Color(0xFF251f2d),
                filled: true,
                fillColor: Color(0xff1e1b24),
                errorStyle: errorStyle),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            autofocus: false,

            keyboardType: TextInputType.numberWithOptions(decimal: true),
            controller: bustController,
//                    keyboardType: TextInputType.text,
            validator: (String val) {
              val = val.trim();
              if (val.isEmpty) {
                return "Enter your bust size";
              }
              return null;
            },
            focusNode: bustNode,
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(waistNode);
            },
            textInputAction: TextInputAction.next,
            cursorColor: Colors.grey,
            style: inputStyle,
            decoration: InputDecoration(
                border: labelBorder,
                labelText: "Bust Size(in cm)",
                labelStyle: labelStyle,
                errorBorder: errorBorder,
                enabledBorder: labelBorder,
                enabled: true,
                focusedBorder: labelBorder,
                focusColor: Color(0xFF251f2d),
                filled: true,
                fillColor: Color(0xff1e1b24),
                errorStyle: errorStyle),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            autofocus: false,
            controller: waistController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
//                      keyboardType: TextInputType.phone,
            validator: (String val) {
              val = val.trim();
              if (val.isEmpty) {
                return "Enter your waist size";
              }
              return null;
            },
            focusNode: waistNode,
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(hipNode);
            },
            textInputAction: TextInputAction.next,
            cursorColor: Colors.grey,
            style: inputStyle,
            decoration: InputDecoration(
                border: labelBorder,
                labelText: "Waist Size(in cm)",
                labelStyle: labelStyle,
                errorBorder: errorBorder,
                enabledBorder: labelBorder,
                enabled: true,
                focusedBorder: labelBorder,
                focusColor: Color(0xFF251f2d),
                filled: true,
                fillColor: Color(0xff1e1b24),
                errorStyle: errorStyle),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            autofocus: false,
            controller: hipController,
//                    keyboardType: TextInputType.text,
            validator: (String val) {
              val = val.trim();
              if (val.isEmpty) {
                return "Enter your hip size";
              }
              return null;
            },
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            focusNode: hipNode,
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(shoeNode);
            },
            textInputAction: TextInputAction.next,
            cursorColor: Colors.grey,
            style: inputStyle,
            decoration: InputDecoration(
                border: labelBorder,
                labelText: "Hip Size(in cm)",
                labelStyle: labelStyle,
                errorBorder: errorBorder,
                enabledBorder: labelBorder,
                enabled: true,
                focusedBorder: labelBorder,
                focusColor: Color(0xFF251f2d),
                filled: true,
                fillColor: Color(0xff1e1b24),
                errorStyle: errorStyle),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            autofocus: false,
            controller: shoeController,
//                    keyboardType: TextInputType.text,
            validator: (String val) {
              val = val.trim();
              if (val.isEmpty) {
                return "Enter your shoe size";
              }
              return null;
            },
            focusNode: shoeNode,
            onFieldSubmitted: (_) {
              FocusScope.of(context).unfocus();
            },
            textInputAction: TextInputAction.done,
            cursorColor: Colors.grey,
            style: inputStyle,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
                border: labelBorder,
                labelText: "Shoe Size(in cm)",
                labelStyle: labelStyle,
                errorBorder: errorBorder,
                enabledBorder: labelBorder,
                enabled: true,
                focusedBorder: labelBorder,
                focusColor: Color(0xFF251f2d),
                filled: true,
                fillColor: Color(0xff1e1b24),
                errorStyle: errorStyle),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
