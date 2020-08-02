import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:style_of_agent/QA_Sections/q_one.dart';
import 'package:style_of_agent/model/usermodel.dart';
import 'package:style_of_agent/progress.dart';
//import 'package:style_of_agent/models/usermodel.dart';
import 'package:style_of_agent/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileFillingPart2 extends StatefulWidget {
  UserModel userModel;
//  FirebaseUser currentuser;
  String uid;
  File image;
  ProfileFillingPart2({this.userModel, this.image, this.uid});

  @override
  _ProfileFillingPart2State createState() => _ProfileFillingPart2State();
}

class _ProfileFillingPart2State extends State<ProfileFillingPart2> {
  GlobalKey<FormState> _key = new GlobalKey<FormState>();
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

  String image_url;
  File _image;
  bool isLoading = false;

  static final Firestore firestore = Firestore.instance;
  static final CollectionReference _userCollection =
      firestore.collection("users");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _image = widget.image;
    });
    print(widget.uid);
  }

  Future uploadFile() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('${DateTime.now().millisecondsSinceEpoch}.jpg');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    storageReference.getDownloadURL().then((fileURL) async {
      setState(() {
        isLoading = false;
        print("file${fileURL}");
        image_url = fileURL;
//        Navigator.pop(context);
      });
      UserModel user = new UserModel(
        username: widget.userModel.username,
        profilename: widget.userModel.profilename,
        phonenumber: widget.userModel.phonenumber,
        gender: widget.userModel.gender,
        location: widget.userModel.location,
        birthdate: widget.userModel.birthdate,
        language: widget.userModel.language,
        email: widget.userModel.email,
        url: image_url,
        height: heightController.text.trim(),
        weight: weightController.text.trim(),
        clothingsize: clothController.text.trim(),
        bustsize: bustController.text.trim(),
        waistsize: waistController.text.trim(),
        hipsize: hipController.text.trim(),
        isprofileshow: true,
        id: widget.uid,
        timestamp: widget.userModel.timestamp,
        isphoneverified: widget.userModel.isphoneverified,
        shoesize: shoeController.text.trim(),
      );
      print(user.toJson());
      try {
        await _userCollection.document(widget.uid).updateData(user.toJson());
      } on PlatformException catch (e) {
        print(e.message);
      }
      setState(() {
        isLoading = false;
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeftWithFade, child: QueOne()));
      });

//      updateDP();
    });
  }

  showImageOption() async {
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: true,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 20),
                color: Color.fromRGBO(3, 9, 23, 1),
                child: Form(
                  key: _key,
                  child: SingleChildScrollView(
                    child: Column(
//                  shrinkWrap: true,
//              crossAxisAlignment: CrossAxisAlignment.center,
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
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Align(
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
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "My Measurement",
                            style: GoogleFonts.amiri(
                              letterSpacing: 1.5,
                              fontSize: 30,
                              color: Color(0xFFc0a948),
//                                fontFamily: "Helvetica"
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
                                    : widget.userModel.url != null
                                        ? NetworkImage(widget.userModel.url)
                                        : AssetImage('assets/images/av.jpg'),
                              ),
                              GestureDetector(
                                onTap: () {
                                  showImageOption();
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
                        Text(
                          widget.userModel.profilename,
                          style: GoogleFonts.workSans(
                            fontSize: 17,
                            color: Colors.white.withOpacity(0.7),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 10.0 * 0.5),
                        Text(
                          widget.userModel.email,
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
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
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
                          autofocus: false,
                          controller: weightController,
                          cursorColor: Colors.grey,
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
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
                          controller: clothController,
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
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

                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
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
                          controller: waistController,
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
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
                          controller: hipController,
//                    keyboardType: TextInputType.text,
                          validator: (String val) {
                            val = val.trim();
                            if (val.isEmpty) {
                              return "Enter your hip size";
                            }
                            return null;
                          },
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
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
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
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
                        RaisedButton(
                          padding:
                              EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                          shape: RoundedRectangleBorder(
//                          borderRadius: BorderRadius.all(Radius.circular(20)),
                              side: BorderSide(
                                  color: Color(0xFFfb4545), width: 3)),
                          color: Color(0xFFfb4545),
                          onPressed: () async {
                            FocusScope.of(context).unfocus();
//                            if (_key.currentState.validate()) {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            await prefs.setInt("initScreen", 10);
                            setState(() {
                              isLoading = true;
                            });
                            if (_image != null)
                              uploadFile();
                            else {
                              UserModel user = new UserModel(
                                username: widget.userModel.username,
                                profilename: widget.userModel.profilename,
                                phonenumber: widget.userModel.phonenumber,
                                gender: widget.userModel.gender,
                                location: widget.userModel.location,
                                birthdate: widget.userModel.birthdate,
                                language: widget.userModel.language,
                                email: widget.userModel.email,
                                url: image_url ?? widget.userModel.url,
                                height: heightController.text.trim(),
                                weight: weightController.text.trim(),
                                clothingsize: clothController.text.trim(),
                                bustsize: bustController.text.trim(),
                                waistsize: waistController.text.trim(),
                                hipsize: hipController.text.trim(),
                                id: widget.uid,
                                timestamp: widget.userModel.timestamp,
                                isphoneverified:
                                    widget.userModel.isphoneverified,
                                isprofileshow: true,
                                shoesize: shoeController.text.trim(),
                              );
                              print(user.toJson());
                              try {
                                await _userCollection
                                    .document(widget.uid)
                                    .updateData(user.toJson());
                              } on PlatformException catch (e) {
                                print(e.message);
                              }
                              setState(() {
                                isLoading = false;

                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType
                                            .rightToLeftWithFade,
                                        child: QueOne()));
                              });
                            }

                            print("image_url${image_url}");
                            // e
//                            }
                          },
//                        textColor: ,
                          child: Text(
                            "Profile Update",
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: "FreigSanPro",
                                color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              isLoading
                  ? Center(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Updating..", style: headlineStyle),
                        CircularProgressIndicator(),
                      ],
                    ))
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
