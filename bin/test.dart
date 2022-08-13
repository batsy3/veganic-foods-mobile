import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:veganic_foods_app/screens/details_page/components/product_class.dart';

main() async {
  const String postUrl = "http://localhost:8007/api/product/2";
  try {
    var res = await http.get(Uri.parse(postUrl));
    // print(res.body);
//==================================================================
    Map<String, dynamic> productMap = jsonDecode(res.body);
    var products = Product.fromJson(productMap);
    print(products.additions);
  } catch (e) {
    print(e);
  }
}
