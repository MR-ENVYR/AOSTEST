import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:style_of_agent/utils/utils.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  bool _visible = false;
  var date = DateTime.now();
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Scaffold(
        backgroundColor: Color.fromRGBO(3, 9, 23, 1),
        appBar: AppBar(
          toolbarHeight: 37.5,
          backgroundColor: Color.fromRGBO(3, 9, 23, 1),
          centerTitle: true,
          actions: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/diamond.png',
                  color: secondary,
                  height: 30,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  '1',
                  style: textTheme3,
                )
              ],
            ),
          ],
          title: AnimatedContainer(
            decoration: BoxDecoration(
              color: Color.fromRGBO(3, 9, 23, 1),
              borderRadius: BorderRadius.circular(10),
            ),
            height: 100,
            width: 200,
//            alignment: FractionalOffset.topCenter + FractionalOffset(-10, 0),
            duration: Duration(seconds: 14),
            child: FlareActor(
              'assets/Animations/AOSF.flr',
              animation: 'fades36',
            ),
          ),
          automaticallyImplyLeading: false,
        ),
        body: AnimatedOpacity(
          duration: Duration(seconds: 2),
          opacity: 1.0,
          child:
//
              ListView(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: secondary),
                child: Padding(
                  padding:
                  const EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'You have received 2 Advices',
                        style: textTheme3,
                      ),
                      Text(
                        'Till ${date.day}-${date.month}-${date.year}',
                        style: textTheme3,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,),
              RichText(
                text: TextSpan(
                  text: 'Clothing from Premium Brands\n',
                  style: GoogleFonts.amiri(
                    fontSize: 23,
                    wordSpacing: 1.5,
                    color: Colors.amber,
                    fontWeight: FontWeight.normal,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text:
                          'A present from yourself for yourself, because you deserve to look and feel great. We send you your clothing of choice - every day, every month, every quarter.',
                      style: GoogleFonts.amiri(
                        fontSize: 17,
                        wordSpacing: 1,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              CarouselSlider(
                items: mywidgets,
                options: CarouselOptions(
                    pauseAutoPlayOnManualNavigate: true,
                    autoPlay: true,
                    aspectRatio: 24 / 24,
                    viewportFraction: 0.6,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: mywidgets.map((prod) {
                  int index = mywidgets.indexOf(prod);
                  return Container(
                    width: 5.0,
                    height: 5.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _current == index
                          ? Colors.red[800].withOpacity(0.8)
                          : Color.fromRGBO(255, 255, 255, 1),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final List<Widget> mywidgets = [
  imgCardt('1.jpg'),
  imgCardt('2.jpg'),
  imgCardt('3.jpg'),
  imgCardt('4.jpg'),
  imgCardt('5.jpg'),
  imgCardt('6.jpg'),
  imgCardt('7.jpg'),
  imgCardt('8.jpg'),
  imgCardt('9.jpg'),
];

Widget imgCardt(String asset) => Card(
      color: Color.fromRGBO(3, 9, 23, 1),
      shape: BeveledRectangleBorder(),
      elevation: 5,
      margin: EdgeInsets.all(10),
      child: Image(
        image: AssetImage('assets/images/looks/$asset'),
        fit: BoxFit.cover,
      ),
    );
