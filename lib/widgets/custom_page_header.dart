import 'package:flutter/material.dart';

class PageHeader extends StatelessWidget {
  const PageHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Stack(
        children: const [
          Positioned(
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
          Positioned(
            left: 80.0,
            top: 90.0,
            right: null,
            bottom: null,
            width: 52.0,
            height: 20.0,
            child: Text('Hi User', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
          ),
          Positioned(
            left: 80.0,
            top: 120.0,
            right: null,
            bottom: null,
            width: 241.0,
            height: 20.0,
            child: Text('What would like to order today?', style: TextStyle(fontSize: 16)),
          ),
      ],
    ),
    );
  }
}
