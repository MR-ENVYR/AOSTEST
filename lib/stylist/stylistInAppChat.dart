import 'dart:io';
import 'dart:math';

//import 'package:agent_of_style/theme.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:style_of_agent/connection.dart';
import 'package:style_of_agent/utils/utils.dart';

final _firestore = Firestore.instance;

class stylistChatScreen extends StatefulWidget {
  String userEmail;
  String userName;
  String sessionID;

  stylistChatScreen(this.userEmail, this.userName, this.sessionID);

  @override
  _stylistChatScreenState createState() =>
      _stylistChatScreenState(userEmail, userName, sessionID);
}

class _stylistChatScreenState extends State<stylistChatScreen> {
  String userEmail;
  String userName;
  String sessionID;

  _stylistChatScreenState(this.userEmail, this.userName, this.sessionID);

  final messageTextController = TextEditingController();

  String messageText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dark,
      appBar: AppBar(
//        iconTheme: IconThemeData(color: Color(0xFFE5CF73)),
        title: Center(
          child: Text(
            userName,
            style: textTheme3,
          ),
        ),
        actions: [
          RaisedButton(
            color: secondary,
            child: Text(
              "End",
              style: textTheme3,
            ),
            onPressed: () {
              Firestore.instance
                  .collection('questions')
                  .document(sessionID)
                  .updateData({"status": "complete"});
              Navigator.pop(context);
            },
          )
        ],
        backgroundColor: secondary,
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              MessagesStream(userEmail, sessionID),
              Container(padding: EdgeInsets.only(bottom: 15),
                decoration: messageContainerDecoration,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ImageSelector(userEmail,sessionID),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: 3,
                        style: TextStyle(color: notWhite),
                        controller: messageTextController,
                        onChanged: (value) {
                          messageText = value;
                        },
                        decoration: messageTextFieldDecoration,
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        if (messageText != null) {
                          _firestore
                              .collection('messages')
                              .document(userEmail)
                              .collection(sessionID)
                              .document()
                              .setData({
                            'content': messageText,
                            'sender': 'stylist@aos.com',
                            'type': 'text',
                            'created': Timestamp.now(),
                          });
                          messageTextController.clear();
                        }
                      },
                      child: Icon(
                        Icons.send,
                        color: secondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ImageSelector extends StatefulWidget {
  String userEmail;
  String sessionID;

  ImageSelector(this.userEmail,this.sessionID);

  @override
  _ImageSelectorState createState() =>
      _ImageSelectorState(userEmail, sessionID);
}

class _ImageSelectorState extends State<ImageSelector> {
  String sessionID;
  String userEmail;

  _ImageSelectorState(this.userEmail, this.sessionID);

  File _imageFile = null;
  String Date = new DateTime.now().toString();

  Future getImage(bool isCamera) async {
    File image;
    if (isCamera) {
      image = await ImagePicker.pickImage(source: ImageSource.camera);
    } else {
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
    }

    setState(() {
      _imageFile = image;
      _showModalBottomSheet();
    });
  }

  void bottomModalRefresh() {
    setState(() {
      _showModalBottomSheet();
    });
  }

  Widget uploadButton(BuildContext context) {
    return MaterialButton(
      color: secondary,
      child: Text(
        'Send Image',
        style: buttonStyle2,
      ),
      onPressed: () {
        uploadImage();
        Navigator.pop(context);
      },
    );
  }

  Future uploadImage() async {
    int fileName = new Random().nextInt(10000000);
    StorageReference _refrence =
        FirebaseStorage.instance.ref().child('${fileName}.jpg');
    StorageUploadTask uploadTask = _refrence.putFile(_imageFile);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    String imageUrl = await taskSnapshot.ref.getDownloadURL();
    _firestore
        .collection('messages')
        .document(userEmail)
        .collection(sessionID)
        .document()
        .setData({
      'content': imageUrl,
      'sender': 'stylist@aos.com',
      'type': 'image',
      'created': Timestamp.now(),
    });
  }

  Future<Widget> _showModalBottomSheet() async {
    return await showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: _imageFile == null
                ? 75
                : MediaQuery.of(context).size.height / 2,
            decoration: BoxDecoration(
                color: notWhite, borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                    child: _imageFile == null
                        ? SizedBox()
                        : Image.file(_imageFile)),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: MaterialButton(
                        color: secondary,
                        child: Text(
                          'Camera',
                          style: buttonStyle2,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          getImage(true);
                        },
                      ),
                    ),
                    _imageFile == null ? SizedBox() : uploadButton(context),
                    Expanded(
                      child: MaterialButton(
                        color: secondary,
                        child: Text(
                          'Gallery',
                          style: buttonStyle2,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          getImage(false);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _showModalBottomSheet();
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Icon(
          Icons.image,
          color: secondary,
        ),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  String sessionID;
  String userEmail;

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
          final messageSender = "stylist@aos.com";
          final bool isStylist =
              message.data['sender'] == "stylist@aos.com" ? true : false;
          final messageType = message.data['type'];
          final messageBubble = MessageBubble(
            isStylist: isStylist,
            sender: messageSender,
            content: messageText,
            currentUser: messageSender,
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
  MessageBubble(
      {this.isStylist, this.sender, this.content, this.currentUser, this.type});

  final bool isStylist;
  final String sender;
  final String content;
  final String currentUser;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment:
            isStylist ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          type == 'text' ? textBubble(context) : imageBubble(context)
        ],
      ),
    );
  }

  Widget textBubble(BuildContext context) {
    return Material(
        elevation: 10.0,
        borderRadius: isStylist
            ? BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                topRight: Radius.circular(30))
            : BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomRight: Radius.circular(30)),
        color: secondary,
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
            fit: BoxFit.contain,
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
    return Scaffold(backgroundColor: dark,
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
