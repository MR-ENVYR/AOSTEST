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
  List<String> clothSize = ["XS", "S", "M", "L", "XL", "XXL"];

  List<String> weights = [
    "50",
    "55",
    "60",
    "65",
    "70",
    "75",
    "80",
    "85",
    "90",
    "95",
    "100",
    "105",
    "110",
    "115",
    "120",
    "125",
    "130",
    "135",
    "140",
    "145",
    "150",
    "155",
    "160",
    "165",
    "170",
    "175",
    "180",
    "185",
    "190",
    "195",
    "200",
  ];

  List<String> Height = [
    "120",
    "121",
    "122",
    "123",
    "124",
    "125",
    "126",
    "127",
    "128",
    "129",
    "130",
    "131",
    "132",
    "133",
    "134",
    "135",
    "136",
    "137",
    "138",
    "139",
    "140",
    "141",
    "142",
    "143",
    "144",
    "145",
    "146",
    "147",
    "148",
    "149",
    "150",
    "151",
    "152",
    "153",
    "154",
    "155",
    "156",
    "157",
    "158",
    "159",
    "160",
    "161",
    "162",
    "163",
    "164",
    "165",
    "166",
    "167",
    "168",
    "169",
    "170",
    "171",
    "172",
    "173",
    "174",
    "175",
    "176",
    "177",
    "178",
    "179",
    "180",
    "181",
    "182",
    "183",
    "184",
    "185",
    "186",
    "187",
    "188",
    "189",
    "190",
    "191",
    "192",
    "193",
    "194",
    "195",
    "196",
    "197",
    "198",
    "199",
    "200",
  ];

  List<String> shoesize = [
    "36",
    "37",
    "38",
    "39",
    "40",
    "41",
    "42",
    "43",
    "44",
    "45",
  ];

  List<String> waist = [
    "26",
    "28",
    "30",
    "32",
    "34",
    "36",
    "38",
    "40",
  ];

  List<String> TrousersLength = [
    "30",
    "32",
    "34",
  ];

  GlobalKey<FormState> _key = new GlobalKey<FormState>();
  TextEditingController clothController = TextEditingController();
  TextEditingController bustController = TextEditingController();
  TextEditingController waistController = TextEditingController();
  TextEditingController hipController = TextEditingController();
  TextEditingController trouserLController = TextEditingController();
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
      clothController = TextEditingController(text: clothSize[0]);
      bustController = TextEditingController(text: clothSize[0]);

      waistController = TextEditingController(text: waist[0] + " inch");
      hipController = TextEditingController(text: clothSize[0]);

      shoeController = TextEditingController(text: shoesize[0]);

      heightController = TextEditingController(text: Height[0] + " cm");
      weightController = TextEditingController(text: weights[0] + " kg");
      trouserLController =
          TextEditingController(text: TrousersLength[0] + " inch");
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
        trouserLength: trouserLController.text.trim(),
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
                            "My Measurement",
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
                                        : AssetImage('assets/images/av.png'),
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

                        FormField<String>(
                          builder: (FormFieldState<String> state) {
                            return InputDecorator(
                              isHovering: true,
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
                              isEmpty: heightController.text == '',
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  dropdownColor: Color(0xFF272727),
                                  value: heightController.text,
                                  isDense: true,

                                  onChanged: (String newValue) {
                                    setState(() {
                                      heightController.text = newValue;
                                      state.didChange(newValue);
                                      print(heightController.text);
                                    });
                                  },
                                  style: inputStyle,
//                              hint: Text(
//                                "Language",
//                                style: inputStyle,
//                              ),
                                  items: Height.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value + ' cm',
                                      child: Text(
                                        value + " cm",
//                                    style: inputStyle,
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            );
                          },
                        ),
//                        TextFormField(
//                          autofocus: false,
//                          controller: heightController,
//                          cursorColor: Colors.grey,
//                          validator: (String val) {
//                            val = val.trim();
//                            if (val.isEmpty) {
//                              return "Enter your height";
//                            }
//                            return null;
//                          },
//                          focusNode: heightNode,
//                          keyboardType:
//                              TextInputType.numberWithOptions(decimal: true),
//                          onFieldSubmitted: (_) {
//                            FocusScope.of(context).requestFocus(weightNode);
//                          },
//                          textInputAction: TextInputAction.next,
//                          style: inputStyle,
//                          decoration: InputDecoration(
//                              focusedErrorBorder: errorBorder,
//                              border: labelBorder,
//                              labelText: "Height",
//                              labelStyle: labelStyle,
//                              errorBorder: errorBorder,
//                              enabledBorder: labelBorder,
//                              enabled: true,
//                              focusedBorder: labelBorder,
//                              focusColor: Color(0xFFffffff),
//                              filled: true,
//                              fillColor: Color(0xff1e1b24),
//                              errorStyle: errorStyle),
//                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FormField<String>(
                          builder: (FormFieldState<String> state) {
                            return InputDecorator(
                              isHovering: true,
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
                              isEmpty: weightController.text == '',
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  dropdownColor: Color(0xFF272727),
                                  value: weightController.text,
                                  isDense: true,

                                  onChanged: (String newValue) {
                                    setState(() {
                                      weightController.text = newValue;
                                      state.didChange(newValue);
                                      print(weightController.text);
                                    });
                                  },
                                  style: inputStyle,
//                              hint: Text(
//                                "Language",
//                                style: inputStyle,
//                              ),
                                  items: weights.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value + " kg",
                                      child: Text(
                                        value + " kg",
//                                    style: inputStyle,
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            );
                          },
                        ),
//                        TextFormField(
//                          autofocus: false,
//                          controller: weightController,
//                          cursorColor: Colors.grey,
//                          keyboardType:
//                              TextInputType.numberWithOptions(decimal: true),
//                          focusNode: weightNode,
//                          validator: (String val) {
//                            if (val.isEmpty) {
//                              return "Enter your weight";
//                            }
//                            return null;
//                          },
//                          onFieldSubmitted: (_) {
//                            FocusScope.of(context).requestFocus(clothNode);
//                          },
//                          textInputAction: TextInputAction.next,
//                          style: inputStyle,
//                          decoration: InputDecoration(
//                              focusedErrorBorder: errorBorder,
//                              border: labelBorder,
//                              labelText: "Weight",
//                              labelStyle: labelStyle,
//                              errorBorder: errorBorder,
//                              enabledBorder: labelBorder,
//                              enabled: true,
//                              focusedBorder: labelBorder,
//                              focusColor: Color(0xFFffffff),
//                              filled: true,
//                              fillColor: Color(0xff1e1b24),
//                              errorStyle: errorStyle),
//                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FormField<String>(
                          builder: (FormFieldState<String> state) {
                            return InputDecorator(
                              isHovering: true,
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
                              isEmpty: clothController.text == '',
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  dropdownColor: Color(0xFF272727),
                                  value: clothController.text,
                                  isDense: true,

                                  onChanged: (String newValue) {
                                    setState(() {
                                      clothController.text = newValue;
                                      state.didChange(newValue);
                                      print(clothController.text);
                                    });
                                  },
                                  style: inputStyle,
//                              hint: Text(
//                                "Language",
//                                style: inputStyle,
//                              ),
                                  items: clothSize.map((String value) {
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
//                        TextFormField(
//                          autofocus: false,
//                          controller: clothController,
//                          keyboardType:
//                              TextInputType.numberWithOptions(decimal: true),
////                    keyboardType: TextInputType.text,
//                          validator: (String val) {
//                            val = val.trim();
//                            if (val.isEmpty) {
//                              return "Enter your clothing size";
//                            }
//                            return null;
//                          },
//                          focusNode: clothNode,
//                          onFieldSubmitted: (_) {
//                            FocusScope.of(context).requestFocus(bustNode);
//                          },
//                          textInputAction: TextInputAction.next,
//                          cursorColor: Colors.grey,
//                          style: inputStyle,
//                          decoration: InputDecoration(
//                              border: labelBorder,
//                              labelText: "Clothing Size",
//                              labelStyle: labelStyle,
//                              errorBorder: errorBorder,
//                              enabledBorder: labelBorder,
//                              enabled: true,
//                              focusedBorder: labelBorder,
//                              focusColor: Color(0xFF251f2d),
//                              filled: true,
//                              fillColor: Color(0xff1e1b24),
//                              errorStyle: errorStyle),
//                        ),
                        SizedBox(
                          height: 10,
                        ),
//                        FormField<String>(
//                          builder: (FormFieldState<String> state) {
//                            return InputDecorator(
//                              isHovering: true,
//                              decoration: InputDecoration(
//                                  border: labelBorder,
//                                  labelText: "Bust Size",
//                                  labelStyle: labelStyle,
//                                  errorBorder: errorBorder,
//                                  enabledBorder: labelBorder,
//                                  enabled: true,
//                                  focusedBorder: labelBorder,
//                                  focusColor: Color(0xFF251f2d),
//                                  filled: true,
//                                  fillColor: Color(0xff1e1b24),
//                                  errorStyle: errorStyle),
//                              isEmpty: bustController.text == '',
//                              child: DropdownButtonHideUnderline(
//                                child: DropdownButton<String>(
//                                  dropdownColor: Color(0xFF272727),
//                                  value: bustController.text,
//                                  isDense: true,
//
//                                  onChanged: (String newValue) {
//                                    setState(() {
//                                      bustController.text = newValue;
//                                      state.didChange(newValue);
//                                      print(bustController.text);
//                                    });
//                                  },
//                                  style: inputStyle,
////                              hint: Text(
////                                "Language",
////                                style: inputStyle,
////                              ),
//                                  items: waist.map((String value) {
//                                    return DropdownMenuItem<String>(
//                                      value: value,
//                                      child: Text(
//                                        value,
////                                    style: inputStyle,
//                                      ),
//                                    );
//                                  }).toList(),
//                                ),
//                              ),
//                            );
//                          },
//                        ),
//                        TextFormField(
//                          autofocus: false,
//
//                          keyboardType:
//                              TextInputType.numberWithOptions(decimal: true),
//                          controller: bustController,
////                    keyboardType: TextInputType.text,
//                          validator: (String val) {
//                            val = val.trim();
//                            if (val.isEmpty) {
//                              return "Enter your bust size";
//                            }
//                            return null;
//                          },
//                          focusNode: bustNode,
//                          onFieldSubmitted: (_) {
//                            FocusScope.of(context).requestFocus(waistNode);
//                          },
//                          textInputAction: TextInputAction.next,
//                          cursorColor: Colors.grey,
//                          style: inputStyle,
//                          decoration: InputDecoration(
//                              border: labelBorder,
//                              labelText: "Bust Size",
//                              labelStyle: labelStyle,
//                              errorBorder: errorBorder,
//                              enabledBorder: labelBorder,
//                              enabled: true,
//                              focusedBorder: labelBorder,
//                              focusColor: Color(0xFF251f2d),
//                              filled: true,
//                              fillColor: Color(0xff1e1b24),
//                              errorStyle: errorStyle),
//                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FormField<String>(
                          builder: (FormFieldState<String> state) {
                            return InputDecorator(
                              isHovering: true,
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
                              isEmpty: waistController.text == '',
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  dropdownColor: Color(0xFF272727),
                                  value: waistController.text,
                                  isDense: true,

                                  onChanged: (String newValue) {
                                    setState(() {
                                      waistController.text = newValue;
                                      state.didChange(newValue);
                                      print(waistController.text);
                                    });
                                  },
                                  style: inputStyle,
//                              hint: Text(
//                                "Language",
//                                style: inputStyle,
//                              ),
                                  items: waist.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value + " inch",
                                      child: Text(
                                        value + " inch",
//                                    style: inputStyle,
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            );
                          },
                        ),
//                        TextFormField(
//                          autofocus: false,
//                          controller: waistController,
//                          keyboardType:
//                              TextInputType.numberWithOptions(decimal: true),
////                      keyboardType: TextInputType.phone,
//                          validator: (String val) {
//                            val = val.trim();
//                            if (val.isEmpty) {
//                              return "Enter your waist size";
//                            }
//                            return null;
//                          },
//                          focusNode: waistNode,
//                          onFieldSubmitted: (_) {
//                            FocusScope.of(context).requestFocus(hipNode);
//                          },
//                          textInputAction: TextInputAction.next,
//                          cursorColor: Colors.grey,
//                          style: inputStyle,
//                          decoration: InputDecoration(
//                              border: labelBorder,
//                              labelText: "Waist Size",
//                              labelStyle: labelStyle,
//                              errorBorder: errorBorder,
//                              enabledBorder: labelBorder,
//                              enabled: true,
//                              focusedBorder: labelBorder,
//                              focusColor: Color(0xFF251f2d),
//                              filled: true,
//                              fillColor: Color(0xff1e1b24),
//                              errorStyle: errorStyle),
//                        ),
                        SizedBox(
                          height: 10,
                        ),

                        FormField<String>(
                          builder: (FormFieldState<String> state) {
                            return InputDecorator(
                              isHovering: true,
                              decoration: InputDecoration(
                                  border: labelBorder,
                                  labelText: "Trouser Length",
                                  labelStyle: labelStyle,
                                  errorBorder: errorBorder,
                                  enabledBorder: labelBorder,
                                  enabled: true,
                                  focusedBorder: labelBorder,
                                  focusColor: Color(0xFF251f2d),
                                  filled: true,
                                  fillColor: Color(0xff1e1b24),
                                  errorStyle: errorStyle),
                              isEmpty: trouserLController.text == '',
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  dropdownColor: Color(0xFF272727),
                                  value: trouserLController.text,
                                  isDense: true,

                                  onChanged: (String newValue) {
                                    setState(() {
                                      trouserLController.text = newValue;
                                      state.didChange(newValue);
                                      print(trouserLController.text);
                                    });
                                  },
                                  style: inputStyle,
//                              hint: Text(
//                                "Language",
//                                style: inputStyle,
//                              ),
                                  items: TrousersLength.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value + " inch",
                                      child: Text(
                                        value + " inch",
//                                    style: inputStyle,
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            );
                          },
                        ),

//                        FormField<String>(
//                          builder: (FormFieldState<String> state) {
//                            return InputDecorator(
//                              isHovering: true,
//                              decoration: InputDecoration(
//                                  border: labelBorder,
//                                  labelText: "Hip Size",
//                                  labelStyle: labelStyle,
//                                  errorBorder: errorBorder,
//                                  enabledBorder: labelBorder,
//                                  enabled: true,
//                                  focusedBorder: labelBorder,
//                                  focusColor: Color(0xFF251f2d),
//                                  filled: true,
//                                  fillColor: Color(0xff1e1b24),
//                                  errorStyle: errorStyle),
//                              isEmpty: hipController.text == '',
//                              child: DropdownButtonHideUnderline(
//                                child: DropdownButton<String>(
//                                  dropdownColor: Color(0xFF272727),
//                                  value: hipController.text,
//                                  isDense: true,
//
//                                  onChanged: (String newValue) {
//                                    setState(() {
//                                      hipController.text = newValue;
//                                      state.didChange(newValue);
//                                      print(hipController.text);
//                                    });
//                                  },
//                                  style: inputStyle,
////                              hint: Text(
////                                "Language",
////                                style: inputStyle,
////                              ),
//                                  items: waist.map((String value) {
//                                    return DropdownMenuItem<String>(
//                                      value: value,
//                                      child: Text(
//                                        value,
////                                    style: inputStyle,
//                                      ),
//                                    );
//                                  }).toList(),
//                                ),
//                              ),
//                            );
//                          },
//                        ),
//                        TextFormField(
//                          autofocus: false,
//                          controller: hipController,
////                    keyboardType: TextInputType.text,
//                          validator: (String val) {
//                            val = val.trim();
//                            if (val.isEmpty) {
//                              return "Enter your hip size";
//                            }
//                            return null;
//                          },
//                          keyboardType:
//                              TextInputType.numberWithOptions(decimal: true),
//                          focusNode: hipNode,
//                          onFieldSubmitted: (_) {
//                            FocusScope.of(context).requestFocus(shoeNode);
//                          },
//                          textInputAction: TextInputAction.next,
//                          cursorColor: Colors.grey,
//                          style: inputStyle,
//                          decoration: InputDecoration(
//                              border: labelBorder,
//                              labelText: "Hip Size",
//                              labelStyle: labelStyle,
//                              errorBorder: errorBorder,
//                              enabledBorder: labelBorder,
//                              enabled: true,
//                              focusedBorder: labelBorder,
//                              focusColor: Color(0xFF251f2d),
//                              filled: true,
//                              fillColor: Color(0xff1e1b24),
//                              errorStyle: errorStyle),
//                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FormField<String>(
                          builder: (FormFieldState<String> state) {
                            return InputDecorator(
                              isHovering: true,
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
                              isEmpty: shoeController.text == '',
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  dropdownColor: Color(0xFF272727),
                                  value: shoeController.text,
                                  isDense: true,

                                  onChanged: (String newValue) {
                                    setState(() {
                                      shoeController.text = newValue;
                                      state.didChange(newValue);
                                      print(shoeController.text);
                                    });
                                  },
                                  style: inputStyle,
//                              hint: Text(
//                                "Language",
//                                style: inputStyle,
//                              ),
                                  items: shoesize.map((String value) {
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
//                        TextFormField(
//                          autofocus: false,
//                          controller: shoeController,
////                    keyboardType: TextInputType.text,
//                          validator: (String val) {
//                            val = val.trim();
//                            if (val.isEmpty) {
//                              return "Enter your shoe size";
//                            }
//                            return null;
//                          },
//                          focusNode: shoeNode,
//                          onFieldSubmitted: (_) {
//                            FocusScope.of(context).unfocus();
//                          },
//                          textInputAction: TextInputAction.done,
//                          cursorColor: Colors.grey,
//                          style: inputStyle,
//                          keyboardType:
//                              TextInputType.numberWithOptions(decimal: true),
//                          decoration: InputDecoration(
//                              border: labelBorder,
//                              labelText: "Shoe Size",
//                              labelStyle: labelStyle,
//                              errorBorder: errorBorder,
//                              enabledBorder: labelBorder,
//                              enabled: true,
//                              focusedBorder: labelBorder,
//                              focusColor: Color(0xFF251f2d),
//                              filled: true,
//                              fillColor: Color(0xff1e1b24),
//                              errorStyle: errorStyle),
//                        ),
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
                                trouserLength: trouserLController.text.trim(),
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
