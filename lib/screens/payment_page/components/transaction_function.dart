import 'dart:convert';
import 'package:veganic_foods_app/screens/details_page/components/product_class.dart';
import 'package:http/http.dart' as http;
import '../../../providers/cart_provider.dart';
import 'package:uuid/uuid.dart';

var id = Uuid();
List<Product> cart = [];
String url = 'http://192.168.40.98:8007/api/order/';
Future<http.Response> gateway(
  String number,
  cart_total,
) async{
  for (Product item in Cart().cart) {
    cart.add(item);
  }
  print('cart items = $cart');
  http.Response res = await http.post(Uri.parse(url), body:json.encode({
    'transaction_type_id': 1,
    'msisdn': number,
    'amount': cart_total,
    'reference_number': id.v4(),
    'request_id': id.v1(),
    'description': 'deposit',
    // 'product': jsonEncode(cart),
  }));
  print(res.headers);
  return res;
}
