import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:short_uuids/short_uuids.dart';
import '../screens/details_page/components/product_class.dart';
import '../widgets/network_error_page.dart';

class ApiProvider {
  var id = ShortUuid().generate();

  String _rootUrl = "http://192.168.100.15:8007/api/";
  Client client = Client();

  Future returningCustomer(
      double amount, String customerID, String currency) async {
    var payload = {
      "customerID": customerID,
      "amount": amount.ceil(),
      "currency": currency
    };
    var res = await client.post(
        Uri.parse(_rootUrl + "order/stripe/returning_customer/"),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        },
        body: jsonEncode(payload));
    print(res.body);
    return res.body;
  }

  Future createCustomer() async {
    var customer_id = await client
        .post(Uri.parse(_rootUrl + "order/stripe/create_customer/"), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json"
    });
    var res = jsonDecode(customer_id.body);
    return res;
  }

  Future makePayment(double amount) async {
    var body = jsonEncode({
      "amount": amount.ceil(),
      "currency": "usd",
    });

    try {
      var intentResponse = await client.post(Uri.parse(_rootUrl + "order/stripe/"),
          body: body,
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json"
          });
      Map<String, dynamic> temp = jsonDecode(intentResponse.body);
      return temp;
    } catch (e) {
      return e;
    }
  }

  Future<Product> getProduct(String? id) async {
    final response = await client.get(Uri.parse(_rootUrl + 'product/$id'));
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
    var res = await client
        .post(Uri.parse(_rootUrl + "order/"),
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
