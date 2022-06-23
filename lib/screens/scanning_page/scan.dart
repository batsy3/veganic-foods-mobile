import 'package:flutter/material.dart';
import 'package:veganic_foods_app/screens/scanning_page/components/qr_code_scanner.dart';

class ScanningPage extends StatelessWidget {
  const ScanningPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QRCodeScanner();
  }
}
