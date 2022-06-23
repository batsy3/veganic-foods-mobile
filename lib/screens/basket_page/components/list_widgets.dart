import 'package:flutter/material.dart';
import 'package:veganic_foods_app/providers/cart_provider.dart';
import 'package:veganic_foods_app/screens/details_page/components/product_class.dart';

// ignore: must_be_immutable
class ListWidget extends StatefulWidget {
  
  Product product;
  final Animation<double> animation;
  ListWidget({
    Key? key,
    required this.product,
    required this.animation,
  }) : super(key: key);

  @override
  State<ListWidget> createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  late Product prod;
  late double price;
  late double initialPrice;
  late int quantity;
  @override
  void initState() {
    super.initState();
    prod = this.widget.product;
    quantity = this.widget.product.quantity;
    initialPrice = this.widget.product.price / quantity;
    this.widget.product.price = prod.price;
    Cart().carttotal();
  }

  @override
  Widget build(BuildContext context) => SizeTransition(
      key: ValueKey(widget.product.product_id),
      sizeFactor: widget.animation,
      child: buildItem());

  Widget buildItem() {
    return Column(
      children: [
        Container(
            margin: EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            child: ListTile(
                contentPadding: EdgeInsets.all(10),
                leading: CircleAvatar(
                  radius: 32,
                  backgroundImage: NetworkImage(widget.product.image),
                ),
                title: Text(
                  widget.product.name,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'k ${prod.price}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                trailing: Container(
                  width: 120,
                  padding: EdgeInsets.only(right: 0),
                  child: Row(children: [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            if (quantity >= 1) {
                              quantity--;
                              price = initialPrice * quantity;
                              prod.price = price;
                            }
                          });
                        },
                        icon: Icon(
                          Icons.remove,
                          size: 15,
                        )),
                    Text(
                      quantity.toString(),
                      style: TextStyle(fontSize: 20),
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            quantity++;
                            price = initialPrice * quantity;
                            prod.price = price;

                          });
                        },
                        icon: Icon(
                          Icons.add,
                          size: 15,
                        ))
                  ]),
                ))),
        Divider(
          indent: 30,
          endIndent: 30,
          thickness: 2,
        )
      ],
    );
  }
}
