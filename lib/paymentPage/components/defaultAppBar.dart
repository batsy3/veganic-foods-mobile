import 'package:flutter/material.dart';

import '../../constants.dart';
import 'defaultBackButton.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget child;
  const DefaultAppBar({
    Key? key,
    required this.title,
    required this.child,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(50.0);
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(fontSize: 20, color: Colors.black),
      ),
      centerTitle: true,
      backgroundColor: bGcolor,
      elevation: 0.0,
      automaticallyImplyLeading: false,
      iconTheme: const IconThemeData(color: Colors.black),
      leading: child,
    );
  }
}
