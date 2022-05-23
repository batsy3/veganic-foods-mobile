// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:flutter_cart/model/cart_model.dart';
import 'package:flutter_number_picker/flutter_number_picker.dart';
import 'package:get/get.dart';
import 'package:veganic_foods_app/constants.dart';
import 'package:veganic_foods_app/utils/controller.dart';
import 'package:veganic_foods_app/utils/routes.dart';
import 'package:veganic_foods_app/widgets/custom_button.dart';

class Details extends StatefulWidget {
  // final Future<Product>? item;
  // late Future<Product>? item = [] as Future<Product>?;
  final int product_id;
  final String name;
  final String description;
  final double price;
  final int quantity;
  final String image;
  final int category;
  const Details({
    Key? key,
    // ignore: non_constant_identifier_names
    required this.product_id,
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    required this.image,
    required this.category,
  }) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  var price;
  @override
  void initState() {
    // super.initState();
    price = widget.price;
  }
  final Controller controller = Get.put(Controller());
  @override
  Widget build(BuildContext context) {
    var additions = <String>['addition'];
    String val = additions[0].toString();
    Size size = MediaQuery.of(context).size;
    var init_price = widget.price;
    return Scaffold(
        body: Container(
      // decoration: BoxDecoration(
      //     color: bGcolor,
      //     image: DecorationImage(
      //         image: NetworkImage(widget.image), fit: BoxFit.fitHeight)),
      child: Stack(children: [
        Column(
          children: [
            const SizedBox(
              height: 170,
            ),
            Container(
              width: size.width,
              height: size.height * 0.715,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 20, left: 20),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios),
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.scan);
                          },
                        ),
                        const SizedBox(
                          width: 180,
                        ),
                        Text(
                          'K ${widget.price}',
                          style: TextStyle(
                              fontSize: 35, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Center(
                        child: Column(
                          children: [
                            Text(
                              'Description',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ],
                        ),
                      )),
                      const VerticalDivider(
                        width: 1,
                      ),
                      Expanded(
                          child: const Center(
                        child: Text(
                          ' Nutritional value',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      )),
                    ],
                  ),
                  const Divider(
                    indent: 220,
                    endIndent: 20,
                    thickness: 1,
                    color: Colors.black,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 50, right: 10, top: 0, bottom: 40),
                          child: Text(
                            widget.description,
                          ),
                        ),
                      ),
                      const VerticalDivider(
                        width: 1.0,
                      ),
                      Expanded(
                          child: Container(
                        padding: const EdgeInsets.only(left: 30, right: 10),
                        child: Center(
                            child: Column(
                          children: [
                            const Text(
                              '',
                              textWidthBasis: TextWidthBasis.parent,
                            ),
                          ],
                        )),
                      ))
                    ],
                  ),
                  const Divider(
                    indent: 220,
                    endIndent: 20,
                    thickness: 1,
                    color: Colors.black,
                  ),
                  Container(
                      padding: const EdgeInsets.only(left: 220),
                      child: Row(
                        children: const [
                          Icon(Icons.check),
                          SizedBox(
                            width: 10,
                          ),
                          Text('15 cals'),
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            '*daily value',
                            style: TextStyle(fontSize: 10),
                          )
                        ],
                      )),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 200),
                    child: Text(
                      'Ingredients',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      Container(
                        width: size.width * 0.85,
                        height: size.height * 0.1,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 249, 253, 255),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 3,
                                  spreadRadius: -3,
                                  offset: Offset(0.84, 5))
                            ],
                            borderRadius:
                                BorderRadius.all(Radius.circular(40))),
                        child: ingredient_images(),
                      ),
                    ],
                  ),
                  // Multipleselect(),
                  const SizedBox(
                    height: 15,
                  ),
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(right: 200),
                        child: Text(
                          'Additions',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.05,
                        width: size.width * 0.7,
                        child: DropdownButton(
                            underline: Container(
                              height: 1,
                              color: Colors.deepPurple,
                            ),
                            elevation: 9,
                            value: val,
                            isExpanded: true,
                            hint: Text(
                              'pick an addition',
                            ),
                            icon: Icon(Icons.keyboard_arrow_down_sharp),
                            items: additions
                                .map((String e) =>
                                    DropdownMenuItem(value: e, child: Text(e)))
                                .toList(),
                            onChanged: (String? newVal) {
                              setState(() {
                                val = newVal!;
                              });
                            }),
                      )
                    ],
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 40),
                          child: Text(
                            'K $price',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 30),
                        child: Flex(
                          direction: Axis.horizontal,
                          children: [
                            CustomNumberPicker(
                                onValue: (newvalue) {
                                  setState(() {
                                    price = (price + init_price);
                                  });
                                  print(price);
                                },
                                initialValue: 1,
                                maxValue: 20,
                                minValue: 1,
                                step: 1),
                            const SizedBox(
                              width: 80,
                            ),
                            Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(boxShadow: [
                                BoxShadow(
                                    blurRadius: 10,
                                    spreadRadius: -5,
                                    offset: Offset(0.84, 5)),
                              ], color: Colors.white, shape: BoxShape.circle),
                              child: Badge(
                                padding: EdgeInsets.all(3),
                                shape: BadgeShape.circle,
                                badgeColor: bGcolor,
                                child: Icon(
                                  Icons.shopping_basket,
                                  size: 30,
                                ),
                                //cart item count
                                badgeContent: Text(
                                    '${controller.cart.getCartItemCount()}'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  AppButton(
                      text: 'Add to Basket',
                      fontSize: 20,
                      textColor: Colors.white,
                      bgColor: Colors.black,
                      onTap: () {
                        controller.addtocart(widget.product_id, price);
                        Navigator.pushNamed(context, Routes.cart);
                      },
                      fontWeight: FontWeight.normal,
                      borderRadius: 40,
                      height: 24)
                ],
              ),
            ),
          ],
        ),
        Align(
          alignment: const Alignment(-0.6, -0.58),
          child: Container(
              decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 8, spreadRadius: -7, offset: Offset(0.8, 5))
                  ],
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              width: size.width * 0.5,
              height: size.height * 0.07,
              child: Center(
                child: Text(
                  widget.name,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              )),
        ),
      ]),
    ));
  }
}

List images = [];

// ignore: camel_case_types
class ingredient_images extends StatelessWidget {
  const ingredient_images({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: images.length,
      itemBuilder: (BuildContext context, int index) {
        return ListBody(children: [
          Row(
            children: [
              Image.asset(
                images.elementAt(index),
                height: 90,
                fit: BoxFit.fitHeight,
              ),
              const VerticalDivider(
                width: 8,
                thickness: 0,
              )
            ],
          ),
        ]);
      },
    );
  }
}
