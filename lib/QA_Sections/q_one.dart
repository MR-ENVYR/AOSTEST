import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:style_of_agent/QA_Sections/fadeAnimation.dart';
import 'package:style_of_agent/QA_Sections/moveAnimation.dart';
import 'package:style_of_agent/QA_Sections/q_two.dart';
import 'package:style_of_agent/animated_menu/menu_frame.dart';
import 'package:style_of_agent/connection.dart';
import 'package:style_of_agent/progress.dart';
import 'package:style_of_agent/utils/utils.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
//import 'package:slider_button/slider_button.dart';
//import 'package:swipe_button/swipe_button.dart';

class QueOne extends StatefulWidget {
  @override
  _QueOneState createState() => _QueOneState();
}

class _QueOneState extends State<QueOne> with TickerProviderStateMixin {
  bool hideIcon = false;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    checkConnection(context);
//    print(widget.user.uid);
  }

  Map<String, dynamic> ques = Map();
  File _image;
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
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color.fromRGBO(3, 9, 23, 1),
//        appBar: PreferredSize(
//          child: SliverAppBar(
//            title: Align(
//              alignment: Alignment.topRight,
//              child: SvgPicture.asset(
//                "assets/images/aoslogo.svg",
//                height: 50,
////              width: 10,
//              ),
//            ),
//            leading: GestureDetector(
//              onTap: () {
//                Navigator.pushAndRemoveUntil(
//                    context,
//                    PageTransition(
//                        type: PageTransitionType.rightToLeftWithFade,
//                        child: MenuFrame(
////                                uid: id,
//                            )),
//                    (route) => false);
//              },
//              child: Align(
////              alignment: Alignment.bottomLeft,
//                child: Padding(
//                  padding: const EdgeInsets.only(left: 20),
//                  child: Text(
//                    "<",
//                    style: TextStyle(color: Colors.white, fontSize: 40),
//                  ),
//                ),
//              ),
//            ),
//          ),
//          preferredSize: Size(width, 55),
//        ),
      body: Stack(
        children: <Widget>[
          CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: Color.fromRGBO(3, 9, 23, 1),
                brightness: Brightness.dark,
                title: Align(
                  alignment: Alignment.topRight,
                  child: SvgPicture.asset(
                    "assets/images/aoslogo.svg",
                    height: 50,
//              width: 10,
                  ),
                ),
                leading: GestureDetector(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeftWithFade,
                            child: MenuFrame(
//                                uid: id,
                                )),
                        (route) => false);
                  },
                  child: Align(
//              alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        "<",
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      ),
                    ),
                  ),
                ),
                floating: true,
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        MoveAnimation(
                            1,
                            Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: Container(
                                width: MediaQuery.of(context).size.height / 3,
                                height: MediaQuery.of(context).size.height / 3,
//                          width: 300,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                        "assets/images/qa_section/q1_logo.jpg",
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
//                            child: Image.asset(
//                              "assets/images/qa_section/q1_logo.jpg",
//                              scale: 2,
//                              fit: BoxFit.cover,
////                              fit: BoxFit.cover,
//
////                              height: 300,
//                              width: 300,
//                            )
                              ),
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                          1.5,
                          Text(
                            "Upload your current look",
                            textAlign: TextAlign.center,
                            style: headlineStyle,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        FadeAnimation(
                          1.8,
                          GestureDetector(
                            onTap: () {
                              showImageOption();
                            },
                            child: Container(
//                            margin: EdgeInsets.symmetric(horizontal: 90),
//                            constraints: BoxConstraints(minWidth: 20),
                                width: 150,
                                height: 150,
//                        width: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  border: Border.all(
                                      color: Color(0xFFE5CF73), width: 2),
                                  image: _image != null
                                      ? DecorationImage(
                                          image: FileImage(_image),
                                          fit: BoxFit.cover)
                                      : null,
                                ),
//                          alignment: Alignment.center,
                                child: _image != null
                                    ? Container()
                                    : Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
//                                          Image.asset(
//                                            "assets/images/qa_section/upload.png",
//                                            color: Colors.grey,
//                                            scale: 2,
//                                          ),
                                          Icon(
                                            Icons.camera_alt,
                                            color: Colors.grey,
                                            size: 50,
                                          )
                                        ],
                                      )),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        FadeAnimation(
                          2,
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: FlatButton(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 5),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                      color: Color(0xFFfb4545), width: 3)),
                              color: Color(0xFFfb4545),
                              onPressed: () async {
                                checkConnection(context);
                                if (_image != null && !isLoading) {
                                  showAlertDialog(context, "Please wait..");
                                  setState(() {
                                    isLoading = true;
                                  });
                                  StorageReference storageReference =
                                      FirebaseStorage.instance.ref().child(
                                          '${DateTime.now().millisecondsSinceEpoch}.jpg');
                                  StorageUploadTask uploadTask =
                                      storageReference.putFile(_image);
                                  await uploadTask.onComplete;
                                  storageReference
                                      .getDownloadURL()
                                      .then((fileURL) {
                                    setState(() {
                                      isLoading = false;
                                      Navigator.pop(context);
                                      print("file${fileURL}");
//                            image_url = fileURL;
                                      ques.putIfAbsent("ques1", () => fileURL);
                                      Navigator.push(
                                          context,
                                          PageTransition(
                                              type: PageTransitionType
                                                  .rightToLeftWithFade,
                                              child: QueTwo(
//                                        user: widget.user,
                                                ques: ques,
                                              )));
                                      //        Navigator.pop(context);
                                    });
                                  });
                                }
//                            else {
//                              Scaffold.of(context).showSnackBar(SnackBar(
//                                backgroundColor: Colors.black,
//                                content: Text(
//                                  "Upload your current Look ",
//                                  style: labelStyle,
//                                ),
//                                duration: Duration(milliseconds: 500),
//                                elevation: 5,
//                              ));
//                            }
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
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]))
            ],
          ),
//          isLoading
//              ? Center(
//                  child: Column(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  children: <Widget>[
//                    Text("Uploading..", style: headlineStyle),
//                    CircularProgressIndicator(),
//                  ],
//                ))
//              : Container(),
        ],
      ),
    );
  }
}
