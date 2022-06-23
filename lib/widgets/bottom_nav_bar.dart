import 'package:flutter/material.dart';
import '../utils/routes.dart';

class Bottombar extends StatelessWidget {
  const Bottombar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; //total height and width of screen

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;

        return Container(
          height: height * 0.09,
          padding: EdgeInsets.only(
              bottom: height * 0.01, top: height * 0.01),
          decoration: BoxDecoration(color: Colors.grey.shade100, boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.2), offset: Offset.zero)
          ]),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(width: 20),
            ClipOval(
              child: Material(
                color: Colors.grey.shade100,
                child: IconButton(
                  icon: Icon(
                    Icons.qr_code,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.scan);
                  },
                ),
              ),
            ),
            SizedBox(width: 57),
            ClipOval(
              child: Material(
                color: Colors.grey.shade100,
                child: IconButton(
                  icon: Icon(
                    Icons.shopping_bag,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.cart);
                  },
                ),
              ),
            ),
            SizedBox(
              width: 57,
            ),
            ClipOval(
              child: Material(
                color: Colors.grey.shade100,
                child: IconButton(
                  icon: Icon(
                    Icons.payment,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.payment);
                  },
                ),
              ),
            ),
            SizedBox(width: 30)
          ]),
        );
      },
    );
  }
}
