import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:style_of_agent/QA_Sections/q_one.dart';
import 'package:style_of_agent/animated_menu/Library.dart';
import 'package:style_of_agent/animated_menu/menu_frame.dart';
import 'package:style_of_agent/animated_menu/recents_chats.dart';
import 'package:style_of_agent/animated_menu/style_diamonds.dart';
import 'package:style_of_agent/model/usermodel.dart';
import 'package:style_of_agent/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:style_of_agent/utils/constants.dart';
//import 'package:style_of_agent/models/usermodel.dart';
import 'package:style_of_agent/profile_filling_part_2.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:country_pickers/country.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_google_places/flutter_google_places.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isButtonPressed = true;
  bool isEditMeasrue = false;
  bool namebtn = false;
  bool agebtn = false;
  bool genbtn = false;
  bool professionalbtn = false;
  bool locationbtn = false;
  bool interestbtn = false;
  bool skinbtn = false;
  bool heightbtn = false;
  bool weightbtn = false;
  bool languagebtn = false;
  int _onTapped = 1;
  File _image;
  String image_url;
  String uid;
  final places = new GoogleMapsPlaces(apiKey: kGoogleApiKey);
//  Strin _selected = Country.NL;
  Country _selectedDialogCountry;
  UserModel userModel;

  List<String> add;

  GlobalKey<FormState> _key = new GlobalKey<FormState>();
  TextEditingController nameController =
      TextEditingController(text: 'Nicolas Adams');
  TextEditingController ageController = TextEditingController();
  TextEditingController genderController = TextEditingController(text: 'male');
  TextEditingController professionalController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController interestController = TextEditingController();
  TextEditingController phnoController = TextEditingController();
//  TextEditingController heightController = TextEditingController();
//  TextEditingController weightController = TextEditingController();
  TextEditingController languageController =
      TextEditingController(text: "Hindi");
//  TextEditingController skinToneController = TextEditingController();
  String gender = "Male";
  bool isgender = true;
  bool isLoad = false;

  FocusNode nameNode = FocusNode();
  FocusNode ageNode = FocusNode();
  FocusNode genderNode = FocusNode();
  FocusNode phnoNode = FocusNode();
  FocusNode professionalNode = FocusNode();
  FocusNode locationNode = FocusNode();
  FocusNode languageNode = FocusNode();
  FocusNode interestNode = FocusNode();
//  FocusNode skinToneNode = FocusNode();
//  FocusNode heightNode = FocusNode();
//  FocusNode weightNode = FocusNode();
  bool isEnable = false;

  List<String> language = [
    "Arabic",
    "Chinese",
    "Dutch",
    "English",
    "Finnish",
    "French",
    "German",
    "Hindi",
    "Italian",
    "Japanese",
    "Portuguese",
    "Russian",
    "Spanish",
    "Swedish",
  ];

  // For Measurement
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
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoad = true;
    showUid();
  }

  showUid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoad = true;
    });
    String id = prefs.getString("uid");
    Firestore.instance.collection("users").document(id).get().then((value) {
      setState(() {
        isLoad = false;
        print("uid    ${id}");
        uid = id;
        userModel = UserModel.fromJson(value);
        _selectedDialogCountry = CountryPickerUtils.getCountryByPhoneCode(
            userModel.phonenumber
                .substring(1, userModel.phonenumber.length - 10));
        userModel = UserModel.fromJson(value);
        nameController = TextEditingController(text: userModel.username);
        ageController = TextEditingController(text: userModel.birthdate);
        genderController = TextEditingController(text: userModel.gender);
        locationController = TextEditingController(text: userModel.location);
        phnoController = TextEditingController(
            text: userModel.phonenumber
                .substring(userModel.phonenumber.length - 10));
        languageController = TextEditingController(text: userModel.language);
        clothController = TextEditingController(text: userModel.clothingsize);
        bustController = TextEditingController(text: userModel.bustsize);
        waistController = TextEditingController(text: userModel.waistsize);
        hipController = TextEditingController(text: userModel.hipsize);
        shoeController = TextEditingController(text: userModel.shoesize);
        heightController = TextEditingController(text: userModel.height);
        weightController = TextEditingController(text: userModel.weight);
      });
    });
  }

  buildEditMeasurement() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        TextFormField(
          autofocus: false,
          controller: heightController,
          cursorColor: Colors.grey,
          enabled: isEditMeasrue,
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
              labelText: "Height",
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
          enabled: isEditMeasrue,
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
              labelText: "Weight",
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
          enabled: isEditMeasrue,
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
              labelText: "Clothing Size",
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
          enabled: isEditMeasrue,
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
              labelText: "Bust Size",
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
          enabled: isEditMeasrue,
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
              labelText: "Waist Size",
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
          enabled: isEditMeasrue,
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
              labelText: "Hip Size",
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
          enabled: isEditMeasrue,
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
              labelText: "Shoe Size",
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
    );
  }

  buildProfileDetails() {
    return Column(
      children: <Widget>[
        TextFormField(
          autofocus: false,
          enabled: isEnable,
          controller: nameController,
          cursorColor: Colors.grey,
          validator: (String val) {
            val = val.trim();
            if (val.isEmpty) {
              return "Enter your name";
            }
            return null;
          },
          onTap: () {
            setState(() {
              namebtn = true;
              agebtn = false;
              genbtn = false;
              professionalbtn = false;
              locationbtn = false;
              interestbtn = false;
              skinbtn = false;
              heightbtn = false;
              weightbtn = false;
            });
          },
          focusNode: nameNode,
          onFieldSubmitted: (_) {
            FocusScope.of(context).requestFocus(ageNode);
          },
          textInputAction: TextInputAction.next,
          style: inputStyle,
          decoration: InputDecoration(
              focusedErrorBorder: errorBorder,
              border: labelBorder,
              labelText: "Name",
              labelStyle: labelStyle,
              errorBorder: errorBorder,
              enabledBorder: labelBorder,
              enabled: true,
              focusedBorder: labelBorder,
              focusColor: Color(0xFF251f2d),
              filled: true,
              fillColor:
                  isEnable && namebtn ? Color(0xFF251f2d) : Color(0xff1e1b24),
              errorStyle: errorStyle),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          enabled: isEnable,
          autofocus: false,
          controller: ageController,
          keyboardType: TextInputType.datetime,
          cursorColor: Colors.grey,
          validator: (String val) {
            val = val.trim();
            if (val.isEmpty) {
              return "Enter your birth date";
            } else if (val.length != 10) {
              return "Enter valid birth date";
            }
            return null;
          },
          focusNode: ageNode,
          onFieldSubmitted: (_) {
            FocusScope.of(context).requestFocus(genderNode);
          },
          textInputAction: TextInputAction.next,
          style: inputStyle,
//                              onTap: () {
//                                showDatePicker(
//                                        context: context,
//                                        initialDate: DateTime.now(),
//                                        firstDate: DateTime(1940),
//                                        lastDate: DateTime(2050))
//                                    .then((date) {
//                                  setState(() {
//                                    ageController.text =
//                                        date.toIso8601String().substring(0, 10);
//                                  });
//                                });
//                              },
          decoration: InputDecoration(
              suffixIcon: isEnable
                  ? IconButton(
                      onPressed: () {
//                  print(fnameController.text.trim() +
//                      " " +
//                      lnameController.text.trim());
//                                      Firestore.instance
//                                          .collection("users")
//                                          .document(widget.user.uid)
//                                          .updateData({
//                                        UserModel.PROFILE_NAME_KEY:
//                                            fnameController.text.trim() +
//                                                " " +
//                                                lnameController.text.trim()
//                                      });

                        showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1940),
                                lastDate: DateTime(2050))
                            .then((date) {
                          setState(() {
                            ageController.text =
                                date.toIso8601String().substring(0, 10);
                            FocusScope.of(context).requestFocus(genderNode);
                          });
                        });
                      },
                      icon: Icon(
                        Icons.date_range,
                        color: Colors.grey,
                      ),
                    )
                  : null,
              border: labelBorder,
              labelText: "Date of birth",
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
        FormField<String>(
          enabled: isEnable,
          builder: (FormFieldState<String> state) {
            return InputDecorator(
              isHovering: true,
              decoration: InputDecoration(
                  border: labelBorder,
                  labelText: "Gender",
                  labelStyle: labelStyle,
                  errorBorder: errorBorder,
                  enabledBorder: labelBorder,
                  hintText: "Gender",
                  enabled: true,
                  focusedBorder: labelBorder,
                  focusColor: Color(0xFF251f2d),
                  filled: true,
                  fillColor: Color(0xff1e1b24),
                  errorStyle: errorStyle),
              isEmpty: gender == '',
              child: !isEnable
                  ? Text(
                      gender,
                      style: inputStyle,
                    )
                  : DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        dropdownColor: Color(0xFF272727),
                        value: gender,
                        isDense: true,

                        onChanged: (String newValue) {
                          setState(() {
                            gender = newValue;
                            state.didChange(newValue);
                          });
                        },
                        style: inputStyle,

//                              hint: Text(
//                                "Language",
//                                style: inputStyle,
//                              ),
                        items: <String>['Male', 'Female', 'Prefer Not To Tell']
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
//                                    style: inputStyle,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
            );
          },
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          enabled: isEnable,
          autofocus: false,
          controller: locationController,
//                    keyboardType: TextInputType.text,
          validator: (String val) {
            val = val.trim();
            if (val.isEmpty) {
              return "Enter your location";
            }
            return null;
          },
          focusNode: locationNode,
          onFieldSubmitted: (_) {
            FocusScope.of(context).requestFocus(languageNode);
          },
          textInputAction: TextInputAction.next,
          cursorColor: Colors.grey,
          style: inputStyle,
          decoration: InputDecoration(
              border: labelBorder,
              labelText: "Location",
              labelStyle: labelStyle,
              errorBorder: errorBorder,
              enabledBorder: labelBorder,
              enabled: true,
              focusedBorder: labelBorder,
              focusColor: Color(0xFF251f2d),
              filled: true,
              fillColor: Color(0xff1e1b24),
              errorStyle: errorStyle),

          onChanged: (String val) async {
            if (val.isEmpty) {
              setState(() {
                add = null;
              });
            } else {
              List<String> pls = List();
              PlacesSearchResponse response =
                  await places.searchByText(val.trim());
              if (response.status == "OK") {
                for (int i = 0; i < min(response.results.length, 5); i++) {
                  pls.add(response.results[i].formattedAddress);
                }
                print(add);
                setState(() {
                  add = pls;
                });
              } else {
                print("error");
              }
            }
          },
        ),
        add != null
            ? Container(
                padding: EdgeInsets.all(15),
                color: Colors.black,
                child: ListView.builder(
                  itemCount: add.length,
                  itemBuilder: (context, i) {
                    return Column(
                      children: <Widget>[
                        GestureDetector(
                            onTap: () {
                              locationController.text = add[i];
                              setState(() {
                                add = null;
                              });
                            },
                            child: Text(
                              add[i],
                              style: inputStyle,
                            )),
                        SizedBox(
                          height: 5,
                        ),
                        Divider(
                          color: Colors.white,
                          thickness: 2,
                        )
                      ],
                    );
                  },
                  shrinkWrap: true,
                ),
              )
            : Container(),
        SizedBox(
          height: 10,
        ),
        FormField<String>(
          enabled: isEnable,
          builder: (FormFieldState<String> state) {
            return InputDecorator(
              isHovering: true,
              decoration: InputDecoration(
                  border: labelBorder,
                  labelText: "Language",
                  labelStyle: labelStyle,
                  errorBorder: errorBorder,
                  enabledBorder: labelBorder,
                  hintText: "Language",
                  enabled: true,
                  focusedBorder: labelBorder,
                  focusColor: Color(0xFF251f2d),
                  filled: true,
                  fillColor: Color(0xff1e1b24),
                  errorStyle: errorStyle),
              isEmpty: languageController.text == '',
              child: !isEnable
                  ? Text(
                      languageController.text,
                      style: inputStyle,
                    )
                  : DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        dropdownColor: Color(0xFF272727),
                        value: languageController.text,
                        isDense: true,

                        onChanged: (String newValue) {
                          setState(() {
                            languageController.text = newValue;
                            state.didChange(newValue);
                            print(languageController.text);
                          });
                        },
                        style: inputStyle,
//                              hint: Text(
//                                "Language",
//                                style: inputStyle,
//                              ),
                        items: language.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
//                                    style: inputStyle,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
            );
          },
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                isEnable ? _openCountryPickerDialog() : null;
              },
              child: Row(
                children: <Widget>[
                  CountryPickerUtils.getDefaultFlagImage(
                      _selectedDialogCountry),
                  SizedBox(width: 8.0),
                  Text(
                    "+${_selectedDialogCountry.phoneCode}",
                    style: inputStyle,
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    color: Colors.grey,
                  )
                ],
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: TextFormField(
                enabled: isEnable,
                autofocus: false,
//                          initialValue: _userModel.phonenumber
//                              .substring(_userModel.phonenumber.length - 10),
                controller: phnoController,
                keyboardType: TextInputType.phone,
                validator: (str) {
                  str = str.trim();
                  if (str.isEmpty || str.length == 0)
                    return 'Enter Phone Number';
                  else {
                    if (str.length != 10 || str.contains('.'))
                      return 'Enter Valid Phone Number';
                  }
                  return null;
                },
                focusNode: phnoNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).unfocus();
                },
                textInputAction: TextInputAction.done,
                cursorColor: Colors.grey,
                style: inputStyle,
                decoration: InputDecoration(
                    border: labelBorder,
                    labelText: "Phone number",
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
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  showImageOption() async {
//    showSearch(context: null, delegate: null)
    showModalBottomSheet(
        backgroundColor: Colors.white12,
        shape: RoundedRectangleBorder(),
        context: context,
        builder: (context) {
          return Container(
//            color: Colors.black,
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
//              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                ListTile(
                  leading: Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Camera",
                    style: GoogleFonts.workSans(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                  onTap: () async {
                    await ImagePicker.pickImage(source: ImageSource.camera)
                        .then((image) {
                      setState(() {
                        Navigator.pop(context);
                        _image = image;
                      });
                      print("image${_image}");
                    });
                  },
                ),
                Divider(
                  color: Colors.white,
                  thickness: 2,
                ),
                ListTile(
                  leading: Icon(
                    Icons.photo_library,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Gallery",
                    style: GoogleFonts.workSans(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                  onTap: () async {
                    await ImagePicker.pickImage(source: ImageSource.gallery)
                        .then((image) {
                      setState(() {
                        Navigator.pop(context);
                        _image = image;
                      });
                      print("image${_image}");
                    });
                  },
                ),
                _image != null
                    ? Divider(
                        color: Colors.white,
                        thickness: 2,
                      )
                    : Container(),
                _image != null
                    ? ListTile(
                        leading: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                        title: Text(
                          "Remove",
                          style: GoogleFonts.workSans(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                        onTap: () {
                          setState(() {
                            Navigator.pop(context);
                            _image = null;
                          });
                          print("image${_image}");
                        },
                      )
                    : Container(),
              ],
            ),
          );
        });
  }

  Widget _buildDialogItem(Country country) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CountryPickerUtils.getDefaultFlagImage(country),
//          SizedBox(width: 8.0),
          Flexible(
              child: Text(
            country.name,
            textAlign: TextAlign.center,
          )),
//          Expanded(
//            child: Container(),
//          ),
          Text("+${country.phoneCode}"),
        ],
      );

  void _openCountryPickerDialog() => showDialog(
        context: context,
        builder: (context) => Theme(
          data: Theme.of(context).copyWith(primaryColor: Colors.pink),
          child: CountryPickerDialog(
            titlePadding: EdgeInsets.all(8.0),
            searchCursorColor: Colors.pinkAccent,
            searchInputDecoration: InputDecoration(hintText: 'Search...'),
            isSearchable: true,
            title: Text('Select your phone code'),
            onValuePicked: (Country country) =>
                setState(() => _selectedDialogCountry = country),
            itemBuilder: _buildDialogItem,
            priorityList: [
              CountryPickerUtils.getCountryByIsoCode('TR'),
              CountryPickerUtils.getCountryByIsoCode('US'),
            ],
          ),
        ),
      );

  Future uploadFile() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('${DateTime.now().millisecondsSinceEpoch}.jpg');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    storageReference.getDownloadURL().then((fileURL) async {
      setState(() {
//        isLoading = false;
        print("file${fileURL}");
        image_url = fileURL;

//        Navigator.pop(context);
      });
      UserModel umodel = new UserModel(
        username: userModel.username,
        profilename: userModel.profilename,
        phonenumber: userModel.phonenumber,
        gender: userModel.gender,
        location: userModel.location,
        birthdate: userModel.birthdate,
        language: userModel.language,
        email: userModel.email,
        url: image_url,
        height: heightController.text.trim(),
        weight: weightController.text.trim(),
        clothingsize: clothController.text.trim(),
        bustsize: bustController.text.trim(),
        waistsize: waistController.text.trim(),
        hipsize: hipController.text.trim(),
        isprofileshow: true,
        id: uid,
        timestamp: userModel.timestamp,
        isphoneverified: userModel.isphoneverified,
        shoesize: shoeController.text.trim(),
      );
      print(umodel.toJson());

      try {
        await Firestore.instance
            .collection("users")
            .document(uid)
            .updateData(umodel.toJson());
      } on PlatformException catch (e) {
        print(e.message);
      }
      setState(() {
        userModel = umodel;
        isEnable = false;

        namebtn = false;
        agebtn = false;
        genbtn = false;
        professionalbtn = false;
        locationbtn = false;
        interestbtn = false;
        skinbtn = false;
        heightbtn = false;
        weightbtn = true;
        languagebtn = false;
        isEditMeasrue = false;
        _image = null;
      });

//      setState(() {
//        isLoading = false;
//        Navigator.push(
//            context,
//            PageTransition(
//                type: PageTransitionType.rightToLeftWithFade, child: QueOne()));
//      });

//      updateDP();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        color: Color(0xff4527a0),
        child: !isLoad
            ? SafeArea(
                child: Scaffold(
                  drawerEnableOpenDragGesture: true,
                  resizeToAvoidBottomPadding: true,
                  backgroundColor: Color.fromRGBO(3, 9, 23, 1),
                  appBar: PreferredSize(
                      child: Container(
                        height: 250,
                        child: Stack(children: <Widget>[
//                ClipPath(
//                    clipBehavior: Clip.hardEdge,
//                    clipper: shadowHeader(),
//                    child: Container(
//                      color: Color(0xffd1c4e9),
//                    )),
                          CustomPaint(
                            painter: BoxShadowPainter(),
                            child: ClipPath(
                                clipBehavior: Clip.hardEdge,
                                clipper: TopHeader(),
                                child: Container(
                                  color: Color(0xff4527a0),
                                )),
                          ),
//                          Align(
//                            alignment: Alignment.topLeft,
//                            child: Padding(
//                              padding:
//                                  const EdgeInsets.only(top: 20.0, left: 17.0),
//                              child: GestureDetector(
//                                onTap: () {
//                                  Navigator.pop(context);
//                                },
//                                child: Icon(
//                                  Icons.arrow_back,
//                                  color: Color(0xFFc0a948),
//                                ),
//                              ),
//                            ),
//                          ),
                          !isEnable
                              ? !isEditMeasrue
                                  ? Align(
                                      alignment: Alignment.topRight,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 20.0, right: 13.0),
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              isEnable = !isEnable;
                                            });
                                          },
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: <Widget>[
                                              Icon(
                                                Icons.edit,
                                                color: Color(0xFFc0a948),
                                              ),
                                              Text(
                                                "Edit",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Color(0xFFc0a948),
                                                    fontFamily: "FreigSanPro"),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container()
                              : Container(),
                          Positioned(
                            top: 125,
                            left: MediaQuery.of(context).size.width / 7,
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  child: CircleAvatar(
                                    radius: 10.0 * 5,
                                    backgroundImage: _image != null
                                        ? FileImage(_image)
                                        : userModel.url != null
                                            ? NetworkImage(userModel.url)
                                            : AssetImage(
                                                'assets/images/av.jpg'),
                                  ),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Colors.white, width: 1)),
                                ),
                                isEnable
                                    ? Positioned(
                                        top: 70,
                                        left: 70,
                                        child: GestureDetector(
                                          onTap: () {
                                            showImageOption();
                                          },
                                          child: Container(
                                            height: 10.0 * 2.5,
                                            width: 10.0 * 2.5,
                                            decoration: BoxDecoration(
                                              color: Color(0xFFFFC107),
                                              shape: BoxShape.circle,
                                            ),
                                            child: Center(
                                              heightFactor: 10.0 * 1.5,
                                              widthFactor: 10.0 * 1.5,
                                              child: Icon(
                                                Icons.edit,
                                                color: Color(0xFF212121),
                                                size: 10.0 * 1.5,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 115,
                            left: 3 * MediaQuery.of(context).size.width / 6,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  nameController.text,
                                  style: GoogleFonts.amiri(
                                    fontSize: 17,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 10.0 * 0.5),
                                Text(
                                  userModel.email,
                                  style: GoogleFonts.amiri(
                                    fontSize: 13,
                                    color: Colors.white.withOpacity(0.9),
                                    fontWeight: FontWeight.w100,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 20,
                            left: MediaQuery.of(context).size.width / 3.3,
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Text(
                                "My Profile",
                                style: GoogleFonts.amiri(
                                  letterSpacing: 2,
                                  fontSize: 30,
                                  color: Color(0xFFc0a948),
//                                  fontFamily: "Helvetica",
                                ),
                              ),
                            ),
                          ),
                        ]),
                      ),
                      preferredSize:
                          Size(MediaQuery.of(context).size.width, 250)),

//      ),
                  body: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                      physics: ScrollPhysics(),
                      child: Column(
//              crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Form(
                                  key: _key,
                                  child: isEditMeasrue
                                      ? buildEditMeasurement()
                                      : buildProfileDetails(),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                isEnable || isEditMeasrue
                                    ? RaisedButton(
                                        padding: EdgeInsets.all(15),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                            side: BorderSide(
                                                color: Color(0xFFfb4545),
                                                width: 3)),
                                        color: Color(0xFFfb4545),
                                        onPressed: () async {
                                          FocusScope.of(context).unfocus();
                                          if (_key.currentState.validate()) {
                                            print(uid);
                                            print("_image ${_image}");
                                            if (_image != null) {
                                              await uploadFile();
//                                              setState(() {
//                                                _image = null;
//                                              });
                                            } else {
                                              UserModel umodel = new UserModel(
                                                id: uid,

                                                username: nameController.text,
                                                email: userModel.email,
                                                phonenumber: '+' +
                                                    _selectedDialogCountry
                                                        .phoneCode +
                                                    phnoController.text.trim(),
                                                gender: gender,
                                                timestamp: userModel.timestamp,
                                                location: locationController
                                                    .text
                                                    .trim(),
                                                birthdate:
                                                    ageController.text.trim(),
                                                language: languageController
                                                    .text
                                                    .trim(),
                                                url: userModel.url,
                                                height: heightController.text
                                                    .trim(),
                                                weight: weightController.text
                                                    .trim(),
                                                clothingsize:
                                                    clothController.text.trim(),
                                                bustsize:
                                                    bustController.text.trim(),
                                                waistsize:
                                                    waistController.text.trim(),
                                                hipsize:
                                                    hipController.text.trim(),
                                                isprofileshow: true,

                                                profilename:
                                                    nameController.text,
//                                          id: uid,
                                                isphoneverified: true,
                                                shoesize:
                                                    shoeController.text.trim(),
                                              );
                                              try {
                                                await Firestore.instance
                                                    .collection("users")
                                                    .document(uid)
                                                    .updateData(
                                                        umodel.toJson());
                                              } on PlatformException catch (e) {
                                                print(e.message);
                                              }
                                              setState(() {
                                                userModel = umodel;
                                                isEnable = false;

                                                namebtn = false;
                                                agebtn = false;
                                                genbtn = false;
                                                professionalbtn = false;
                                                locationbtn = false;
                                                interestbtn = false;
                                                skinbtn = false;
                                                heightbtn = false;
                                                weightbtn = true;
                                                languagebtn = false;
                                                isEditMeasrue = false;
                                              });
                                            }
                                          }
//                                    if (gender.isEmpty) {
//                                      setState(() {
//                                        isgender = false;
//                                      });
//                                    }

//                            Navigator.push(
//                                context,
//                                PageTransition(
//                                    type: PageTransitionType.rightToLeftWithFade,
//                                    child: QueOne()));
                                        },
//                        textColor: ,
                                        child: Text(
                                          !isEditMeasrue
                                              ? "Profile Update"
                                              : "Measurement Update",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: "FreigSanPro",
                                              fontWeight: FontWeight.bold
//                                              fontWeight: FontWeight.w500
                                              ),
                                        ),
                                      )
                                    : RaisedButton(
                                        padding: EdgeInsets.all(15),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                            side: BorderSide(
                                                color: Color(0xFFfb4545),
                                                width: 3)),
                                        color: Color(0xFFfb4545),
                                        onPressed: () {
                                          FocusScope.of(context).unfocus();
                                          if (_key.currentState.validate() &&
                                              gender.isNotEmpty) {}
//                                    if (gender.isEmpty) {
//                                      setState(() {
//                                        isgender = false;
//                                      });
//                                    }
                                          setState(() {
                                            isEnable = false;

                                            namebtn = false;
                                            agebtn = false;
                                            genbtn = false;
                                            professionalbtn = false;
                                            locationbtn = false;
                                            interestbtn = false;
                                            skinbtn = false;
                                            heightbtn = false;
                                            weightbtn = true;
                                            languagebtn = false;
                                            isEditMeasrue = true;
                                          });
//                            Navigator.push(
//                                context,
//                                PageTransition(
//                                    type: PageTransitionType.rightToLeftWithFade,
//                                    child: QueOne()));
                                        },
//                        textColor: ,
                                        child: Text(
                                          "Edit Measurements",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: "FreigSanPro",
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                isEnable
                                    ? SizedBox(
                                        height: 25,
                                      )
                                    : SizedBox(
                                        height: 15,
                                      )
                              ],
                            ),
                          ),
//                  ],
//                ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : Container(),
      ),
    );
  }
}

class TopHeader extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    var path = Path()
      ..lineTo(0.0, 170)
      ..quadraticBezierTo(size.width / 4, 150, size.width / 2, 200)
      ..quadraticBezierTo(3 * size.width / 4, 250, size.width, 240)
      ..lineTo(size.width, 0.0)
      ..close();
//    throw UnimplementedError();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}

class shadowHeader extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    var path = Path()
      ..lineTo(0.0, 171)
      ..quadraticBezierTo(size.width / 4, 151, size.width / 2, 201)
      ..quadraticBezierTo(3 * size.width / 4, 251, size.width, 241)
      ..lineTo(size.width, 0.0)
      ..close();
//    throw UnimplementedError();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}

class BoxShadowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var path = Path()
      ..lineTo(0.0, 170)
      ..quadraticBezierTo(size.width / 4, 150, size.width / 2, 200)
      ..quadraticBezierTo(3 * size.width / 4, 250, size.width, 240)
      ..lineTo(size.width, 0.0)
      ..close();
//    throw UnimplementedError();

    canvas.drawShadow(path, Color(0xff7e57c2), 5.0, false);
//    canvas.drawShadow(path, color, elevation, transparentOccluder)
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class Style extends StyleHook {
  @override
  double get activeIconSize => 30;

  @override
  double get activeIconMargin => 10;

  @override
  double get iconSize => 20;

  @override
  TextStyle textStyle(Color color) {
    return TextStyle(fontSize: 20, color: color);
  }
}
