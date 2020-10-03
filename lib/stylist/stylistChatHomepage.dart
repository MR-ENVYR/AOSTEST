import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:style_of_agent/stylist/stylistInAppChat.dart';
import 'package:style_of_agent/utils/utils.dart';

class StylistChatHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(3, 9, 23, 1),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xFFc0a948)),
        backgroundColor: Colors.transparent,
        title: Center(
          child: Text(
            'Agents of Style',
            style: GoogleFonts.amiri(
              letterSpacing: 2,
              fontSize: 30,
              color: Color(0xFFc0a948),
//                fontFamily: "FreigSanPro",
            ),
          ),
        ),
      ),
      body: ChatLayout(),
    );
  }
}

class ChatLayout extends StatefulWidget {
  @override
  _ChatLayoutState createState() => _ChatLayoutState();
}

class _ChatLayoutState extends State<ChatLayout> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  Future getClients() async {
    var _firestore = Firestore.instance;
    QuerySnapshot qn = await _firestore
        .collection("questions")
        .where("status", isEqualTo: "active")
        .getDocuments();
    return qn.documents;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: dark,
      child: ChatHeads(),
    );
  }

  Widget ChatHeads() {
    return FutureBuilder(
      future: getClients(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          print('No Data');
          return Text('Loading');
        } else {
          print('Data Availabale');
          print(snapshot.data.length);

          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                String email = snapshot.data[index].data['email'];
                String userName = snapshot.data[index].data['username'];
                String sessionID = snapshot.data[index].data['id'];
                print(email);
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                stylistChatScreen(email, userName,sessionID)));
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 10.0,
                      ),
                    ], color: dark, borderRadius: BorderRadius.circular(5)),
                    child: ListTile(

                      title: Text(
                        snapshot.data[index].data['username'],
                        style: TextStyle(
                            color: primary,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        snapshot.data[index].data['email'],
                        style: TextStyle(color: lightPrimary, fontSize: 14),
                      ),
                    ),
                  ),
                );
              });
        }
      },
    );
  }
}
