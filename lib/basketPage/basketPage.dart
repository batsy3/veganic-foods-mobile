import 'package:flutter/material.dart';
import 'package:veganic_foods_app/constants.dart';
import 'package:veganic_foods_app/paymentPage/components/backgroundBubble.dart';

import 'components/Listitem.dart';
import 'components/foodDict.dart';
import 'components/listWidget.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Basketpage extends StatelessWidget {
  final listKey = GlobalKey<AnimatedListState>();
  final List<Listitem> items = List.from(listitems);
  // const Basketpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: bGcolor,
      body: Column(
        children: [
          SizedBox(
            height: 130,
            child: backgroundbubbles(
              name: 'Basket',
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            height: size.height * 0.68,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40)),
                color: Colors.white),
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: AnimatedList(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    key: listKey,
                    initialItemCount: items.length,
                    itemBuilder: (BuildContext context, int index,
                            Animation<double> animation) =>
                        Slidable(
                      endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          dismissible: DismissiblePane(
                            onDismissed: () => removeitem(index),
                          ),
                          children: [
                            SlidableAction(
                              autoClose: true,
                              flex: 2,
                              onPressed: (context) => removeitem(index),
                              backgroundColor: Color(0xFFEF5350),
                              icon: Icons.delete,
                              label: 'delete',
                            ),
                            SlidableAction(
                                autoClose: true,
                                flex: 2,
                                onPressed: (context) {},
                                backgroundColor: Color(0xFF7E57C2),
                                icon: Icons.add,
                                label: 'Add item'),
                          ]),
                      child: ListWidget(
                        animation: animation,
                        item: items[index],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                shadowColor: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                primary: Colors.white,
                onPrimary: Colors.deepPurple[400],
                textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                minimumSize: Size(300, 50)),
            child: Text('Proceed'),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  removeitem(int index) {
    final removeItem = items[index];
    items.removeAt(index);
    listKey.currentState!.removeItem(
        index,
        (context, animation) =>
            ListWidget(item: removeItem, animation: animation));
  }
}
