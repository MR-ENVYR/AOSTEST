import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class IntroWidget extends StatelessWidget {
  const IntroWidget(
      {Key key,
      @required this.screenWidth,
      @required this.screenheight,
      this.image,
      this.type,
      this.startGradientColor,
      this.endGradientColor,
      this.subText})
      : super(key: key);

  final double screenWidth;
  final double screenheight;
  final image;
  final type;
  final Color startGradientColor;
  final Color endGradientColor;
  final String subText;

  @override
  Widget build(BuildContext context) {
    final Shader linearGradient = LinearGradient(
      colors: <Color>[startGradientColor, endGradientColor],
    ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

    return Stack(
      children: <Widget>[
        ShaderMask(
          shaderCallback: (rect) {
            return LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.white, Colors.black87],
            ).createShader(
                Rect.fromLTRB(0, -100, rect.width, rect.height - 10));
          },
          blendMode: BlendMode.darken,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.transparent, Colors.grey],
                  begin: FractionalOffset(0, 0),
                  end: FractionalOffset(0, 1),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
              image: DecorationImage(
                image: ExactAssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(bottom: 140.0, left: 20, right: 20),
          alignment: Alignment.bottomLeft,
          child: Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: <Widget>[
              Opacity(
                opacity: 0.90,
                child: Container(
                  height: screenheight * 0.13,
                  child: Text(
                    type.toString().toUpperCase(),
                    style: TextStyle(
                        fontFamily: "Helvetica",
                        fontSize: 32.0,
                        fontWeight: FontWeight.w400,
                        foreground: Paint()..shader = linearGradient),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.bottomLeft,
          padding:
              EdgeInsets.only(bottom: 80.0, left: 20.0, right: 20.0, top: 10),
          child: Text(
            subText,
            style: TextStyle(
                fontSize: 16.0,
                fontFamily: "Helvetica",
                fontWeight: FontWeight.w200,
                color: Colors.white,
                letterSpacing: 1.0),
          ),
        )
      ],
    );
  }

//  TextStyle buildTextStyle(double size) {
//    return TextStyle(
//      fontSize: size,
//      fontWeight: FontWeight.w900,
//      height: 0.5,
//    );
//  }
}
