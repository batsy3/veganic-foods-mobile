// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:veganic_foods_app/constants.dart';
import 'package:veganic_foods_app/providers/cart_provider.dart';
import 'package:veganic_foods_app/screens/details_page/components/product_class.dart';
import 'package:veganic_foods_app/utils/routes.dart';
import 'package:veganic_foods_app/widgets/bottom_nav_bar.dart';
import 'package:veganic_foods_app/widgets/custom_button.dart';

// ignore: must_be_immutable
class Details extends StatefulWidget {
  int product_id;
  String name;
  String description;
  double price;
  Map nutritionalValue;
  List<dynamic> additions;
  List<String> ingredient_images;
  String calories;
  int quantity;
  String image;
  dynamic category;
  Details({
    Key? key,
    // ignore: non_constant_identifier_names
    required this.nutritionalValue,
    required this.product_id,
    required this.calories,
    required this.additions,
    required this.ingredient_images,
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
  late Product prod;
  late double price;
  late int _count;
  late List<DropdownMenuItem<dynamic>> additions = [];
  late String _selectedAddition;
  @override
  // ignore: must_call_super
  void initState() {
    prod = Product(
        name: widget.name,
        product_id: widget.product_id,
        description: widget.description,
        price: widget.price,
        quantity: widget.quantity,
        image: widget.image,
        ingredient_images: widget.ingredient_images,
        category: widget.category,
        calories: widget.calories,
        additions: widget.additions,
        nutritionalValue: widget.nutritionalValue);
    price = prod.price;
    _count = 1;
    for (dynamic i in prod.additions) {
      var newaddition = DropdownMenuItem(
        child: Text("$i"),
        value: i,
      );
      additions.add(newaddition);
    }
    _selectedAddition = additions[0].value;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var init_price = widget.price;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: Bottombar(),
        body: Container(
          decoration: BoxDecoration(
              color: bGcolor,
              image: DecorationImage(
                  image: NetworkImage(widget.image), fit: BoxFit.cover)),
          child: Stack(children: [
            SafeArea(
              top: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(height: size.height * 0.2),
                  Container(
                    width: size.width,
                    height: size.height * 0.6,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40))),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 30, left: 30),
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.arrow_back_ios),
                                onPressed: () {
                                  Navigator.pushNamed(context, Routes.scan);
                                },
                              ),
                              SizedBox(
                                width: size.width * 0.5,
                              ),
                              Text(
                                'K ${widget.price}',
                                style: TextStyle(
                                    fontSize: 45, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          child: Row(children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 50),
                                      child: Text(
                                        "Description",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25),
                                      ),
                                    ),
                                    SizedBox(
                                      height: size.height * 0.01,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 25, bottom: 20),
                                      child: Text(
                                        "${prod.description}",
                                        textWidthBasis: TextWidthBasis.parent,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.04,
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  Text(
                                    "Nutritional Value",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  Divider(
                                    indent: 1,
                                    endIndent: 35,
                                    thickness: 1,
                                    color: Colors.black,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 20),
                                    height: size.height * 0.076,
                                    child: ListView.builder(
                                        padding: EdgeInsets.zero,
                                        itemCount: prod.nutritionalValue.length,
                                        itemBuilder: (context, index) {
                                          return Row(
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                    '${prod.nutritionalValue.keys.toList().elementAt(index).toString()}'),
                                              ),
                                              SizedBox(
                                                width: size.width * 0.035,
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  '${prod.nutritionalValue.values.toList().elementAt(index).toString()}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                          );
                                        }),
                                  ),
                                  Divider(
                                    indent: 1,
                                    endIndent: 35,
                                    thickness: 1,
                                    color: Colors.black,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          "assets/icons/fireemo.jpg",
                                          height: 20,
                                        ),
                                        Text('${prod.calories} cals'),
                                        SizedBox(
                                          width: size.width * 0.14,
                                        ),
                                        Text('*daily value')
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ]),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 200),
                          child: Text(
                            'Ingredients',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Flex(
                          direction: Axis.horizontal,
                          mainAxisAlignment: MainAxisAlignment.center,
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
                              child: ingredients(
                                images: prod.ingredient_images,
                              ),
                            ),
                          ],
                        ),
                        // Multipleselect(),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(right: size.width * 0.5),
                              child: Text(
                                'Additions',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 25),
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.05,
                              width: size.width * 0.7,
                              child: DropdownButton<dynamic>(
                                  underline: Container(
                                    height: 1,
                                    color: Colors.deepPurple,
                                  ),
                                  elevation: 9,
                                  value: _selectedAddition,
                                  isExpanded: true,
                                  hint: Text(
                                    'pick an addition',
                                  ),
                                  icon: Icon(Icons.keyboard_arrow_down_sharp),
                                  items: additions,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedAddition = value;
                                    });
                                  }),
                            )
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 50),
                          child: Row(
                            children: [
                              Flex(
                                direction: Axis.horizontal,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: size.width * 0.09),
                                    child: Text(
                                      'K ${price}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: size.width * 0.12,
                              ),
                              Container(
                                padding: EdgeInsets.only(right: 30),
                                child: Flex(
                                  direction: Axis.horizontal,
                                  children: [
                                    Row(
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              setState(() {
                                                _count--;
                                                prod.quantity = _count;
                                                price -= init_price;
                                                prod.price = price;
                                              });
                                            },
                                            icon: Icon(
                                              Icons.remove,
                                              size: 15,
                                              color: Colors.black,
                                            )),
                                        Text(_count.toString()),
                                        IconButton(
                                            onPressed: () {
                                              setState(() {
                                                _count++;
                                                prod.quantity = _count;
                                                price += init_price;
                                                prod.price = price;
                                              });
                                            },
                                            icon: Icon(
                                              Icons.add,
                                              size: 15,
                                              color: Colors.black,
                                            )),
                                      ],
                                    ),
                                    SizedBox(
                                      width: size.width * 0.1,
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                blurRadius: 10,
                                                spreadRadius: -5,
                                                offset: Offset(0.84, 5)),
                                          ],
                                          color: Colors.white,
                                          shape: BoxShape.circle),
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
                                              '${context.watch<Cart>().count}')),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        AppButton(
                            text: 'Add to Basket',
                            fontSize: 20,
                            textColor: Colors.white,
                            bgColor: Colors.black,
                            onTap: () {
                              context.read<Cart>().addtoCart(prod);
                              print(prod.price);
                              Navigator.pushNamed(context, Routes.cart);
                            },
                            fontWeight: FontWeight.normal,
                            borderRadius: 40,
                            height: size.height * 0.01)
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: const Alignment(-0.5, -0.35),
              child: Container(
                  decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 8,
                            spreadRadius: -7,
                            offset: Offset(0.8, 5))
                      ],
                      color: Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  width: size.width * 0.5,
                  height: size.height * 0.07,
                  child: Center(
                    child: Text(
                      widget.name,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  )),
            ),
          ]),
        ));
  }
}

class ingredients extends StatelessWidget {
  final List<dynamic> images;
  const ingredients({
    Key? key,
    required this.images,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: images.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: size.height * 0.4,
          alignment: Alignment.center,
          width: size.width * 0.2,
          padding: EdgeInsets.all(4),
          child: ListTile(
            style: ListTileStyle.list,
            title: Image.network(
              images[0],
              fit: BoxFit.cover,
              height: size.height * 0.4,
            ),
          ),
        );
      },
    );
  }
}

// ignore: camel_case_types
