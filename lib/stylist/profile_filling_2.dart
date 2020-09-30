import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:style_of_agent/QA_Sections/q_one.dart';
import 'package:style_of_agent/connection.dart';
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

class StyleProfileFillingPart2 extends StatefulWidget {
  UserModel userModel;
//  FirebaseUser currentuser;
  String uid;
  File image;
  StyleProfileFillingPart2({this.userModel, this.image, this.uid});

  @override
  _StyleProfileFillingPart2State createState() =>
      _StyleProfileFillingPart2State();
}

class _StyleProfileFillingPart2State extends State<StyleProfileFillingPart2> {
  List<String> styles = [
//    "styles",
    "Business",
    "Sporty",
    "Casual",
    "Sophisticated",
    "Chic",
    "Tomboy",
    "Artsy",
    "Rocker",
    "Sexy",
    "Smart"
  ];

  GlobalKey<FormState> _key = new GlobalKey<FormState>();
  TextEditingController pinterestUrlController = TextEditingController();
  TextEditingController InstagramController = TextEditingController();
  TextEditingController skypeIdController = TextEditingController();
  TextEditingController whatsappController = TextEditingController();
  TextEditingController fbController = TextEditingController();
  TextEditingController styleController = TextEditingController();

  FocusNode pinterestUrlNode = FocusNode();
  FocusNode InstagramNode = FocusNode();
  FocusNode skypeIdNode = FocusNode();
  FocusNode whatsappNode = FocusNode();
  FocusNode fbNode = FocusNode();
  FocusNode styleNode = FocusNode();

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
      styleController = TextEditingController(text: styles[0]);
    });
    print(widget.uid);
  }

//  Future uploadFile() async {
//    StorageReference storageReference = FirebaseStorage.instance
//        .ref()
//        .child('${DateTime.now().millisecondsSinceEpoch}.jpg');
//    StorageUploadTask uploadTask = storageReference.putFile(_image);
//    await uploadTask.onComplete;
//    storageReference.getDownloadURL().then((fileURL) async {
//      setState(() {
//        isLoading = false;
//        print("file${fileURL}");
//        image_url = fileURL;
////        Navigator.pop(context);
//      });
//      UserModel user = new UserModel(
//        username: widget.userModel.username,
//        profilename: widget.userModel.profilename,
//        phonenumber: widget.userModel.phonenumber,
//        gender: widget.userModel.gender,
//        location: widget.userModel.location,
//        birthdate: widget.userModel.birthdate,
//        language: widget.userModel.language,
//        email: widget.userModel.email,
//        url: image_url,
//        height: heightController.text.trim(),
//        weight: weightController.text.trim(),
//        clothingsize: clothController.text.trim(),
//        bustsize: bustController.text.trim(),
//        waistsize: waistController.text.trim(),
//        hipsize: hipController.text.trim(),
//        trouserLength: trouserLController.text.trim(),
//        isprofileshow: true,
//        id: widget.uid,
//        timestamp: widget.userModel.timestamp,
//        isphoneverified: widget.userModel.isphoneverified,
//        shoesize: shoeController.text.trim(),
//      );
//      print(user.toJson());
//      try {
//        await _userCollection.document(widget.uid).updateData(user.toJson());
//      } on PlatformException catch (e) {
//        print(e.message);
//      }
//      setState(() {
//        isLoading = false;
//        Navigator.push(
//            context,
//            PageTransition(
//                type: PageTransitionType.rightToLeftWithFade, child: QueOne()));
//      });
//
////      updateDP();
//    });
//  }

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
                        .then((image) async {
//                      ImageProperties properties =
//                          await FlutterNativeImage.getImageProperties(
//                              image.path);
//
//                      File compressedFile =
//                          await FlutterNativeImage.compressImage(image.path,
//                              quality: 80,
//                              targetWidth: 600,
//                              targetHeight:
//                                  (properties.height * 600 / properties.width)
//                                      .round());
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
                        .then((image) async {
//                      ImageProperties properties =
//                          await FlutterNativeImage.getImageProperties(
//                              image.path);
//
//                      File compressedFile =
//                          await FlutterNativeImage.compressImage(image.path,
//                              quality: 80,
//                              targetWidth: 600,
//                              targetHeight:
//                                  (properties.height * 600 / properties.width)
//                                      .round());
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
                            "My Contacts  ",
                            style: GoogleFonts.amiri(
                              letterSpacing: 1.5,
                              fontSize: 30,
                              color: Color(0xFFE5CF73),
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
                            color: Colors.white.withOpacity(0.9),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 10.0 * 0.5),
                        Text(
                          widget.userModel.email,
                          style: GoogleFonts.workSans(
                            fontSize: 13,
                            color: Colors.white.withOpacity(0.9),
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          autofocus: false,
//                              enabled: true,
                          controller: pinterestUrlController,
                          cursorColor: Colors.grey,
                          keyboardType: TextInputType.text,
                          autocorrect: true,

//                          validator: (String val) {
//                            val = val.trim();
//                            if (val.isEmpty) {
//                              return "Enter your first name";
//                            }
//                            return null;
//                          },
//                              initialValue: name.split(" ").first,
                          focusNode: pinterestUrlNode,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(InstagramNode);
                          },
//                          onChanged: (val) {
////                                setState(() {
////                                  fnameController.text = val.trim();
////                                });
//                          },
                          textInputAction: TextInputAction.next,
                          style: inputStyle,
//                    initialValue: _userModel.profilename.split(" ").first,
                          decoration: InputDecoration(
                              focusedErrorBorder: errorBorder,
                              border: labelBorder,
                              labelText: "Pinterest Url",
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
//                              enabled: true,
                          controller: InstagramController,
                          cursorColor: Colors.grey,
                          keyboardType: TextInputType.text,
                          autocorrect: true,

//                          validator: (String val) {
//                            val = val.trim();
//                            if (val.isEmpty) {
//                              return "Enter your first name";
//                            }
//                            return null;
//                          },
//                              initialValue: name.split(" ").first,
                          focusNode: InstagramNode,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(skypeIdNode);
                          },
//                          onChanged: (val) {
////                                setState(() {
////                                  fnameController.text = val.trim();
////                                });
//                          },
                          textInputAction: TextInputAction.next,
                          style: inputStyle,
//                    initialValue: _userModel.profilename.split(" ").first,
                          decoration: InputDecoration(
                              focusedErrorBorder: errorBorder,
                              border: labelBorder,
                              labelText: "Instagram",
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
//                              enabled: true,
                          controller: skypeIdController,
                          cursorColor: Colors.grey,
                          keyboardType: TextInputType.text,
                          autocorrect: true,

                          validator: (String val) {
                            val = val.trim();
                            if (val.isEmpty) {
                              return "Enter your skype id";
                            }
                            return null;
                          },
//                              initialValue: name.split(" ").first,
                          focusNode: skypeIdNode,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(whatsappNode);
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
                              labelText: "Skype Id",
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
//                              enabled: true,
                          controller: whatsappController,
                          cursorColor: Colors.grey,
                          keyboardType: TextInputType.text,
                          autocorrect: true,

//                          validator: (String val) {
//                            val = val.trim();
//                            if (val.isEmpty) {
//                              return "Enter your first name";
//                            }
//                            return null;
//                          },
//                              initialValue: name.split(" ").first,
                          focusNode: whatsappNode,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(fbNode);
                          },
//                          onChanged: (val) {
////                                setState(() {
////                                  fnameController.text = val.trim();
////                                });
//                          },
                          textInputAction: TextInputAction.next,
                          style: inputStyle,
//                    initialValue: _userModel.profilename.split(" ").first,
                          decoration: InputDecoration(
                              focusedErrorBorder: errorBorder,
                              border: labelBorder,
                              labelText: "Whatsapp Number",
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
//                              enabled: true,
                          controller: fbController,
                          cursorColor: Colors.grey,
                          keyboardType: TextInputType.text,
                          autocorrect: true,

//                          validator: (String val) {
//                            val = val.trim();
//                            if (val.isEmpty) {
//                              return "Enter your first name";
//                            }
//                            return null;
//                          },
//                              initialValue: name.split(" ").first,
                          focusNode: fbNode,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).unfocus();
                          },
//                          onChanged: (val) {
////                                setState(() {
////                                  fnameController.text = val.trim();
////                                });
//                          },
                          textInputAction: TextInputAction.done,
                          style: inputStyle,
//                    initialValue: _userModel.profilename.split(" ").first,
                          decoration: InputDecoration(
                              focusedErrorBorder: errorBorder,
                              border: labelBorder,
                              labelText: "Facebook Url",
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
                        FormField<String>(
                          validator: (var val) {
                            if (val.contains("styles", 0))
                              return "Enter your style expertise";
                            return null;
                          },
                          builder: (FormFieldState<String> state) {
                            return InputDecorator(
                              isHovering: true,
                              decoration: InputDecoration(
                                  border: labelBorder,
                                  labelText: "style expertise",
                                  labelStyle: labelStyle,
                                  errorBorder: errorBorder,
                                  enabledBorder: labelBorder,
                                  hintText: "style expertise",
                                  enabled: true,
                                  focusedBorder: labelBorder,
                                  focusColor: Color(0xFF251f2d),
                                  filled: true,
                                  fillColor: Color(0xff1e1b24),
                                  errorStyle: errorStyle),
                              isEmpty: styleController.text == '',
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  dropdownColor: Color(0xFF272727),
                                  value: styleController.text,
                                  isDense: true,
                                  hint: Text("styles"),
                                  onChanged: (String newValue) {
                                    setState(() {
                                      styleController.text = newValue;
                                      state.didChange(newValue);
                                      print(styleController.text);
                                    });
                                  },
                                  style: inputStyle,
//                              hint: Text(
//                                "Language",
//                                style: inputStyle,
//                              ),
                                  items: styles.map((String value) {
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
                        RaisedButton(
                          padding:
                              EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                  color: Color(0xFFfb4545), width: 3)),
                          color: Color(0xFFfb4545),
                          onPressed: () async {
                            checkConnection(context);
//                            Navigator.pop(context);
                            FocusScope.of(context).unfocus();
                            if (_key.currentState.validate()) {}

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
