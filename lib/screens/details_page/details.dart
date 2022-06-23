// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:veganic_foods_app/constants.dart';
import 'package:veganic_foods_app/providers/cart_provider.dart';
import 'package:veganic_foods_app/screens/details_page/components/product_class.dart';
import 'package:veganic_foods_app/screens/payment_page/components/background_eclipses.dart';
import 'package:veganic_foods_app/utils/routes.dart';
import 'package:veganic_foods_app/widgets/bottom_nav_bar.dart';
import 'package:veganic_foods_app/widgets/custom_button.dart';
// ignore: must_be_immutable
class Details extends StatefulWidget {
  final int product_id;
  final String name;
  final String description;
  double price;
  int quantity;
  final String image;
  final int category;
  Details({
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
  late Product prod;
  late double price;
  late int _count;
  late List<DropdownMenuItem<dynamic>> additions;
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
        category: widget.category);
    price = prod.price;
    _count = 1;
    additions = [
      DropdownMenuItem(
        child: Text('select'),
        value: 'Select',
      ),
      DropdownMenuItem(
        child: Text('Add 1'),
        value: 'Add 1',
      ),
      DropdownMenuItem(
        child: Text('Add 2'),
        value: 'Add 2',
      ),
      DropdownMenuItem(
        child: Text('Add 3'),
        value: 'Add 3',
      ),
      DropdownMenuItem(
        child: Text('Add 4'),
        value: 'Add 4',
      ),
      DropdownMenuItem(
        child: Text('Add 5'),
        value: 'Add 5',
      ),
    ];
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
              image: NetworkImage(widget.image), fit: BoxFit.fill)),
            child: Stack(children: [
        SafeArea(
          top: false,
          child: Column(
            children: [
              backgroundbubbles(name: '',
              height: size.height*0.24,
              ),
              
          
              // SizedBox(height: size.height * 0.005),
              Container(
                width: size.width,
                height: size.height * 0.67,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
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
                           SizedBox(
                            width: size.width * 0.46,
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
                          children:  [
                            Icon(Icons.check),
                            SizedBox(
                              width: size.width * 0.02,
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
                     SizedBox(
                      height: size.height * 0.01,
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
                          child: ingredient_images(),
                        ),
                      ],
                    ),
                    // Multipleselect(),
                     SizedBox(
                      height: size.height*0.02,
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
                              underline:  Container(
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
          
                    Row(
                      children: [
                        Flex(
                          direction: Axis.horizontal,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: size.width * 0.1),
                              child: Text(
                                'K ${price}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 25),
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
                                    badgeContent:
                                        Text('${context.watch<Cart>().count}')),
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
                          context.read<Cart>().addtoCart(prod);
                          print(prod.price);
                          Navigator.pushNamed(context,
                             Routes.cart
                            );
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
          alignment: const Alignment(-0.6, -0.5),
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
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
