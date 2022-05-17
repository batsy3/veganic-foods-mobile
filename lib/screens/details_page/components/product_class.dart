import 'dart:convert';

class Product {
  // ignore: non_constant_identifier_names
  final int product_id;
  final String name;
  final String imgsrc;
  final String description;

  // ignore: non_constant_identifier_names
  const Product(
      // ignore: non_constant_identifier_names
      {required this.product_id,
      required this.name,
      required this.imgsrc,
      required this.description});
  Product.fromJson(Map<String, dynamic> json)
      : description = json['description'] as String,
        imgsrc = json['imgsrc'] as String,
        name = json['name'] as String ,
        product_id = json['product_id'];
  Map<String, dynamic> toJson() => {
        "product_id": product_id,
        "name": name,
        "imgsrc": imgsrc,
        "description":description,
      };
}

Product productfromjson(String str) => Product.fromJson(jsonDecode(str));
String producttojson(Product data) => jsonEncode(data.toJson());
