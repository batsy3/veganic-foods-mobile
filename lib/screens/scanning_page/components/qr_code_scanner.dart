import 'dart:developer';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:veganic_foods_app/constants.dart';
import 'package:veganic_foods_app/utils/routes.dart';
import 'package:veganic_foods_app/widgets/page_background.dart';
import '../../../widgets/bottom_nav_bar.dart';
import 'https_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QRCodeScanner extends StatefulWidget {
  const QRCodeScanner({Key? key}) : super(key: key);

  @override
  State<QRCodeScanner> createState() => _QRCodeScannerState();
}

class _QRCodeScannerState extends State<QRCodeScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    } else if (Platform.isIOS) {
      controller?.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        bottomNavigationBar: Bottombar(),
        backgroundColor: bGcolor,
        body: SafeArea(
          top: false,
          // bottom: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height:size.height*0.215,
                child: PagesBackground(),
              ),
              Column(
                children: [
                  Container(
                    width: size.width,
                    height: size.height *0.678,
                    // padding:  EdgeInsets.symmetric(vertical: 0.h),
                    decoration:  BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40))),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: size.height*0.02,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                             SizedBox(
                              width: size.width * 0.06,
                            ),
                            IconButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, Routes.home);
                                },
                                icon:  Icon(Icons.arrow_back_ios)),
                             SizedBox(
                              width: size.width *0.18,
                            ),
                             Text(
                              'Scan QR Code',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 20),
                            )
                          ],
                        ),
                        Expanded(
                          flex: 1,
                          child: SafeArea(
                            top: false,
                              minimum:  EdgeInsets.only(
                                top: 10,
                              ),
                              child: _buildQrView(context)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  _onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);
    bool scanned = false;
    controller.scannedDataStream.listen((scanData) {
      if (!scanned) {
        scanned = true;
        setState(() => result = scanData);
        print(result!.code);
        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => Httpp(id: result!.code))));
        controller.pauseCamera();
      }
    });
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 300 ||
            MediaQuery.of(context).size.height < 300)
        ? 150.0
        : 300.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.white,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
