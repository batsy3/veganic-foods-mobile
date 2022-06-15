import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; //total height and width of screen

    return SizedBox(
      height: size.height,
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          Positioned(
              top: size.height * 0.3,
              left: size.width * 0.5,
              child: Image.asset(
                "assets/images/Ellipse_1.png",
                fit: BoxFit.cover,
              )),
          Positioned(
              top: 105,
              left: 83,
              child: Image.asset(
                "assets/images/Ellipse_2.png",
                fit: BoxFit.cover,
              )),
          Positioned(
              top: -17,
              left: 358,
              child: Image.asset(
                "assets/images/Ellipse_3.png",
                fit: BoxFit.cover,
              )),
          Positioned(
              top: 622,
              left: -22,
              child: Image.asset(
                "assets/images/Ellipse_4.png",
                fit: BoxFit.cover,
              )),
          Positioned(
              top: 561,
              left: 79,
              child: Image.asset(
                "assets/images/Ellipse_5.png",
                fit: BoxFit.cover,
              )),
          Positioned(
              top: 383,
              left: 358,
              child: Image.asset(
                "assets/images/Ellipse_6.png",
                fit: BoxFit.cover,
              )),
          Positioned(
              top: 620,
              left: 380,
              child: Image.asset(
                "assets/images/Ellipse_1.png",
                fit: BoxFit.cover,
              )),
          Positioned(
              top: size.height * 0.2,
              left: size.width * 0.3,
              child: Image.asset(
                "assets/images/app_logo.png",
                fit: BoxFit.cover,
              )),
          Positioned(
              top: size.height * 0.5,
              left: size.width * 0.25,
              child: Image.asset(
                "assets/images/landing_topping.png",
                fit: BoxFit.cover,
              )),
          Positioned(bottom: 0, left: 20, right: 20, child: child),
        ],
      ),
    );
  }
}
