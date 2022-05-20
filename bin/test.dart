import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:veganic_foods_app/screens/details_page/components/product_class.dart';

main() async {
  const String postUrl = "http://127.0.0.1:8007/api/product/1";
  // Future<Product> _getdata() async {
    // String url = postUrl + '/$id';
    var res = await http.get(Uri.parse(postUrl));
    if (res.statusCode == 200) {
//==================================================================
      Map<String, dynamic> productMap = jsonDecode(res.body);
      var products = Product.fromJson(productMap);
      print (products.name);
      // return products;
//====================================================================
      // final parsed = jsonDecode(res.body).cast<String, dynamic>();
      // return parsed.map<Product>((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('failed to load');
    }
  }


