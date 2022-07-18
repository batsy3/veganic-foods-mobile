import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:veganic_foods_app/providers/cart_provider.dart';
import 'package:veganic_foods_app/screens/basket_page/basket.dart';
import 'package:veganic_foods_app/screens/details_page/details.dart';
import 'package:veganic_foods_app/screens/home/home.dart';
import 'package:veganic_foods_app/screens/payment_page/payment.dart';
import 'package:veganic_foods_app/screens/scanning_page/scan.dart';
import 'package:veganic_foods_app/utils/globals.dart';
import 'package:veganic_foods_app/utils/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  Stripe.publishableKey = "pk_test_51LKLbhFeefKhDfbbMxla8Vsz0PxaYJ1f2At2vZPJV1Svub7m0g1KgZLGHj60qx6EDdhwKSWrbXLzXBr4c2DFHKmu00bM2oCqsq";
  // ErrorWidget.builder = (details) => Notfound('$details');
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => Cart())],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return ScreenUtilInit(
      designSize: Size(360, 640),
      builder: ((context, child) => GetMaterialApp(
            key: mainKey,
            scaffoldMessengerKey: snackbarKey,
            title: 'Veganic App',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'SF Pro Rounded',
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            // home:LandingPage(),
            home: Details(
                product_id: 1,
                name: "name",
                description: "description",
                price: 112,
                quantity: 1,
                image: "https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?cs=srgb&dl=pexels-ella-olsson-1640777.jpg&fm=jpg",
                category: 1),
            routes: {
              Routes.home: (context) => LandingPage(),
              Routes.scan: (context) => ScanningPage(),
              Routes.cart: (context) => Basketpage(),
              Routes.payment: (context) => PaymentPage()
            },
            //  Define routes to other pages
          )),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'app.dart';

// void main() => runApp(ProductListApp());
