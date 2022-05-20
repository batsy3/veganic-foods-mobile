import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:veganic_foods_app/screens/basket_page/basket.dart';
import 'package:veganic_foods_app/screens/home/home.dart';
import 'package:veganic_foods_app/screens/payment_page/payment.dart';
import 'package:veganic_foods_app/screens/scanning_page/scan.dart';
import 'package:veganic_foods_app/utils/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return MaterialApp(
      title: 'Veganic App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'SF Pro Rounded',
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LandingPage(),
      routes: {
        Routes.home: (context) => const LandingPage(),
        Routes.scan: (context) => const ScanningPage(),
        Routes.cart: (context) => Basketpage(),
        Routes.payment: (context) => const PaymentPage()
      },
      //  Define routes to other pages
    );
  }
}

// import 'package:flutter/material.dart';
// import 'app.dart';

// void main() => runApp(ProductListApp());
