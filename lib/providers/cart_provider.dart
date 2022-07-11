import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:veganic_foods_app/screens/details_page/components/product_class.dart';

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
    Get.snackbar('', '',
        messageText: Text('${_cart.elementAt(index).name} removed from the basket'),
        titleText: Text(
          'item  deleted',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        icon: Icon(Icons.remove),
        padding: EdgeInsets.all(15),
        backgroundColor: Colors.amberAccent.shade700);
  }

  addtoCart(Product product) {
    final itemExist =
        _cart.where((element) => element.product_id == product.product_id);
    if (itemExist.isNotEmpty) {
      var addqt = _cart.firstWhere(
          (element) => element.quantity == product.quantity,
          orElse: null);
      addqt.quantity = addqt.quantity + 1;
      Get.snackbar('', '',
          messageText: Text('${product.name} already exists'),
          titleText: Text(
            'oops',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          icon: Icon(Icons.playlist_add_check),
          padding: EdgeInsets.all(15),
          backgroundColor: Colors.amberAccent.shade700);
    } else {
      _cart.add(product);
      notifyListeners();
      Get.snackbar('', '',
          messageText: Text('${product.name} successfuly added to the basket'),
          titleText: Text(
            'item  added',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          icon: Icon(Icons.playlist_add_check),
          padding: EdgeInsets.all(15),
          backgroundColor: Colors.amberAccent.shade700);
    }
  }

  clearall() {
    _cart.clear();
  }
}
