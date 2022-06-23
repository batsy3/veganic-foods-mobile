import 'package:flutter/material.dart';
class PagesBackground extends StatelessWidget {
  const PagesBackground({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      child: Stack(
        children: [
          Positioned( 
              left: size.width*0.0,
              top: size.height * 0,
              child: Image.asset('assets/images/Ellipse_9.png')),
          Positioned(
              top: size.height*0.05,
              left: size.width*0.95,
              child: Image.asset('assets/images/Ellipse_10.png')),
           Positioned(
            left: size.width * 0.07,
            top: size.height*0.1,
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/avatars/user-female.png'),
            ),
          ),
           Positioned(
            left: size.width*0.2 ,
            top:size.height*0.11,
            right: null,
            bottom: null,
            child: Text('Hi User', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
          ),
           Positioned(
            left:size.width*0.19,
            top: size.height*0.13,
            right: null,
            bottom: null,
            child: Text('What would like to order today?', style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal)),
          ),
          Positioned(
              top: size.height*0.07,
              left:size.width*0.6,
              child: Image.asset('assets/images/Ellipse_5.png')),
                  ],
      ),
    );
  }
}