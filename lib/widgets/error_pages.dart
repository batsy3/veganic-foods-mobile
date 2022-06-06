import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/scanning_page/scan.dart';

Notfound() {
  return Scaffold(
    body: Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          "assets/images/2_404 Error.png",
          fit: BoxFit.cover,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            primary: Color(0xFF6B92F2),
            onPrimary: Colors.white,
            padding:
                EdgeInsets.only(top: 400, bottom: 20, left: 100, right: 100),
          ),
          onPressed: () {
            Get.to(ScanningPage());
          },
          child: Text(
            "something  went wrong, please check your internet connection or make sure the bar code is correct",
            maxLines: 3,
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
    ),
  );
}
