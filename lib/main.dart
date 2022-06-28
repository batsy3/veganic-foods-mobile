import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:veganic_foods_app/providers/cart_provider.dart';
import 'package:veganic_foods_app/screens/basket_page/basket.dart';
import 'package:veganic_foods_app/screens/home/home.dart';
import 'package:veganic_foods_app/screens/payment_page/payment.dart';
import 'package:veganic_foods_app/screens/scanning_page/scan.dart';
import 'package:veganic_foods_app/utils/globals.dart';
import 'package:veganic_foods_app/utils/routes.dart';
import 'package:veganic_foods_app/widgets/error_pages.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'screens/details_page/details.dart';

void main() {
  ErrorWidget.builder =(details) => Notfound('$details');
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
      builder:((context, child) =>  GetMaterialApp(
        key: mainKey,
        scaffoldMessengerKey: snackbarKey,
        title: 'Veganic App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'SF Pro Rounded',
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: LandingPage(),
        routes: {
          Routes.home: (context) => LandingPage(),
          Routes.scan: (context) => ScanningPage(),
          Routes.cart: (context) => Basketpage(),
          Routes.payment: (context) => const PaymentPage()
        },
        //  Define routes to other pages
      )),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'app.dart';

// void main() => runApp(ProductListApp());
