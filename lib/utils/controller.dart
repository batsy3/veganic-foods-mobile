import 'package:flutter_cart/flutter_cart.dart';
import 'package:get/get.dart';

class Controller extends GetxController {
  var cart = FlutterCart();

  increment(index) {
    cart.incrementItemToCart(index);
  }
}
