import 'dart:io';
import 'dart:math';

//import 'package:agent_of_style/theme.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:style_of_agent/utils/utils.dart';

final _firestore = Firestore.instance;
FirebaseUser loggedInUser;

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
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
        print(loggedInUser.email);
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
        title: Text(
          'Tracy MacMonday',
          style: textTheme3,
        ),
        backgroundColor: primary,
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              MessagesStream(),
              Container(
                decoration: messageContainerDecoration,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ImageSelector(),
                    Expanded(
                      child: TextField(
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
                              .document('mayank')
                              .collection('chat')
                              .document()
                              .setData({
                            'content': messageText,
                            'sender': loggedInUser.email,
                            'type': 'text',
                            'created': Timestamp.now(),
                          });
                          messageTextController.clear();
                        }
                      },
                      child: Text(
                        'Send',
                        style: sendButtonTextStyle,
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
  @override
  _ImageSelectorState createState() => _ImageSelectorState();
}

class _ImageSelectorState extends State<ImageSelector> {
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
        .document('mayank')
        .collection('chat')
        .document()
        .setData({
      'content': imageUrl,
      'sender': loggedInUser.email,
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
                        ? Text('NO Image Selected')
                        : Image.file(_imageFile)),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: MaterialButton(
                        color: primary,
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
                        color: primary,
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
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('messages')
          .document('mayank')
          .collection('chat')
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
        color: isCurrentUser ? secondary : primary,
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
