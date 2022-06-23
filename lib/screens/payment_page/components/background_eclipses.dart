import 'package:flutter/cupertino.dart';
import 'package:veganic_foods_app/constants.dart';

class backgroundbubbles extends StatelessWidget {
  final String name;
  final double height;
  const backgroundbubbles({
    Key? key,
    required this.name,
    required this.height
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      child: Container(
        decoration: BoxDecoration(
          color: bGcolor
        ),
        height: height,
        child: Stack(
          children: [
            Positioned(
                left: size.width * 0.0,
                top: size.height * 0,
                child: Image.asset('assets/images/Ellipse_9.png')),
            Positioned(
                top: size.height * 0.05,
                left: size.width * 0.95,
                child: Image.asset('assets/images/Ellipse_10.png')),
            Positioned(
                top: size.height * 0.07,
                left: size.width * 0.6,
                child: Image.asset('assets/images/Ellipse_5.png')),
            Positioned(
                left: size.width * 0.1,
                top: size.height * 0.13,
                child: Text(
                  name,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                )),
          ],
        ),
      ),
    );
  }
}
