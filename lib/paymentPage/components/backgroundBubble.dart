import 'package:flutter/cupertino.dart';

class backgroundbubbles extends StatelessWidget {
  final String name;
  const backgroundbubbles({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        child: Stack(
          children: [
            Positioned(
                top: -5,
                left: -14,
                child: Image.asset('assets/images/Ellipse 3 (1).png')),
            Positioned(
                top: 70,
                left: 374,
                child: Image.asset('assets/images/Ellipse 4 (1).png')),
            Positioned(
                top: 50,
                left: 100,
                child: Image.asset('assets/images/Ellipse_5.png')),
            Positioned(
                top: 90,
                left: 30,
                child: Text(
                  name,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                )),
          ],
        ),
      ),
      height: 130,
    );
  }
}
