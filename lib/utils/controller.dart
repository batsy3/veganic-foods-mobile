import 'package:flutter_cart/flutter_cart.dart';
import 'package:get/get.dart';

class Controller extends GetxController {
  var cart = FlutterCart();
  increment(index) {
    cart.incrementItemToCart(index);
  }

  decrement(index) {
    cart.decrementItemFromCart(index);
  }

  addtocart(product_id, product_price) {
    cart.addToCart(productId: product_id, unitPrice: product_price);
  }

  deleteitem(index) {
    cart.deleteItemFromCart(index);
  }

  total() {
    cart.getTotalAmount();
  }

  getitem(cart_id) {
    cart.getSpecificItemFromCart(cart_id);
  }
}
