import 'dart:convert';

class Product {
  // ignore: non_constant_identifier_names
  int product_id;
  String name;
  String description;
  double price;
  List<dynamic> additions;
  int quantity;
  String image;
  List<String> ingredient_images;
  dynamic category;

  // ignore: non_constant_identifier_names
  Product(
      // ignore: non_constant_identifier_names
      {required this.name,
      required this.product_id,
      required this.description,
      required this.price,
      required this.additions,
      required this.quantity,
      required this.image,
      required this.ingredient_images,
      required this.category});
  Product.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        description = json['description'] as String,
        price = json['price'],
        product_id = json['id'],
        quantity = json['quantity'],
        additions = json['additions'],
        image = json['image'] as String,
        category = json['category']['id'],
        ingredient_images = [
          json['ingredient_images']['food_ingredient_image_1'],
          json['ingredient_images']['food_ingredient_image_2'],
          json['ingredient_images']['food_ingredient_image_3'],
          json['ingredient_images']['food_ingredient_image_4'],
          json['ingredient_images']['food_ingredient_image_5'],
        ];
  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "price": price,
        "quantity": quantity,
        "product_id": product_id,
        "image": image,
        "ingredient images": ingredient_images,
        "category": category,
      };
}

Product productfromjson(String str) => Product.fromJson(jsonDecode(str));
String producttojson(Product data) => jsonEncode(data.toJson());
