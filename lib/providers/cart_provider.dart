import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:veganic_foods_app/screens/details_page/components/product_class.dart';
import 'package:veganic_foods_app/utils/globals.dart';

class Cart with ChangeNotifier {
  List<Product> _cart = [];
  double get total {
    double total = 0;
    for (Product i in _cart) {
      total += i.price;
    }
    return total;
  }

  int get count => _cart.length;
  List<Product> get cart => _cart;

  carttotal() {
    double total = 0;
    _cart.forEach((element) {
      total += element.price;
    });
    return total;
  }

  quantity(index) {
    _cart[index].quantity;
  }

  deletefromcart(index) {
    _cart.removeAt(index);
    notifyListeners();
    final SnackBar snackbar = SnackBar(content: Text('item deleted'));
    snackbarKey.currentState?.showSnackBar(snackbar);
  }

  addtoCart(Product product) {
    if (_cart.contains(product)) {
      Get.snackbar('yikes', 'item already exists bucko');
    } else {
      _cart.add(product);
      notifyListeners();

      // final SnackBar snackbar = SnackBar(content: Text('item added'));
      // snackbarKey.currentState?.showSnackBar(snackbar);

    }
  }

  clearall() {
    _cart.clear();
  }
}
