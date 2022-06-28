import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:short_uuids/short_uuids.dart';
import 'package:veganic_foods_app/screens/details_page/components/product_class.dart';
import 'package:http/http.dart' as http;
import '../../../providers/cart_provider.dart';

var id = ShortUuid().generate();
List<dynamic> cart = [];
String url = 'http://192.168.235.5:8007/api/order/';
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
  print('response is ${temp["data"]}');
  print('${res.statusCode}');
  if (res.statusCode != 201) {
    Get.snackbar('Error', 'Something went wrong',
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 3),
        icon: Icon(Icons.error),
        backgroundColor: Colors.red,
        colorText: Colors.white);
  }
  const status_url = 'http://192.168.235.5:8007/api/order/check';
  Future<dynamic>.delayed(Duration(seconds: 120), () async {
    String post_url = status_url + '/${temp["data"]}';
    var status = await http.get(Uri.parse(post_url));
    // Map<String, dynamic> temp2 = jsonDecode(status.body);    // Map<String, dynamic> temp2 = jsonDecode(status.body);
    var temp2 =status.body;

    print('body is ${temp2}');
    if (temp2.toString().contains('successful') && status.statusCode == 200) {
      return Get.snackbar(
        'Success',
        'your payment was successful',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        duration: Duration(seconds: 3),
        colorText: Colors.white,
        icon: Icon(Icons.check),
      );
    } else if (temp.toString().contains('error') && status.statusCode == 400) {
      return Get.snackbar(
        'Sorry',
        'A network error occured while processing your payment please try sagain',
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
        backgroundColor: Colors.red.shade700,
        duration: Duration(seconds: 3),
        icon: Icon(Icons.error),
      );
    }else{
      return Get.snackbar(
        'Sorry',
        'A connection issue occured please try again after some time',
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.shade700,
        duration: Duration(seconds: 3),
        icon: Icon(Icons.check),
      );
    }
  });
}
