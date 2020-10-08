import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:style_of_agent/ChatHistory.dart';
import 'package:style_of_agent/utils/utils.dart';
import 'inAppChat.dart';

class ChatHomePage extends StatelessWidget {
  String userEmail;
  ChatHomePage(this.userEmail);

  void getCurrentUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userEmail = prefs.getString("userEmail");
  }

  @override
  Widget build(BuildContext context) {
    getCurrentUser();
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
      body: ChatLayout(userEmail),
    );
  }
}

class ChatLayout extends StatefulWidget {
  String userEmail;
  ChatLayout(this.userEmail);
  @override
  _ChatLayoutState createState() => _ChatLayoutState(userEmail);
}

class _ChatLayoutState extends State<ChatLayout> {
  String userEmail;
  _ChatLayoutState(this.userEmail);
  final messageTextController = TextEditingController();
  final _firestore = Firestore.instance;
  final _auth = FirebaseAuth.instance;

  void getCurrentUser() async {
    if (userEmail == null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      userEmail = prefs.getString("userEmail");
    }
  }

  @override
  Widget build(BuildContext context) {
    getCurrentUser();
    return Container(
      color: dark,
      child: ChatHeads(),
    );
  }

  Widget ChatHeads() {
    return StreamBuilder(
      stream: Firestore.instance
          .collection('questions')
          .where("email", isEqualTo: userEmail)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Text("Loading");
        } else {
          return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                DocumentSnapshot session = snapshot.data.documents[index];
                String sessionID = session['id'];
                return InkWell(
                  onTap: () {
                    if (session['status'] == "active") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ChatScreen(userEmail, sessionID)));
                    } else if (session['status'] == "inactive") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ChatHistory(userEmail, sessionID)));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ChatHistory(userEmail, sessionID)));
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: secondary,
                            offset: Offset(0.0, 1.0), //(x,y)
                            blurRadius: 10.0,
                          ),
                        ],
                        color: secondary,
                        borderRadius: BorderRadius.circular(5)),
                    child: ListTile(
                      title: Text(
                        'Tracy MacMonday',
                        style: TextStyle(color: notWhite),
                      ),
                      subtitle: Text(session['ques2']),
                      trailing: Text(
                        session['status'].toUpperCase(),
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
