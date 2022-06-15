import 'dart:convert';
import 'package:short_uuids/short_uuids.dart';
import 'package:veganic_foods_app/screens/details_page/components/product_class.dart';
import 'package:http/http.dart' as http;
import '../../../providers/cart_provider.dart';
import 'package:flutter_sms/flutter_sms.dart';

void _sendSMS(String message, String phoneNumber) async {
  final String _result =
      await sendSMS(message: message, recipients: [phoneNumber])
          .catchError((onError) {
    print(onError);
  });
  print(_result);
}

var id = ShortUuid().generate();
List<dynamic> cart = [];
String url = 'http://192.168.137.1:8007/api/order/';
Future<dynamic> gateway(
  String number,
  double cart_total,
) async {
  for (Product item in Cart().cart) {
    cart.add(item.product_id);
  }
  print('cart items = $cart');
  var res = await http.post(Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        "transaction_type_id": 1,
        "msisdn": "$number",
        "amount": cart_total,
        "reference_number": id,
        "request_id": id,
        "description": "transaction"
        // "products": cart
      }));
  Map<String, dynamic> temp = jsonDecode(res.body);
  print('response is ${temp["task_id"]}');
  const status_url = 'http://192.168.137.1:8007/api/order/check_payment_status';
  Future<dynamic>.delayed(Duration(seconds: 120), () async {
    String post_url = status_url + '/${temp["task_id"]}';
    var status = await http.get(Uri.parse(post_url));
    Map<String, dynamic> temp2 = jsonDecode(status.body);
    print('body is ${temp2["data"]}');
    // if (temp2["task"]["status"] == 1) {
    //   final SnackBar snackBar = SnackBar(
    //       padding: EdgeInsets.only(top: 200, bottom: 200, left: 50, right: 50),
    //       content: Container(
    //         decoration: BoxDecoration(
    //           borderRadius: BorderRadius.circular(10),
    //           color: Colors.white,
    //         ),
    //         padding: EdgeInsets.all(10),
    //         child: Center(
    //             child: Text(
    //           'payment failed',
    //           style: TextStyle(
    //               fontSize: 30,
    //               fontWeight: FontWeight.bold,
    //               color: Colors.black),
    //         )),
    //       ));
    //   snackbarKey.currentState?.showSnackBar(snackBar);
    // } else if (temp2[0]["status"] == 2) {
    //   final SnackBar snackBar = SnackBar(
    //       padding: EdgeInsets.only(top: 200, bottom: 200, left: 50, right: 50),
    //       content: Container(
    //         decoration: BoxDecoration(
    //           borderRadius: BorderRadius.circular(10),
    //           color: Colors.white,
    //         ),
    //         padding: EdgeInsets.all(10),
    //         child: Center(
    //             child: Text(
    //           'payment failed',
    //           style: TextStyle(
    //               fontSize: 30,
    //               fontWeight: FontWeight.bold,
    //               color: Colors.black),
    //         )),
    //       ));
    //   snackbarKey.currentState?.showSnackBar(snackBar);
    // } else if (temp2[0]["status"] == 3) {
    //   final SnackBar snackBar = SnackBar(
    //       padding: EdgeInsets.only(top: 200, bottom: 200, left: 50, right: 50),
    //       content: Container(
    //         decoration: BoxDecoration(
    //           borderRadius: BorderRadius.circular(10),
    //           color: Colors.white,
    //         ),
    //         padding: EdgeInsets.all(10),
    //         child: Center(
    //             child: Text(
    //           'payment failed',
    //           style: TextStyle(
    //               fontSize: 30,
    //               fontWeight: FontWeight.bold,
    //               color: Colors.black),
    //         )),
    //       ));
    //   snackbarKey.currentState?.showSnackBar(snackBar);
    // } else {
    //   return Column(
    //     children: [
    //       Text('process timed out please try again'),
    //       ElevatedButton(
    //           onPressed: () {
    //             Get.to(PaymentPage());
    //           },
    //           child: Text('try again'))
    //     ],
    //   );
    // }
  });
}
