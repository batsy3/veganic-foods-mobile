import 'package:flutter/material.dart';
import 'package:veganic_foods_app/screens/details_page/components/product_class.dart';
import 'package:veganic_foods_app/utils/globals.dart';

class Cart with ChangeNotifier {
  List<Product> _cart = [];
  int get count => _cart.length;
  List<Product> get cart => _cart;

  itemtotal(index) {
    _cart[index].price;
  }

  carttotal() {
    double total = 0.0;
    for (Product item in _cart) {
      if (_cart.isNotEmpty == true) {
        total = total + item.price;
        return total;
      } else {
        return total;
      }
    }
  }

  deletefromcart(index) {
    _cart.removeAt(index);
    notifyListeners();
    final SnackBar snackbar = SnackBar(content: Text('item deleted'));
    snackbarKey.currentState?.showSnackBar(snackbar);
    print(_cart.isNotEmpty);
    print(_cart.length);
  }

  addtoCart(Product product) {
    if (_cart.contains(product.product_id)) {
      print('item exists');
    } else {
      _cart.add(product);
      print(_cart.isNotEmpty);
      notifyListeners();
      final SnackBar snackbar = SnackBar(content: Text('item added'));
      snackbarKey.currentState?.showSnackBar(snackbar);
      return snackbar;
    }
  }
}
