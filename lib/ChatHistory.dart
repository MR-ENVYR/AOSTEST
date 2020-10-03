import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:style_of_agent/utils/utils.dart';

final _firestore = Firestore.instance;
FirebaseUser loggedInUser;

class ChatHistory extends StatefulWidget {
  String userEmail;
  String sessionID;

  ChatHistory(this.userEmail, this.sessionID);

  @override
  _ChatScreenState createState() => _ChatScreenState(userEmail, sessionID);
}

class _ChatScreenState extends State<ChatHistory> {
  String userEmail;
  String sessionID;

  _ChatScreenState(this.userEmail, this.sessionID);

  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  String messageText;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email + " demo");
        //  this.userEmail='mayank@aos.com';

      }
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dark,
      appBar: AppBar(
//        iconTheme: IconThemeData(color: Color(0xFFc0a948)),
        title: Text(
          'Tracy MacMonday',
          style: textTheme3,
        ),
        backgroundColor: secondary,
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              MessagesStream(userEmail, sessionID),
            ],
          ),
        ),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  String userEmail;
  String sessionID;

  MessagesStream(this.userEmail, this.sessionID);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('messages')
          .document(userEmail)
          .collection(sessionID)
          .orderBy('created')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: secondary,
            ),
          );
        }
        final messages = snapshot.data.documents.reversed;
        List<MessageBubble> messageBubbles = [];
        for (var message in messages) {
          final messageText = message.data['content'];
          final messageSender = message.data['sender'];
          final currentUser = loggedInUser.email;
          final messageType = message.data['type'];
          final messageBubble = MessageBubble(
            sender: messageSender,
            content: messageText,
            isCurrentUser: currentUser == messageSender,
            type: messageType,
          );
          messageBubbles.add(messageBubble);
        }
        return Expanded(
          child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              children: messageBubbles),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({this.sender, this.content, this.isCurrentUser, this.type});

  final String sender;
  final String content;
  final bool isCurrentUser;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment:
            isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          type == 'text' ? textBubble(context) : imageBubble(context)
        ],
      ),
    );
  }

  Widget textBubble(BuildContext context) {
    return Material(
        elevation: 10.0,
        borderRadius: isCurrentUser
            ? BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                topRight: Radius.circular(30))
            : BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomRight: Radius.circular(30)),
        color: isCurrentUser ? secondary : secondary,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Text(
            content,
            style: chatText,
          ),
        ));
  }

  Widget imageBubble(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return imageDetail(context);
        }));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 200,
          width: 200,
          child: FittedBox(
            fit: BoxFit.fill,
            child: Image.network(content,
                loadingBuilder: (context, child, progress) {
              return progress == null
                  ? child
                  : Padding(
                      padding: const EdgeInsets.all(50),
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.grey,
                        strokeWidth: 10,
                      ),
                    );
            }),
          ),
        ),
      ),
    );
  }

  Widget imageDetail(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Image.network(content),
        ),
      ),
    );
  }
}
