import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:style_of_agent/animated_menu/existing_card.dart';
import 'package:style_of_agent/animated_menu/payment_service.dart';
import 'package:style_of_agent/chatHomepage.dart';
import 'package:style_of_agent/utils/utils.dart';

class PaymentPage extends StatefulWidget {
  PaymentPage({Key key}) : super(key: key);

  @override
  PaymentPageState createState() => PaymentPageState();
}

class PaymentPageState extends State<PaymentPage> {
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
    StripeService.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dark,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xFFc0a948)),
        backgroundColor: Colors.transparent,
        title: Center(
            child: Text(
          'Payment Page',
          style: GoogleFonts.amiri(
            letterSpacing: 2,
            fontSize: 30,
            color: Color(0xFFc0a948),
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
                    title: Text('Session will Cost 1 AOS Diamond'),
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
                                  builder: (context) => ChatHomePage()));
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
                            'Add AOS Diamond via new card',
                            style: inputStyle,
                          );
                          break;
                        case 1:
                          icon = Icon(Icons.credit_card, color: secondary);
                          text = Text(
                            'Add AOS Diamond via existing card',
                            style: inputStyle,
                          );
                          break;
                        case 2:
                          image = Image(
                            image: AssetImage(
                              'assets/images/diamond.png',
                            ),
                            color: secondary,
                            height: 25,
                          );
                          text = Text(
                            'Pay via AOS Diamonds',
                            style: inputStyle,
                          );
                          break;
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
                    itemCount: 3),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
