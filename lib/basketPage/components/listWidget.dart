import 'package:flutter/material.dart';

import 'Listitem.dart';

class ListWidget extends StatelessWidget {
  final Listitem item;
  final Animation<double> animation;
  final VoidCallback? onClicked;
  const ListWidget(
      {Key? key,
      required this.item,
      required this.animation,
      required this.onClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) =>
      SizeTransition(sizeFactor: animation, child: buildItem());
      
  Widget buildItem() {
    return Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white38,
        ),
        child: ListTile(
          contentPadding: EdgeInsets.all(10),
          leading: CircleAvatar(radius: 32),
          title: Text(
            item.title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            item.price,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
          ),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: onClicked,
          ),
        ));
  }
}
