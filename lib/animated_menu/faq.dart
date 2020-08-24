import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:style_of_agent/connection.dart';
import 'package:style_of_agent/widgets/custom_expension_tile.dart' as custom;

class FAQ extends StatefulWidget {
  @override
  _FAQState createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  List<String> sectionsName = [
    'Get Style advice',
    'Stylist',
    'Payment options',
    'My agents of Style',
    'Complaints'
  ];
  List<List<String>> Q = [
    [
      'Can I immediately get style advice?',
      'What does advice look like?',
      'Can I upload multiple photos during an opinion?',
      'How long will my advice remain visible?',
      'Where is my data kept?'
    ],
    ['I am a stylist. Can I also register as a stylist on your app?'],
    [
      'Via which payment method can I buy a style diamond?',
      'Discount codes, vouchers?',
      'What is a style diamond worth? ',
      'Can I return my remaining style diamonds for money? '
    ],
    [
      'I get an error message when logging in.',
      'I forgot my password?',
      'How can I unsubscribe from Agents of Style'
    ],
    ['Are you unable to resolve the matter or do you have a complaint?']
  ];
  List<List<String>> A = [
    [
      'Direct style advice takes place between 8:00 am - 6:00 pm. After that time you can request an advice, but it will only be processed by our stylist the next day.',
      'Advice consists of a conversation with one of our professional stylists. Based on your photo, the stylist will give you advice on the subject and occasion you requested.',
      'In an advisory conversation with a stylist, you may upload multiple photos when it concerns the same issue. As soon as the stylist has completed the advice, the consultation ends and you can no longer use the conversation.',
      'Your received advice will remain visible for a maximum of 1 year.',
      'Your data is stored in a secure environment. You can delete your photos or advice you have received at any time.'
    ],
    [
      'It is possible to register as a stylist. Please send an email to info@agentsofstyle.net \nthen we will contact you.'
    ],
    [
      'You can pay via Ideal, Mastercard, Visa and PayPal, voucher',
      'It is possible to hand in a voucher. If you receive an error message with a code, please contact us at info@agentsofstyle.net',
      '1 style diamond equals 1 style advice. The first 3 diamonds are free, then you are requested to purchase diamonds through our payment options.',
      'Unfortunately this is not possible.'
    ],
    [
      'Contact us at info@agentsofstyle.net',
      'If you have forgotten your password, click on the button “Forgot password” and we will send you a new password as soon as possible.',
      'If you no longer wish to use our service, you can  unsubscribe. We ensure that your data is removed from our systems.'
    ],
    [
      'Then we ask you to contact us via info@agentsofstyle.net We will then contact you as soon as possible.'
    ]
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkConnection(context);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromRGBO(3, 9, 23, 1),
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
//        iconTheme: IconThemeData(color: Color(0xFFE5CF73)),
        title: Text(
          "FAQ",
          style: GoogleFonts.amiri(
            letterSpacing: 2,
            fontSize: 30,
            color: Color(0xFFE5CF73),
//                fontFamily: "FreigSanPro",
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
//        scrollDirection: Axis.vertical,
//        shrinkWrap: true,
//        physics: ClampingScrollPhysics(),
          child: Column(
            children: [
              Text(
                "How can we help you?",
                style: TextStyle(
                  fontFamily: 'FreigSanPro',
                  fontSize: 20,
                  color: Color(0xFFE5CF73),
//                  fontFamily: "Helvetica",
                ),
              ),
              SizedBox(
                height: 15,
              ),
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
//              physics: AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      custom.ExpansionTile(
                        iconColor: Color(0xFFE5CF73),
                        headerBackgroundColor: Colors.transparent,
                        title: Text(
                          sectionsName[index],
                          style: GoogleFonts.amiri(
                            fontSize: 18,
                            color: Color(0xFFE5CF73),
//                  fontFamily: "Helvetica",
                          ),
                        ),
                        children: [
                          SizedBox(
                            height: 8,
                          ),
                          ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
//                          physics: ClampingScrollPhysics(),
                            itemBuilder: (context, i) {
                              return custom.ExpansionTile(
                                iconColor: Colors.white,
                                headerBackgroundColor: Colors.transparent,
                                title: Text(
                                  Q[index][i],
                                  style: TextStyle(
                                    fontFamily: 'FreigSanPro',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
//                  fontFamily: "Helvetica",
                                  ),
                                ),
                                children: [
                                  Text(
                                    A[index][i],
                                    style: TextStyle(
                                      fontFamily: 'FreigSanPro',
//                                      fontSize: 18,
                                      color: Colors.white,
//                  fontFamily: "Helvetica",
                                    ),
                                  ),
                                ],
                              );
                            },
                            itemCount: Q[index].length,
                          )
                        ],
                      ),
//                    SizedBox(
//                      height: 8,
//                    ),
//                    CarouselSlider.builder(
//                        itemCount: Q[index].length,
//                        itemBuilder: (context, i) {
//                          return Container(
//                            child: Card(
//                                color: Color(0xffe1f3ff),
//                                child: Padding(
//                                  padding: const EdgeInsets.only(
//                                      top: 18.0, left: 10, right: 10),
//                                  child: Column(
//                                    children: [
//                                      Text(
//                                        Q[index][i],
//                                        textAlign: TextAlign.justify,
//                                        style: TextStyle(
//                                            color: Colors.black,
//                                            fontFamily: "FreigSanPro",
//                                            fontWeight: FontWeight.w700,
//                                            fontSize: 13),
//                                      ),
//                                      SizedBox(
//                                        height: 5,
//                                      ),
//                                      Text(
//                                        A[index][i],
//                                        textAlign: TextAlign.justify,
//                                        style: TextStyle(
//                                            color: Colors.black,
//                                            fontFamily: "FreigSanPro",
//                                            fontWeight: FontWeight.w500,
//                                            fontSize: 13),
//                                      )
//                                    ],
//                                  ),
//                                )
////                        margin:
////                            EdgeInsets.only(left: 20, bottom: 10, right: 10),
//                                ),
//                          );
//                        },
//                        options: CarouselOptions(
//                            enableInfiniteScroll: false,
//                            initialPage: 0,
//                            autoPlay: true,
//                            enlargeCenterPage: true,
////                          aspectRatio: 200,
//
//                            height: 170)),
                    ],
                  );
                },
                itemCount: sectionsName.length,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
