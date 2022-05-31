import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:veganic_foods_app/constants.dart';
import 'package:veganic_foods_app/providers/cart_provider.dart';
import 'package:veganic_foods_app/screens/details_page/components/product_class.dart';
import 'package:veganic_foods_app/widgets/custom_button.dart';
import '../../utils/routes.dart';
import '../../widgets/default_back_button.dart';
import '../payment_page/components/background_eclipses.dart';
import 'components/list_widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// ignore: must_be_immutable
class Basketpage extends StatefulWidget {
  Basketpage({Key? key}) : super(key: key);

  @override
  State<Basketpage> createState() => _BasketpageState();
}

class _BasketpageState extends State<Basketpage> {

  final listKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: bGcolor,
      body: Column(
        children: [
          SizedBox(
            height: 160,
            child: backgroundbubbles(
              name: 'Basket',
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            height: size.height * 0.72,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
                color: Colors.white),
            child: Column(
              children: [
                Container(
                    margin: EdgeInsets.only(top: 5, right: 290),
                    child: DefaultBackButton()),
                Expanded(
                  child: AnimatedList(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    key: listKey,
                    initialItemCount: context.read<Cart>().cart.length,
                    itemBuilder: (BuildContext context, int index,
                            Animation<double> animation) =>
                        Slidable(
                      endActionPane: ActionPane(
                          key: ValueKey(context.read<Cart>().cart[index]),
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              key: ValueKey(
                                  context.read<Cart>().cart[index].product_id),
                              autoClose: true,
                              flex: 2,
                              onPressed: (context) => {
                                removeitem(index),
                                context.read<Cart>().deletefromcart(index),
                              },
                              backgroundColor: Color(0xFFEF5350),
                              icon: Icons.delete,
                              label: 'delete',
                            ),
                          ]),
                      child: ListWidget(
                        animation: animation,
                        product: context.read<Cart>().cart[index],
                      ),
                    ),
                  ),
                ),
                AppButton(
                    text: 'Proceed',
                    fontSize: 20,
                    textColor: Colors.white,
                    bgColor: Colors.black,
                    onTap: () {
                      Navigator.pushNamed(context, Routes.payment);
                    },
                    fontWeight: FontWeight.bold,
                    borderRadius: 30,
                    height: 10)
              ],
            ),
          ),
        ],
      ),
    );
  }

  removeitem(int index) {
    final removeItem = context.read<Cart>().cart[index];
    listKey.currentState!.removeItem(
        index,
        (context, animation) => ListWidget(
              animation: animation,
              product: removeItem,
            ));
  }
}
