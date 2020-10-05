import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class AnimationAppBar extends StatelessWidget {
  double height, width;
  AnimationAppBar({this.height, this.width});
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      decoration: BoxDecoration(
        color: Color.fromRGBO(3, 9, 23, 1),
        borderRadius: BorderRadius.circular(10),
      ),
      height: height,
      width: width,
      duration: Duration(seconds: 14),
      child: FlareActor(
        'assets/Animations/AOSF.flr',
        animation: 'fades36',
      ),
    );
  }
}
