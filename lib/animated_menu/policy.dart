import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:style_of_agent/widgets/custom_expension_tile.dart' as custom;

class Policy extends StatefulWidget {
  @override
  _PolicyState createState() => _PolicyState();
}

class _PolicyState extends State<Policy> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(3, 9, 23, 1),
      child: SafeArea(
          child: Scaffold(
        backgroundColor: Color.fromRGBO(3, 9, 23, 1),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color.fromRGBO(3, 9, 23, 1),
          title: Align(
            alignment: Alignment.topCenter,
            child: Text(
              " Privacy Policy",
              style: GoogleFonts.amiri(
                letterSpacing: 2,
                fontSize: 30,
                color: Color(0xFFc0a948),
//                fontFamily: "Helvetica",
              ),
            ),
          ),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(children: <Widget>[
              Text(
                "Privacy and Cookies statement",
                style: GoogleFonts.amiri(
                  fontSize: 20,
                  color: Color(0xFFc0a948),
//                  fontFamily: "Helvetica",
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                children: <Widget>[
                  custom.ExpansionTile(
                    iconColor: Colors.white,
                    headerBackgroundColor: Colors.transparent,
                    title: Text(
                      "Our Purposes",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: "FreigSanPro"),
                    ),
                    children: <Widget>[
                      Text(
                        ''' 
The Agents of Style will use your personal data for the following purposes:

The acceptance and processing of your order;

The delivery of your order;

To manage all our relation;

Management information;

To make analyses;

In the event you have a subscription: torecord your preferences,a specific taste, the experiences you had in oorder to serve you even better.

We can also use your personal data to inform you about interesting offers and products of Agents of Style and companies that we work with. We will do that by e-mail, as an sms or push messages in our app. you can choose how you would like to receive these messages.

We can also send newsletters to you. You will receive those until you unsubscribe from this services.

''',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.white, fontFamily: "FreigSanPro"),
                      ),
                    ],
                  ),
                  custom.ExpansionTile(
                    iconColor: Colors.white,
                    headerBackgroundColor: Colors.transparent,
                    title: Text(
                      "Safety of your personal data",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: "FreigSanPro"),
                    ),
                    children: <Widget>[
                      Text(
                        '''
Agents of Style has taken appropriate technical and operational measures to protect your personal data. We have taken measures in order to safeguard the loss, theft or other forms of illegal use of personal data by third parties.

''',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.white, fontFamily: "FreigSanPro"),
                      ),
                    ],
                  ),
                  custom.ExpansionTile(
                    iconColor: Colors.white,
                    headerBackgroundColor: Colors.transparent,
                    title: Text(
                      "Right to access",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: "FreigSanPro"),
                    ),
                    children: <Widget>[
                      Text(
                        '''
You can request access to your personal data. You can see your personal data online in your account. You can amend, change or delete personal data. Please follow the following link in order to update your personal data. https://www.agentsofstyle.net/#/login

''',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.white, fontFamily: "FreigSanPro"),
                      ),
                    ],
                  ),
                  custom.ExpansionTile(
                    iconColor: Colors.white,
                    headerBackgroundColor: Colors.transparent,
                    title: Text(
                      "Content",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: "FreigSanPro"),
                    ),
                    children: <Widget>[
                      Text(
                        '''
In the event you have any questions with respect to the privacy policies we apply, please do not hesitate to contact us by e-mail at info@agentsofstyle.net.

''',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.white, fontFamily: "FreigSanPro"),
                      ),
                    ],
                  ),
                  custom.ExpansionTile(
                    iconColor: Colors.white,
                    headerBackgroundColor: Colors.transparent,
                    title: Text(
                      "Cookies",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: "FreigSanPro"),
                    ),
                    children: <Widget>[
                      Text(
                        '''
Cookies are small text messages and other techniques that leave certain information at your computer when you visit a website.Agents of Style can place cookies. By using cookies we can amongest other ensure that you will not receive the same information again when you visit the website of Agents of Style or that you need to fill out the same information again. Cookies are not used to get privacy related data and passwords from your Computers. You can delete cookies yourself from your computer, tablet and smartphone.''',
                        textAlign: TextAlign.left,
                        style: TextStyle(
//                  letterSpacing: 2,
//                fontSize: 20,
                            color: Colors.white,
                            fontFamily: "FreigSanPro"),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Column(
                children: <Widget>[
                  Text(
                    "General Terms and Conditions",
                    style: GoogleFonts.amiri(
                      fontSize: 20,
                      color: Color(0xFFc0a948),
//                      fontFamily: "Helvetica",
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    '''
Please find below the terms and conditions that will apply to all services, sales, deliveries and other agreement of Agents of Style B.V. to you and with:

''',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.white, fontFamily: "FreigSanPro"),
                  ),
                  custom.ExpansionTile(
                    iconColor: Colors.white,
                    headerBackgroundColor: Colors.transparent,
                    title: Text(
                      "Orders",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: "FreigSanPro"),
                    ),
                    children: <Widget>[
                      Text(
                        '''
1. All your orders and in general all agreements that will be concluded between you and Agents of Style are subject to these general terms and conditions.

2. When you accept an offer of Agents of Style or when you place an order with Agents of Style, you automatically accept the applicability of these general terms and conditions

3. We will not deviate from or amend these general terms and conditions, unless we have explicitly agreed to do so with you in writing.

4. An offer of Agents of Style to offer products for sale is free of legal effect. When you order a product, it is always subject to the availability thereof with our suppliers.

5. A order is given when you submit a purchase order electronically (through our website or our app).

6. Agents of Style reserves the right to change prices of products that are offered for sale. In the event that you have placed a purchase order for a product, we cannot change the price of that product.

''',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.white, fontFamily: "FreigSanPro"),
                      ),
                    ],
                  ),
                  custom.ExpansionTile(
                    iconColor: Colors.white,
                    headerBackgroundColor: Colors.transparent,
                    title: Text(
                      "Payment",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: "FreigSanPro"),
                    ),
                    children: <Widget>[
                      Text(
                        '''7. All our prices for the products and services that we offer are in EURO's and inclusive of VAT. In the event that we deliver products outside the EU and import duties are due, these costs are for your account and will be charged additionally.

8. When you place an order and pay for it, the payment includes the costs for delivery, which will be specified on the invoice.

9. The payment for the products that are ordered has to be received by Agents of Style before the products will be shipped. Payment methods are specified at the website and in the app.

''',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.white, fontFamily: "FreigSanPro"),
                      ),
                    ],
                  ),
                  custom.ExpansionTile(
                    iconColor: Colors.white,
                    headerBackgroundColor: Colors.transparent,
                    title: Text(
                      "Delivery",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: "FreigSanPro"),
                    ),
                    children: <Widget>[
                      Text(
                        '''10. Agents of Style will make all reasonable efforts to deliver products within the period of delivery stated on its website and app or which it has indicatively stated. In the event that the delivery of products takes a longer period of time, this does not give a right to cancel an order and/or to request a refund and/or to claim any kind of compensation.

11. The Agents of Style will deliver products to the address that you have included in your order. The shipment and delivery of products are subject to the terms of delivery of the logistic company that will handle the physical delivery of the products. In the event that the delivery cannot take place because there is no person who can take receipt of the products, generally the logistic company will try to deliver the products again the next workday. In the event that delivery cannot take place (again) the products will be left at a pick up spot or returned to us.

12. In the event that you receive products that are not in the condition that you expected, please inform us immediately and we will make all reasonable efforts to supply you with new products.

13. Products can be returned within 14 days after delivery. In the event that you would like to return the products, please follow the steps for returning goods on our website. We would appreciate to know the reasons for returning products, in order to ensure that you are satisfied with the services and products the next time.

''',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.white, fontFamily: "FreigSanPro"),
                      ),
                    ],
                  ),
                  custom.ExpansionTile(
                    iconColor: Colors.white,
                    headerBackgroundColor: Colors.transparent,
                    title: Text(
                      "Return Shipments",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: "FreigSanPro"),
                    ),
                    children: <Widget>[
                      Text(
                        '''14. Return shipments can only be accepted, in the event that products are still in the original packaging, have the original labels attached to it and not being removed and provided that the products has not been worn or have been rinsed or used in any other way. In the event that we have serious doubts, we can decide not to accepts the products that have been returned.

15. Return shipments have to be made in the original packaging that we used to ship those goods to you or alternatively in any other suitable packaging. Shipment has to take place within 14 days after you received the products. The costs for return delivery are for your account.

''',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.white, fontFamily: "FreigSanPro"),
                      ),
                    ],
                  ),
                  custom.ExpansionTile(
                    iconColor: Colors.white,
                    headerBackgroundColor: Colors.transparent,
                    title: Text(
                      "Stylists",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: "FreigSanPro"),
                    ),
                    children: <Widget>[
                      Text(
                        '''16. Agents of Style offers stylists the opportunity to give advice to you and you are offered the opportunity to use the advice of one or more stylists. Stylists need to act discretely and in accordance with the guidelines that Agents of Style applies in relation to these services. Stylists are independent contractors and not employed by Agents of Style.

17. In the event that you choose for a subscription with of Agents of Style, you can choose to have one stylist advice you, instead of having no choice, which is the case when you do not have a subscription. You can change the stylist that will supply you with advice at any time, in the event that you have a subscription.

18. Although Agents of Style make all reasonable efforts that a stylist will provide services to your satisfaction, Agents of Style cannot be held liable, in the event that a stylist advises you in a way that you did not expect or you were not satisfied about the advice.

19. In the event of force majeure, Agents of Style has the possibility to indicate that another stylist will continue providing services, the delivery of the products will be suspended or an order will be cancelled. In the event that Agents of Style cannot deliver products that are ordered entirely or partly within a reasonable period of time, it will refund any payments that have been made.

''',
                        textAlign: TextAlign.left,
                        style: TextStyle(
//                  letterSpacing: 2,
//                fontSize: 20,
                            color: Colors.white,
                            fontFamily: "FreigSanPro"),
                      ),
                    ],
                  ),
                  custom.ExpansionTile(
                    iconColor: Colors.white,
                    headerBackgroundColor: Colors.transparent,
                    title: Text(
                      "Subscription",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: "FreigSanPro"),
                    ),
                    children: <Widget>[
                      Text(
                        '''21. A subscription has a duration of one calendar month and will automatically renew unless you give notice ultimately one week before the end of a calendar month.

''',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.white, fontFamily: "FreigSanPro"),
                      ),
                    ],
                  ),
                  custom.ExpansionTile(
                    iconColor: Colors.white,
                    headerBackgroundColor: Colors.transparent,
                    title: Text(
                      "Others",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: "FreigSanPro"),
                    ),
                    children: <Widget>[
                      Text(
                        '''22. Your personal data will be used by Agents of Style exclusively for the execution of orders. Agents of Style can forward your name and address to a logistics supplier in order to have your order delivered. Your privacy is safe with us and we will not give your personal data to any third party.

23. Agents of Style can use third parties in order to have an order supplied and shipped.

24. The laws of the Netherlands apply to all orders and agreements.

25. Do you have a complaint, please let us know. We will respond within 14 days. In the event that you are not satisfied with the answers that we give you and would like to institute proceedings, the court in Rotterdam has jurisdiction in case of such dispute. Any proceedings that we will institute will be submitted to the court in Rotterdam exclusively.''',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.white, fontFamily: "FreigSanPro"),
                      ),
                    ],
                  ),
                ],
              ),
            ]),
          ),
        ),
      )),
    );
  }
}
