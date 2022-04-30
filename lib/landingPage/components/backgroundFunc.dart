// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import 'backgroundUtils.dart';

class Components extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    const color = Color.fromARGB(255, 81, 43, 170);

    //total height and width of screen
    return Background(
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  primary: Colors.white,
                  onPrimary: color,
                  textStyle:
                      TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  minimumSize: Size(280, 80)),
              child: Text('GET STARTED'),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
