import 'package:flutter/material.dart';
import 'package:veganic_foods_app/constants.dart';

import 'components/Listitem.dart';
import 'components/foodDict.dart';
import 'components/listWidget.dart';

class Basketpage extends StatelessWidget {
  final listKey = GlobalKey<AnimatedListState>();
  final List<Listitem> items = List.from(listitems);
  // const Basketpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bGcolor,
      body: AnimatedList(
        key: listKey,
        initialItemCount: items.length,
        itemBuilder:
            (BuildContext context, int index, Animation<double> animation) =>
                ListWidget(
                    animation: animation,
                    item: items[index],
                    onClicked: () => removeitem(index)),
      ),
    );
  }

  removeitem(int index) {
    final removeItem = items[index];
    items.removeAt(index);
    listKey.currentState!.removeItem(
        index,
        (context, animation) => ListWidget(
            item: removeItem, animation: animation, onClicked: () {}));
  }
}
