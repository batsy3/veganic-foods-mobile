import 'package:flutter/material.dart';
import 'components/qr_code_scanner.dart';

class ScanningPage extends StatelessWidget {
  const ScanningPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body:QRCodeScanner()
    );
  }
}
