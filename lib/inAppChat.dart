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
FirebaseUser loggedInUser;

class ChatScreen extends StatefulWidget {
  String userEmail;
  String sessionID;
  ChatScreen(this.userEmail, this.sessionID);

  @override
  _ChatScreenState createState() => _ChatScreenState(userEmail,sessionID);
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  String sessionID;
  String messageText;
  String userEmail;

  _ChatScreenState(this.userEmail,this.sessionID);

  @override
  void initState() {
    checkConnection(context);
    super.initState();
 //   startSession();
  }

  // void startSession() async {
  //   await Firestore.instance
  //       .collection('messages')
  //       .document('users')
  //       .collection('userid')
  //       .document(userEmail)
  //       .setData({'email': userEmail, 'status': 'request'});
  // }

  Stream<DocumentSnapshot> get sessionDetails {
    var qn = Firestore.instance
        .collection('messages')
        .document('users')
        .collection('userid')
        .document(userEmail)
        .snapshots();
    return qn;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dark,
      appBar: AppBar(
//        iconTheme: IconThemeData(color: Color(0xFFE5CF73)),
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
              MessagesStream(userEmail,sessionID),
              MessageBar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget MessageBar() {
    return Container(
      decoration: messageContainerDecoration,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ImageSelector(userEmail,sessionID),
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
                    .document(userEmail)
                    .collection(sessionID)
                    .document()
                    .setData({
                  'content': messageText,
                  'sender': userEmail,
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
    );
  }
}

class ImageSelector extends StatefulWidget {
  String userEmail;
  String sessionID;
  ImageSelector(this.userEmail,this.sessionID);

  @override
  _ImageSelectorState createState() => _ImageSelectorState(userEmail,sessionID);
}

class _ImageSelectorState extends State<ImageSelector> {
  String userEmail;
  String sessionID;
  _ImageSelectorState(this.userEmail,this.sessionID);
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
      'sender': userEmail,
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
          final currentUser = userEmail;
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
            isStylist ? CrossAxisAlignment.start : CrossAxisAlignment.end,
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
                topRight: Radius.circular(30),
                bottomRight: Radius.circular(30))
            : BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                topRight: Radius.circular(30)),
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
