import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:veganic_foods_app/basketPage/basketPage.dart';
import 'package:veganic_foods_app/screens/home/landing_page.dart';
import 'package:veganic_foods_app/utils/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        )
    );
    return MaterialApp(
      title: 'Veganic App',
      theme: ThemeData(
        fontFamily: 'SF Pro Rounded',
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: Basketpage(),
      home: const LandingPage(),
    routes: {
        Routes.home : (context) => const LandingPage(),
        Routes.home : (context) => const S
    },
    //  Define routes to other pages
    );
  }
}

