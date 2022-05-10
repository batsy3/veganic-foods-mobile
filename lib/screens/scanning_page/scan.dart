import 'package:flutter/material.dart';
import 'package:veganic_foods_app/widgets/custom_page_header.dart';
import 'package:veganic_foods_app/widgets/default_back_button.dart';

import 'components/qr_code_scanner.dart';

class ScanningPage extends StatelessWidget {
  const ScanningPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return const Scaffold(
      backgroundColor: Colors.white,
      body:QRCodeScanner()
    );
  }
}
