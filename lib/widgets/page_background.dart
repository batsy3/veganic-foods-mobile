import 'package:flutter/material.dart';
import 'package:veganic_foods_app/widgets/custom_page_header.dart';
class PagesBackground extends StatelessWidget {
  const PagesBackground({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: [
          Positioned(
              left: -14.0,
              top: -11.0,
              width: 70.0,
              height: 70.0,
              child: Image.asset('assets/images/Ellipse_9.png')),
          Positioned(
              top: 70,
              left: 374,
              child: Image.asset('assets/images/Ellipse_10.png')),
          const Positioned(
            left: 22.0,
            top: 84.0,
            right: null,
            bottom: null,
            width: 35.0,
            height: 35.0,
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/avatars/user-female.png'),
            ),
          ),
          const Positioned(
            left: 80.0,
            top: 90.0,
            right: null,
            bottom: null,
            width: 52.0,
            height: 20.0,
            child: Text('Hi User', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
          ),
          const Positioned(
            left: 80.0,
            top: 120.0,
            right: null,
            bottom: null,
            width: 241.0,
            height: 20.0,
            child: Text('What would like to order today?', style: TextStyle(fontSize: 16)),
          ),
          Positioned(
              top: 26,
              left:239,
              width: 13.0,
              height: 13.0,
              child: Image.asset('assets/images/Ellipse_5.png')),
                  ],
      ),
      height: 130,
    );
  }
}