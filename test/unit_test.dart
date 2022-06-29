import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:test/test.dart';
import 'package:veganic_foods_app/providers/cart_provider.dart';
import 'package:veganic_foods_app/screens/details_page/components/product_class.dart';

List<Product> fixture_data = [
  Product(
      name: 'food 1',
      product_id: 1,
      description: 'first food',
      price: 3,
      quantity: 1,
      image: 'assets/images/toppng_1.png',
      category: 1),
  Product(
      name: 'food 2',
      product_id: 2,
      description: 'second food',
      price: 4,
      quantity: 1,
      image: 'assets/images/toppng_1.png',
      category: 1),
  Product(
      name: 'food 3',
      product_id: 3,
      description: 'third food',
      price: 5,
      quantity: 1,
      image: 'assets/images/toppng_1.png',
      category: 1),
  Product(
      name: 'food 4',
      product_id: 4,
      price: 2,
      description: 'fourth',
      quantity: 1,
      image: 'assets/images/toppng_1.png',
      category: 1)
];
main() {
  late Cart cart = Cart();
  setUpAll(() {
    for (Product i in fixture_data) {
      cart.addtoCart(i);
    }
  });
  group('cart provider tests', () {
    test('testing basic functionalities ', () {
      expect(cart.cart, isNotEmpty);
      expect(cart.count, 4);
      expect(cart.total, 14);
      expect(cart.carttotal(), 14);
    });
    test('clear function', () {
      cart.clearall();
      expect(cart.cart, isEmpty);
      expect(cart.carttotal(), 0);
      expect(cart.count, 0);
    });
  });
  group('futures test', () {
    test('scan async function', () async {
      final client = ApiProvider();
      final mockHttpClient = MockClient((request) async{
        final response = {
          "name": 'food 1',
          "product_id": 1,
          "description": 'first food',
          "price": 3,
          "quantity": 1,
          "image": 'assets/images/toppng_1.png',
          "category": 1
        };
        return Response(jsonEncode(response), 200);
      });
      final result = await ApiProvider.getData(mockHttpClient)
    });
  });
}
