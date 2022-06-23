import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../screens/scanning_page/scan.dart';

Notfound(String message) {
  return Scaffold(
    body: Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          "assets/images/6_Error.png",
          fit: BoxFit.cover,
        ),
        Container(
          padding:
              const EdgeInsets.only(top: 100, left: 20, right: 20, bottom: 90),
          alignment: Alignment.bottomCenter,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: Size(300, 59),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              primary: Color(0xFF6B92F2),
              onPrimary: Colors.white,
            ),
            onPressed: () {
              Get.to(ScanningPage());
            },
            child: Text('scan again',
                maxLines: 3,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                )),
          ),
        )
      ],
    ),
  );
}
