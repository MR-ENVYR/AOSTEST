import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:style_of_agent/animated_menu/existing_card.dart';
import 'package:style_of_agent/animated_menu/payment_service.dart';
import 'package:style_of_agent/chatHomepage.dart';
import 'package:style_of_agent/connection.dart';
import 'package:style_of_agent/utils/utils.dart';

import '../inAppChat.dart';

class PaymentPage extends StatefulWidget {
  PaymentPage({Key key}) : super(key: key);

  @override
  PaymentPageState createState() => PaymentPageState();
}

class PaymentPageState extends State<PaymentPage> {

   final _auth = FirebaseAuth.instance;
  String userEmail;

  Future getCurrentUser() async {
    FirebaseUser loggedInUser;
    loggedInUser = await _auth.currentUser();
    userEmail = loggedInUser.email;
  }

  onItemPress(BuildContext context, int index) async {
    switch (index) {
      case 0:
        payViaNewCard(context);
        break;
      case 1:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ExistingCardsPage()));
        break;
    }
  }

  payViaNewCard(BuildContext context) async {
    ProgressDialog dialog = new ProgressDialog(context);
    dialog.style(message: 'Please wait...');
    await dialog.show();
    var response =
        await StripeService.payWithNewCard(amount: '15000', currency: 'USD');
    await dialog.hide();
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(response.message),
      duration:
          new Duration(milliseconds: response.success == true ? 1200 : 3000),
    ));
  }

  @override
  void initState() {
    super.initState();

    checkConnection(context);

    StripeService.init();
  }

  @override
  Widget build(BuildContext context) {
    getCurrentUser();
    return Scaffold(
      backgroundColor: dark,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xFFE5CF73)),
        backgroundColor: Colors.transparent,
        title: Center(
            child: Text(
          'Payment Page',
          style: GoogleFonts.amiri(
            letterSpacing: 2,
            fontSize: 30,
            color: Color(0xFFE5CF73),
//                fontFamily: "FreigSanPro",
          ),
        )),
      ),
     floatingActionButton: FloatingActionButton.extended(
       label: Text('Start Session'),
       backgroundColor: secondary,
       onPressed: () {
         showDialog(
             context: context,
             builder: (_) => AlertDialog(
                   title: Text('Session will Cost 1 Style Diamond'),
                   content: Text('DO you want to start session'),
                   actions: <Widget>[
                     FlatButton(
                       child: Text("NO"),
                       onPressed: () {
                         Navigator.pop(context);
                       },
                     ),
                     FlatButton(
                       child: Text("Yes"),
                       onPressed: () {
                         Navigator.push(
                             context,
                             MaterialPageRoute(
                                 builder: (context) => ChatScreen(userEmail)));
                       },
                     ),
                   ],
                 ),
             barrierDismissible: true);
       },
     ),
      body: Container(
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: Container(
                  height: 50,
                  width: 100,
                  color: secondary,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Image(
                        image: AssetImage('assets/images/diamond.png'),
                        height: 30,
                      ),
                      Text(
                        '1',
                        style: textTheme3,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(20),
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      Icon icon;
                      Image image;
                      Text text;
                      switch (index) {
                        case 0:
                          icon = Icon(Icons.add_circle, color: secondary);
                          text = Text(
                            'Add Style Diamond via new card',
                            style: inputStyle,
                          );
                          break;
                        case 1:
                          icon = Icon(Icons.credit_card, color: secondary);
                          text = Text(
                            'Add Style Diamond via existing card',
                            style: inputStyle,
                          );
                          break;
//                        case 2:
//                          image = Image(
//                            image: AssetImage(
//                              'assets/images/diamond.png',
//                            ),
//                            color: secondary,
//                            height: 25,
//                          );
//                          text = Text(
//                            'Pay via Style Diamonds',
//                            style: inputStyle,
//                          );
//                          break;
                      }
                      return InkWell(
                        onTap: () {
                          onItemPress(context, index);
                        },
                        child: ListTile(
                          title: text,
                          leading: image == null ? icon : image,
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => Divider(
                          color: primary,
                        ),
                    itemCount: 2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
