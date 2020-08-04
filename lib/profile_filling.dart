import 'dart:io';
import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:style_of_agent/QA_Sections/q_one.dart';
//import 'package:style_of_agent/firebasemethods.dart';
import 'package:style_of_agent/model/usermodel.dart';
import 'package:style_of_agent/progress.dart';
import 'package:style_of_agent/utils/constants.dart';
//import 'package:style_of_agent/models/usermodel.dart';
import 'package:style_of_agent/extension/string_extension.dart';
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

//import 'package:video_player/video_player.dart';
import 'package:style_of_agent/utils/utils.dart';

class ProfileFilling extends StatefulWidget {
  FirebaseUser user;
  ProfileFilling({this.user});
  @override
  _ProfileFillingState createState() => _ProfileFillingState();
}

class _ProfileFillingState extends State<ProfileFilling> {
//  VideoPlayerController _controller;

  File _image;
  String image_url;
  String uid;
  final places = new GoogleMapsPlaces(apiKey: kGoogleApiKey);
//  Strin _selected = Country.NL;
  Country _selectedDialogCountry;

  List<String> add;

  GlobalKey<FormState> _key = new GlobalKey<FormState>();
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController phnoController = TextEditingController();
  TextEditingController locationController = TextEditingController();
//  TextEditingController interestController = TextEditingController();
//  TextEditingController heightController = TextEditingController();
//  TextEditingController weightController = TextEditingController();
  TextEditingController languageController =
      TextEditingController(text: language[0]);
//  TextEditingController skinToneController = TextEditingController();
  String gender = "Male";
  bool isgender = true;
  bool isfetch = false;
  static UserModel _userModel;

  FocusNode fnameNode = FocusNode();
  FocusNode lnameNode = FocusNode();
  FocusNode ageNode = FocusNode();
  FocusNode genderNode = FocusNode();
  FocusNode phnoNode = FocusNode();
  FocusNode locationNode = FocusNode();
  FocusNode languageNode = FocusNode();
  FocusNode interestNode = FocusNode();
  FocusNode skinToneNode = FocusNode();
  FocusNode heightNode = FocusNode();
  FocusNode weightNode = FocusNode();

  @override
  void initState() {
    super.initState();
    showPlace();

//    print(widget.user.email);
//    FirebaseMethods().getCurrentUser().then((value) {
    if (widget.user == null) {
//      FirebaseMethods().getCurrentUser().then((value) {
//        setState(() {
//          widget.user = value;
//        });
//      });

    }
    showUid().then((id) {
      setState(() {
        uid = id;
        print(uid);

        Firestore.instance.collection("users").document(id).get().then((value) {
          print(value);
          setState(() {
            isfetch = true;
            _userModel = UserModel.fromJson(value);
            print(_userModel.email);
            print(_userModel.toJson());

            _selectedDialogCountry = CountryPickerUtils.getCountryByPhoneCode(
                _userModel.phonenumber
                    .substring(1, _userModel.phonenumber.length - 10));
            phnoController.text = _userModel.phonenumber
                .substring(_userModel.phonenumber.length - 10);
            if (_userModel.profilename != null) {
              fnameController.text =
                  _userModel.profilename.split(" ").first.capitalize();
              lnameController.text =
                  _userModel.profilename.split(" ").last.capitalize();
            }
          });
        });
      });
    });
//    print("uid ${uid}");

//    });
  }

  Future<String> showUid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return (await prefs.getString("uid"));
//    setState(() {
//      uid = id;
//      print(id);
//      print("gg");
//    });
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

  showPlace() async {
//    Prediction p = await PlacesAutocomplete.show(
//        context: context,
//        apiKey: kGoogleApiKey,
//        mode: Mode.overlay, // Mode.fullscreen
//        language: "en",
//        components: [new Component(Component.country, "en")]);
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return SafeArea(
        child: Scaffold(
//      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: true,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(
          left: 20,
          right: 20.0,
        ),
        color: Color.fromRGBO(3, 9, 23, 1),
        child: Container(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: isfetch
                ? SingleChildScrollView(
                    child: Form(
                      key: _key,
                      child: Column(
//                          shrinkWrap: true,
//                          physics: AlwaysScrollableScrollPhysics(),
//                          reverse: true,
                          children: <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: SvgPicture.asset(
                                "assets/images/aoslogo.svg",
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Text(
                                  "<",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 40),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                "My Profile",
                                style: GoogleFonts.amiri(
                                  letterSpacing: 1.5,
                                  fontSize: 30,
                                  color: Color(0xFFc0a948),
//                                    fontFamily: "Helvetica"
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 10.0 * 10,
                              width: 10.0 * 10,
//                        margin: EdgeInsets.only(top: 10.0 * 3),
                              child: Stack(
                                children: <Widget>[
                                  CircleAvatar(
                                    radius: 10.0 * 5,
                                    backgroundImage: _image != null
                                        ? FileImage(_image)
                                        : _userModel.url != null
                                            ? NetworkImage(_userModel.url)
                                            : AssetImage(
                                                'assets/images/av.jpg'),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      showImageOption();
//                              openOptions();
                                    },
                                    child: Align(
                                      alignment: Alignment.bottomRight,
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
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10.0 * 2),
                            _userModel.profilename != null
                                ? Text(
                                    _userModel.profilename.capitalises(),
                                    style: GoogleFonts.workSans(
                                      fontSize: 17,
                                      color: Colors.white.withOpacity(0.7),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                : Container(),
                            SizedBox(height: 10.0 * 0.5),
                            Text(
                              _userModel.email,
                              style: GoogleFonts.workSans(
                                fontSize: 13,
                                color: Colors.grey,
                                fontWeight: FontWeight.w100,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              autofocus: false,
//                              enabled: true,
                              controller: fnameController,
                              cursorColor: Colors.grey,
                              keyboardType: TextInputType.text,
                              autocorrect: true,

                              validator: (String val) {
                                val = val.trim();
                                if (val.isEmpty) {
                                  return "Enter your first name";
                                }
                                return null;
                              },
//                              initialValue: name.split(" ").first,
                              focusNode: fnameNode,
                              onFieldSubmitted: (_) {
                                FocusScope.of(context).requestFocus(lnameNode);
                              },
                              onChanged: (val) {
//                                setState(() {
//                                  fnameController.text = val.trim();
//                                });
                              },
                              textInputAction: TextInputAction.next,
                              style: inputStyle,
//                    initialValue: _userModel.profilename.split(" ").first,
                              decoration: InputDecoration(
                                  focusedErrorBorder: errorBorder,
                                  border: labelBorder,
                                  labelText: "First name",
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
                              enabled: true,
                              controller: lnameController,
//                              initialValue: name.split(" ").last,
                              cursorColor: Colors.grey,
                              keyboardType: TextInputType.text,
//                    initialValue: _userModel.profilename.split(" ").last,
                              focusNode: lnameNode,
                              onFieldSubmitted: (_) {
                                FocusScope.of(context).requestFocus(ageNode);
                              },
                              textInputAction: TextInputAction.next,
                              style: inputStyle,
                              decoration: InputDecoration(
                                  focusedErrorBorder: errorBorder,
                                  border: labelBorder,
                                  labelText: "Last name",
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
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      print(fnameController.text.trim() +
                                          " " +
                                          lnameController.text.trim());
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
                                              lastDate: DateTime.now())
                                          .then((date) {
                                        setState(() {
                                          ageController.text = date
                                              .toIso8601String()
                                              .substring(0, 10);
                                          FocusScope.of(context)
                                              .requestFocus(genderNode);
                                        });
                                      });
                                    },
                                    icon: Icon(
                                      Icons.date_range,
                                      color: Colors.grey,
                                    ),
                                  ),
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
                                  child: DropdownButtonHideUnderline(
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
                                      items: <String>[
                                        'Male',
                                        'Female',
                                        'Prefer not to tell'
                                      ].map((String value) {
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
                              autofocus: false,
                              controller: locationController,
                              keyboardType: TextInputType.text,
                              validator: (String val) {
                                val = val.trim();
                                if (val.isEmpty) {
                                  return "Enter your location";
                                }
                                return null;
                              },
                              focusNode: locationNode,
                              onFieldSubmitted: (_) {
                                FocusScope.of(context)
                                    .requestFocus(languageNode);
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
                                    for (int i = 0;
                                        i < min(response.results.length, 5);
                                        i++) {
                                      pls.add(
                                          response.results[i].formattedAddress);
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
                                                  locationController.text =
                                                      add[i];
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
                                  child: DropdownButtonHideUnderline(
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
                                    _openCountryPickerDialog();
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
                                        if (str.length != 10 ||
                                            str.contains('.'))
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
                            RaisedButton(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 5),
                              shape: RoundedRectangleBorder(
//                          borderRadius: BorderRadius.all(Radius.circular(20)),
                                  side: BorderSide(
                                      color: Color(0xFFfb4545), width: 3)),
                              color: Color(0xFFfb4545),
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                if (_key.currentState.validate()) {
                                  String username =
                                      fnameController.text.trim().capitalize() +
                                          " " +
                                          lnameController.text;
                                  print(username);
                                  UserModel userPart1 = new UserModel(
                                    username: username.trim(),
                                    profilename: username.trim(),
                                    email: _userModel.email,
                                    phonenumber: '+' +
                                        _selectedDialogCountry.phoneCode +
                                        phnoController.text.trim(),
                                    url: _userModel.url,
                                    gender: gender,
                                    timestamp: _userModel.timestamp,
                                    location: locationController.text.trim(),
                                    birthdate: ageController.text.trim(),
                                    language: languageController.text.trim(),
                                  );
                                  print(userPart1.toJson());
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType
                                              .rightToLeftWithFade,
                                          child: ProfileFillingPart2(
                                            userModel: userPart1,
                                            image: _image,
                                            uid: uid,
                                          )));
                                }
                              },
//                        textColor: ,
                              child: Text(
                                "Next",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: "FreigSanPro",
                                    color: Colors.white),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ]),
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.pink,
                    ),
                  ),
          ),
        ),
      ),
    ));
  }

  @override
  void dispose() {
    super.dispose();
//    _controller.dispose();
  }
}
