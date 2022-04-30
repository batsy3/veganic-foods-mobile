import 'package:flutter/material.dart';
import 'package:veganic_foods_app/constants.dart';

class BackGround extends StatefulWidget {
  const BackGround({Key? key}) : super(key: key);

  @override
  State<BackGround> createState() => _BackGroundState();
}

class _BackGroundState extends State<BackGround> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: bGcolor,
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            height: size.height,
            width: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Positioned(top: 45, left: 145, child: Paymenttext()),
                Positioned(
                    top: 20,
                    left: -5,
                    child: CustomAppBar(Icons.arrow_back_ios_new_outlined)),
                Positioned(
                    top: -20,
                    left: -30,
                    child: Image.asset(
                      "assets/images/Ellipse_3.png",
                      width: size.width * 0.3,
                    )),
                Positioned(
                    top: 26,
                    left: 150,
                    child: Image.asset(
                      "assets/images/Ellipse_2.png",
                      width: size.width * 0.3,
                    )),
                Positioned(
                    top: 60,
                    left: 319,
                    child: Image.asset(
                      "assets/images/Ellipse_8.png",
                      width: size.width * 0.3,
                    )),
              ],
            ),
          ),
        ]),

        );
  }
}

class CustomAppBar extends StatelessWidget {
  final IconData leftIcon;
  final Function? leftcallback;
  const CustomAppBar(this.leftIcon, {this.leftcallback()?});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        left: 25,
        right: 25,
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        GestureDetector(
            onTap: leftcallback != null ? () => leftcallback!() : null,
            child: _buildIcon(Icons.arrow_back_ios_outlined)),
      ]),
    );
  }

  Container _buildIcon(IconData icon) => Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: bGcolor,
        ),
        child: Icon(icon),
      );
}

class Paymenttext extends StatelessWidget {
  const Paymenttext({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        'payment',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
      ),
    );
  }
}

