import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:style_of_agent/connection.dart';

final Uint8List kTransparentImage = new Uint8List.fromList(<int>[
  0x89,
  0x50,
  0x4E,
  0x47,
  0x0D,
  0x0A,
  0x1A,
  0x0A,
  0x00,
  0x00,
  0x00,
  0x0D,
  0x49,
  0x48,
  0x44,
  0x52,
  0x00,
  0x00,
  0x00,
  0x01,
  0x00,
  0x00,
  0x00,
  0x01,
  0x08,
  0x06,
  0x00,
  0x00,
  0x00,
  0x1F,
  0x15,
  0xC4,
  0x89,
  0x00,
  0x00,
  0x00,
  0x0A,
  0x49,
  0x44,
  0x41,
  0x54,
  0x78,
  0x9C,
  0x63,
  0x00,
  0x01,
  0x00,
  0x00,
  0x05,
  0x00,
  0x01,
  0x0D,
  0x0A,
  0x2D,
  0xB4,
  0x00,
  0x00,
  0x00,
  0x00,
  0x49,
  0x45,
  0x4E,
  0x44,
  0xAE,
]);

class Library extends StatefulWidget {
  @override
  _LibraryState createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  String id;
  @override
  void initState() {
    // TODO: implement initState
    checkConnection(context);
    showUid();
    super.initState();
  }

  showUid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString("uid");
    setState(() {
      id = uid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(3, 9, 23, 1),
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xFFE5CF73)),
        backgroundColor: Colors.transparent,
        title: Text(
          "Library",
          style: GoogleFonts.amiri(
            letterSpacing: 2,
            fontSize: 30,
            color: Color(0xFFE5CF73),
//                fontFamily: "FreigSanPro",
          ),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream:
            Firestore.instance.collection('library').document(id).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data.data!=null) {
            print("library has data");

            var images = snapshot.data['images'];

            return Padding(
                padding: const EdgeInsets.all(20.0),
                child: new StaggeredGridView.countBuilder(
                  crossAxisCount: 4,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  itemCount: images.length,
                  itemBuilder: (BuildContext context, int index) =>
                      GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ImageView(
                                    url: images[index],
                                  )));
                    },
                    child: new FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: images[index],
                    ),
//                Container(
//                  decoration: BoxDecoration(
//                      image: DecorationImage(
//                          image: NetworkImage(image, scale: 1),
//                          fit: BoxFit.cover)),
//                ),
                  ),
                  staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
                ));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class ImageView extends StatelessWidget {
  String url;
  ImageView({this.url});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
                image: NetworkImage(url, scale: 1), fit: BoxFit.fitWidth)),
        child: Align(
          alignment: Alignment.topLeft,
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.transparent.withOpacity(0.4),
            padding: const EdgeInsets.only(left: 7, top: 29),
            child: IconButton(
                alignment: Alignment.topLeft,
                icon: Icon(
                  Icons.arrow_back,
                  color: Color(0xFFE5CF73),
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ),
        ),
      ),
    );
  }
}
