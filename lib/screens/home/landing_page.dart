import 'package:flutter/material.dart';
import 'package:veganic_foods_app/constants/colors.dart';
import 'package:veganic_foods_app/screens/home/components/backgroundFunc.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(backgroundColor: kBackgroundColor, body:Components()
      // body: PayGate(),
    );
  }
}
