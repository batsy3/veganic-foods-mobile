import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:veganic_foods_app/screens/details_page/components/product_class.dart';

main() async {
  const String postUrl = "http://192.168.100.15:8007/api/product/1 ";
  try {
    var res = await http.get(Uri.parse(postUrl));
    // print(res.body);
//==================================================================
    Map<String, dynamic> productMap = jsonDecode(res.body);
    var products = Product.fromJson(productMap);
    Map result = products.nutritionalValue;
    for (String key in result.keys) {
      print(key);
    }
  } catch (e) {
    print(e);
  }
}
