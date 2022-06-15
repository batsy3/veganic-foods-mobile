import 'dart:convert';
import 'package:veganic_foods_app/screens/details_page/components/product_class.dart';
import 'package:http/http.dart' as http;
import '../../../providers/cart_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_sms/flutter_sms.dart';

void _sendSMS(String message, String phoneNumber) async {
  final String _result =
      await sendSMS(message: message, recipients: [phoneNumber])
          .catchError((onError) {
    print(onError);
  });
  print(_result);
}

var id = Uuid();
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
      body:jsonEncode({
        "transaction_type_id": 1,
        "msisdn": "$number",
        "amount": cart_total,
        "reference_number": id.v4().toString(),
        "request_id": id.v4().toString(),
        "description": "transaction"
        // "products": cart
      }));
  print('response is ${res.body}');
  const status_url = 'http://192.168.137.1:8007/api/check_payment_status';
  Future.delayed(Duration(seconds: 120), () async {
    String post_url = status_url + '/${res.body[0]}';
    var status = await http.get(Uri.parse(post_url));
    print(status.body);
    if (status.body.contains("success")) {
      _sendSMS("Your payment is successfully.reference number is ${res.body}",
          number);
    } else {
      print('payment failed');
    }
  });
  return res;
}
