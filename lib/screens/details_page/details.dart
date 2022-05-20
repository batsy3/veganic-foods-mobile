import 'package:flutter/material.dart';
import 'package:flutter_number_picker/flutter_number_picker.dart';
import 'package:veganic_foods_app/constants.dart';
import 'package:veganic_foods_app/utils/routes.dart';
import 'package:veganic_foods_app/widgets/custom_button.dart';


class Details extends StatefulWidget {
  // final Future<Product>? item;
  // late Future<Product>? item = [] as Future<Product>?;
  final String name;
  final String description;
  final String price;
  final int quantity;
  final String image;
  final int category;
  const Details({
    Key? key,
    required this.name,
      required this.description,
      required this.price,
      required this.quantity,
      required this.image,
      required this.category,
    // required this.item,
  }) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
  String price = widget.price;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: bGcolor,
        //get background image from api object ima
        body: Container(
          decoration: const BoxDecoration(),
          child: Stack(children: [
            Column(
              children: [
                const SizedBox(
                  height: 180,
                ),
                Container(
                  width: size.width,
                  height: size.height * 0.7,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40))),
                  child: Column(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 30, left: 20),
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_back_ios),
                              onPressed: () {
                                Navigator.pushNamed(context, Routes.scan);
                              },
                            ),
                            const SizedBox(
                              width: 200,
                            ),
                            //price
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
                                const Text(
                                  'Description',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ],
                            ),
                          )),
                        const  VerticalDivider(
                            width: 1,
                          ),
                          // ignore: prefer_const_constructors
                          Expanded(
                              child: const Center(
                            child:  Text(
                              ' Nutritional value',
                              style:  TextStyle(
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
                             child: Center(
                               child: Expanded(
                                 child: Text(
                                   widget.description,
                                 ),
                               ),
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
                                 'omg cheese cheese cheese why cheese ahhhhhhhhh cheeseeee echeeeeeeeessseeeeee ',
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
                                style:  TextStyle(fontSize: 10),
                              )
                            ],
                          )),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: size.width * 0.85,
                        height: size.height * 0.13,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                            color: const Color.fromARGB(255, 249, 253, 255),
                            boxShadow: [
                              const BoxShadow(
                                  blurRadius: 3,
                                  spreadRadius: -3,
                                  offset: Offset(0.84, 5))
                            ],
                            borderRadius:
                                const BorderRadius.all(const Radius.circular(40))),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(right: 180),
                              child: const Text(
                                'Ingredients',
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Expanded(
                              child: const ingredient_images(),
                            )
                          ],
                        ),
                      ),
                      // Multipleselect(),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Container(
                              padding: const EdgeInsets.only(left: 30),
                              child: Text(
                                'K' ' ' + price,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 25),
                              )),
                          const SizedBox(
                            width: 95,
                          ),
                          CustomNumberPicker(
                              onValue: (dynamic newvalue) => {
                                    setState(() {
                                      price = newvalue;
                                    })
                                  },
                              initialValue: 1,
                              maxValue: 20,
                              minValue: 1,
                              step: 1),
                          const SizedBox(
                            width: 70,
                          ),
                          FloatingActionButton(
                            backgroundColor: bGcolor,
                            onPressed: () {},
                            child: const Icon(Icons.shopping_basket_outlined),
                          )
                        ],
                      ),
                      AppButton(
                          text: 'Add to Basket',
                          fontSize: 20,
                          textColor: Colors.white,
                          bgColor: Colors.black,
                          onTap: () {
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
                            blurRadius: 8,
                            spreadRadius: -7,
                            offset: Offset(0.8, 5))
                      ],
                      color: Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  width: size.width * 0.5,
                  height: size.height * 0.07,
                  child: Center(
                    child: Text(widget.name),
                  )),
            ),
          ]),
        ));
  }
  // Multipleselect() {}
}

List images = [];
List<String> additions = ['tomato', 'cheese', 'toppings', 'milk'];

class Singlenotifier extends ChangeNotifier {
  String _currentItem = additions[0];
  Singlenotifier();

  String get item => _currentItem;
  updateItem(String value) {
    if (value != _currentItem) {
      _currentItem = value;
      notifyListeners();
    }
  }
}

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
