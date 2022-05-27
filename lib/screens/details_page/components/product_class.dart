import 'dart:convert';

class Product {
  // ignore: non_constant_identifier_names
  final int product_id;
  final String name;
  final String description;
  final double price;
   final int quantity;
  final String image;
  final int category;

  // ignore: non_constant_identifier_names
  const Product(
      // ignore: non_constant_identifier_names
      {required this.name,
      required this.product_id,
      required this.description,
      required this.price,
      required this.quantity,
      required this.image,
      required this.category});
  Product.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        description = json['description'] as String,
        price = json['price'],
        product_id = json['product_id'],
        quantity = json['quantity'],
        image = json['image'] as String,
        category = json['category'];
  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "price": price,
        "quantity": quantity,
        "product_id":product_id,
        "image": image,
        "category": category,
      };
}

Product productfromjson(String str) => Product.fromJson(jsonDecode(str));
String producttojson(Product data) => jsonEncode(data.toJson());
