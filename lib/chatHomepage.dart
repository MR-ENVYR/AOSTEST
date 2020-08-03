import 'package:agent_of_style/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class ChatHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Agents of Style',
            style: textTheme3,
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
  @override
  Widget build(BuildContext context) {
    return Container(color:dark,
      child: ChatHeads(),
    );
  }

  Widget ChatHeads() {
    return ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/chat-window');
            },
            child: Container(
              margin: EdgeInsets.only(top: 10, left: 10, right: 10),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: purple,
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 6.0,
                ),
              ], color: purple, borderRadius: BorderRadius.circular(5)),
              child: ListTile( 
                title: Text('Tracy MacMonday',style: TextStyle(color:notWhite),),
                subtitle: Text('Hello',style: TextStyle(color: notWhite.withOpacity(0.5)),),
                trailing: Text('Active',style: TextStyle(color: Colors.green),),
              ),
            ),
          );
        });
  }
}
