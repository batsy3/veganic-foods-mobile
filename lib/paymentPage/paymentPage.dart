import 'package:flutter/material.dart';
import 'package:veganic_foods_app/constants.dart';
import 'package:veganic_foods_app/landingPage/components/backgroundFunc.dart';
import 'package:veganic_foods_app/paymentPage/components/background.dart';

import 'components/CardPage.dart';
import 'components/defaultAppBar.dart';
import 'components/defaultBackButton.dart';

enum Payment_methods { card, mtn, airtel, zanaco, fnb }

class PaymentPage extends StatelessWidget {
  const PaymentPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(child: const BackGround()),
        Container(
          child: PaymentList(),
        )
      ],
    );
  }
}

class PaymentList extends StatefulWidget {
  @override
  State<PaymentList> createState() => _PaymentListState();
}

class _PaymentListState extends State<PaymentList> {
  Payment_methods? _character = Payment_methods.card;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; //total height and width of screen

    return Scaffold(
        backgroundColor: bGcolor,
        appBar: AppBar(
          title: SafeArea(
            child: Container(
              child:
                Text(
                  'Checkout',
                  style: TextStyle(color: Colors.black),
                ),
                Positioned(
                    top: -11,
                    left: 0,
                    child: Image.asset(
                      'assets/images/Ellipse_3.png',
                      fit: BoxFit.cover,
                    )),
            ),
          ),
          centerTitle: true,
          backgroundColor: bGcolor,
          elevation: 0,
        ),
        body: Column(
          children: [
            SizedBox(
              height: 70,
            ),
            SafeArea(
              // minimum: EdgeInsets.all(15),
              child: Column(children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: size.width,
                  padding: EdgeInsets.all(0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40))),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 30, top: 5),
                        child: Row(
                          children: [
                            DefaultBackButton(),
                            SizedBox(
                              width: 50,
                            ),
                            Text(
                              'Payment methods',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      RadioListTile<Payment_methods>(
                        contentPadding: EdgeInsets.only(left: 40, top: 10),
                        value: Payment_methods.card,
                        groupValue: _character,
                        onChanged: (Payment_methods? value) {
                          setState(() {
                            _character = value;
                          });
                        },
                        activeColor: Colors.deepPurple[500],
                        title: Row(children: <Widget>[
                          Expanded(
                              flex: 0,
                              child: InkWell(
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.credit_card,
                                      color: Colors.deepPurple[500],
                                      size: 31.0,
                                    ),
                                    SizedBox(
                                      width: 49,
                                    ),
                                    Text(
                                      'Card',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              )),
                        ]),
                        selected: false,
                      ),
                      Divider(
                        thickness: 0,
                        endIndent: 20,
                        indent: 20,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                      RadioListTile<Payment_methods>(
                        contentPadding: EdgeInsets.only(left: 40),
                        value: Payment_methods.airtel,
                        groupValue: _character,
                        onChanged: (Payment_methods? value) {
                          setState(() {
                            _character = value;
                          });
                        },
                        activeColor: Colors.deepPurple[500],
                        title: Row(children: <Widget>[
                          Expanded(
                              flex: 0,
                              child: InkWell(
                                child: Row(
                                  children: [
                                    ImageIcon(
                                      AssetImage('assets/icons/airtel.png'),
                                      color: Color.fromARGB(255, 238, 20, 20),
                                      size: 31.0,
                                    ),
                                    SizedBox(
                                      width: 50,
                                    ),
                                    Text(
                                      'Airtel ',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              )),
                        ]),
                        selected: false,
                      ),
                      Divider(
                        thickness: 0,
                        endIndent: 20,
                        indent: 20,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                      RadioListTile<Payment_methods>(
                        contentPadding: EdgeInsets.only(left: 40),
                        value: Payment_methods.mtn,
                        groupValue: _character,
                        onChanged: (Payment_methods? value) {
                          setState(() {
                            _character = value;
                          });
                        },
                        activeColor: Colors.deepPurple[500],
                        title: Row(children: <Widget>[
                          Expanded(
                              flex: 0,
                              child: InkWell(
                                child: Row(
                                  children: [
                                    Image(
                                      image: AssetImage(
                                          'assets/icons/PikPng 1.png'),
                                      width: 50,
                                    ),
                                    SizedBox(
                                      width: 33,
                                    ),
                                    Text(
                                      'Mtn',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              )),
                        ]),
                        selected: false,
                      ),
                      Divider(
                        thickness: 0,
                        endIndent: 20,
                        indent: 20,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                      RadioListTile<Payment_methods>(
                        contentPadding: EdgeInsets.only(left: 40),
                        value: Payment_methods.zanaco,
                        groupValue: _character,
                        onChanged: (Payment_methods? value) {
                          setState(() {
                            _character = value;
                          });
                        },
                        activeColor: Colors.deepPurple[500],
                        title: Row(children: <Widget>[
                          Expanded(
                              flex: 0,
                              child: InkWell(
                                child: Row(
                                  children: [
                                    Image(
                                      image: AssetImage(
                                          'assets/icons/zm-zanaco-logo-400x400 1.png'),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      'Zanaco',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              )),
                        ]),
                        selected: false,
                      ),
                      Divider(
                        thickness: 0,
                        endIndent: 20,
                        indent: 20,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                      RadioListTile<Payment_methods>(
                        contentPadding: EdgeInsets.only(left: 40),
                        value: Payment_methods.fnb,
                        groupValue: _character,
                        onChanged: (Payment_methods? value) {
                          setState(() {
                            _character = value;
                          });
                        },
                        activeColor: Colors.deepPurple[500],
                        title: Row(children: <Widget>[
                          Expanded(
                              flex: 0,
                              child: InkWell(
                                child: Row(
                                  children: [
                                    Image(
                                      image: AssetImage('assets/icons/fnb.png'),
                                      height: 40,
                                    ),
                                    SizedBox(
                                      width: 40,
                                    ),
                                    Text(
                                      'FNB E-wallet',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              )),
                        ]),
                        selected: false,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shadowColor: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            primary: Colors.black,
                            onPrimary: Colors.white,
                            textStyle: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                            minimumSize: Size(280, 50)),
                        child: Text('Proceed'),
                        onPressed: () {},
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              ]),
            ),
          ],
        ));
  }
}
