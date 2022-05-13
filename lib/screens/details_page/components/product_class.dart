import 'dart:convert';

class Product {
  // ignore: non_constant_identifier_names
  final int product_id;
  final String name;
  final String imgsrc;

  // ignore: non_constant_identifier_names
  const Product(
      // ignore: non_constant_identifier_names
      {required this.product_id,
      required this.name,
      required this.imgsrc});
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        product_id: json['product_id'] as int,
        name: json['name'] as String,
        imgsrc: json['imgsrc'] as String);
  }
  Map<String, dynamic> toJson() => {
        "product_id": product_id,
        "name": name,
        "imgsrc": imgsrc,
      };
}

Product productfromjson(String str) => Product.fromJson(jsonDecode(str));
String producttojson(Product data) => jsonEncode(data.toJson());

