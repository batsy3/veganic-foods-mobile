import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:short_uuids/short_uuids.dart';
import '../screens/details_page/components/product_class.dart';
import '../widgets/network_error_page.dart';

class ApiProvider {
  var id = ShortUuid().generate();

  String _rootUrl = "http://192.168.40.245:8007/api/order";
  Client client = Client();

  Future makePayment(double amount) async {
    var body = jsonEncode({
      "amount": amount.ceil(),
      "currency": "usd",
    });

    try {
      var intentResponse =
          await client.post(Uri.parse(_rootUrl + "/stripe/"), body: body, headers: {
            "Accept":"application/json",
            "Content-Type":"application/json"
          });
      var temp = jsonDecode(intentResponse.body);
      print({"result is ": temp});
      print({"body is": intentResponse.body});
      return ({"client secret is": temp});
    } catch (e) {
      return ({"error is ": e});
    }
  }

  Future<Product> getProduct(String? id) async {
    final response = await client.get(Uri.parse(_rootUrl + '/product/$id'));
    if (response.statusCode == 200) {
      Map<String, dynamic> productMap = jsonDecode(response.body);
      var products = Product.fromJson(productMap);
      return products;
    } else
      return NetworkErrorpage();
  }

  Future<dynamic> gateway(
    String number,
    double cart_total,
  ) async {
    await client
        .post(Uri.parse(_rootUrl + '/order/'),
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
            }))
        .then((value) {
      Map<String, dynamic> temp = jsonDecode(value.body);
      print('value response is ${temp["data"]}');
      print('${value.statusCode}');
      if (value.statusCode != 201) {
        Get.snackbar('Error', 'Something went wrong plese try again',
            snackPosition: SnackPosition.TOP,
            duration: Duration(seconds: 3),
            icon: Icon(Icons.error),
            backgroundColor: Colors.red,
            colorText: Colors.white);
      } else {
        Future<dynamic>.delayed(Duration(seconds: 130), () async {
          var status = await client
              .get(Uri.parse(_rootUrl + '/order/check/${temp["data"]}'));
          var temp2 = status.body;

          print('body is ${temp2}');
          if (temp2.toString().contains('successful') &&
              status.statusCode == 200) {
            return Get.snackbar(
              'Success',
              'your payment was successful',
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.green,
              duration: Duration(seconds: 3),
              colorText: Colors.white,
              icon: Icon(Icons.check),
            );
          } else {
            return Get.snackbar(
              'Sorry',
              'A network error occured while processing your payment please try sagain',
              snackPosition: SnackPosition.TOP,
              colorText: Colors.white,
              backgroundColor: Colors.red.shade700,
              duration: Duration(seconds: 3),
              icon: Icon(Icons.error),
            );
          }
        });
      }
    });
  }
}
