import 'package:flutter/material.dart';

class RadiotileCSS extends StatelessWidget {
  final String text;
  final String imagestring;
  const RadiotileCSS({
    Key? key,
    required this.text,
    required this.imagestring,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(children: <Widget>[
      InkWell(
        child: Row(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Image.asset(
              imagestring,
              height: 25,
            ),
            SizedBox(
              width: size.height * 0.02,
            ),
            Text(
              text,
              // ignore: prefer_const_constructors
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    ]);
  }
}
