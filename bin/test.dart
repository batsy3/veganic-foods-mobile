import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:veganic_foods_app/screens/details_page/components/product_class.dart';

main() async {
  const String postUrl = "http://192.168.40.148:8000/products/1";
  // Future<Product> _getdata() async {
    // String url = postUrl + '/$id';
    var res = await http.get(Uri.parse(postUrl));
    if (res.statusCode == 200) {
//==================================================================
      Map<String, dynamic> productMap = jsonDecode(res.body);
      var products = Product.fromJson(productMap);
      return products;
      // return products;
//====================================================================
      // final parsed = jsonDecode(res.body).cast<String, dynamic>();
      // return parsed.map<Product>((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('failed to load');
    }
  }


