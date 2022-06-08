// ignore: file_names
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:veganic_foods_app/constants.dart';
import 'package:veganic_foods_app/screens/payment_page/components/transaction_function.dart';
import 'package:veganic_foods_app/utils/globals.dart';
import 'package:veganic_foods_app/utils/routes.dart';
import 'package:veganic_foods_app/widgets/custom_button.dart';
import '../../providers/cart_provider.dart';
import '../../widgets/default_back_button.dart';
import 'components/background_eclipses.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return const PaymentList();
  }
}

class PaymentList extends StatefulWidget {
  const PaymentList({Key? key}) : super(key: key);

  @override
  State<PaymentList> createState() => _PaymentListState();
}

enum Paymentmethod { mobile_money, visa, bank_transfer }

class _PaymentListState extends State<PaymentList> {
  final textcontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  @override
  void dispose() {
    textcontroller.dispose();
    super.dispose();
  }

  Paymentmethod? _init = Paymentmethod.mobile_money;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; //total height and width of screen

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: bGcolor,
        body: Column(children: [
          // ignore: prefer_const_constructors
          backgroundbubbles(
            name: 'Payment',
          ),
          Column(children: [
            SizedBox(
              height: 60,
            ),
            Container(
                width: size.width,
                padding: const EdgeInsets.all(0),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: Column(children: [
                  const SizedBox(
                    height: 40,
                  ),

                  Container(
                    padding: const EdgeInsets.only(left: 30, top: 5),
                    child: Row(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const DefaultBackButton(),
                        const SizedBox(
                          width: 50,
                        ),
                        const Text(
                          'Payment methods',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RadioListTile<Paymentmethod>(
                    contentPadding: const EdgeInsets.only(left: 40),
                    value: Paymentmethod.mobile_money,
                    groupValue: _init,
                    onChanged: (Paymentmethod? value) =>
                        setState(() => {_init = value}),
                    activeColor: Colors.deepPurple[500],
                    title: const RadiotileCSS(
                      imagestring: 'assets/icons/mbilemoney.png',
                      text: 'Mobile Money',
                    ),
                    selected: false,
                  ),
                  const divider(),
                  RadioListTile<Paymentmethod>(
                    contentPadding: const EdgeInsets.only(left: 40),
                    value: Paymentmethod.visa,
                    groupValue: _init,
                    onChanged: (Paymentmethod? value) =>
                        setState(() => {_init = value}),
                    activeColor: Colors.deepPurple[500],
                    title: const RadiotileCSS(
                      imagestring:
                          'assets/icons/3069706_circle_payment_round icon_visa_icon.png',
                      text: 'Visa',
                    ),
                    selected: false,
                  ),
                  const divider(),
                  RadioListTile<Paymentmethod>(
                    contentPadding: const EdgeInsets.only(left: 40),
                    value: Paymentmethod.bank_transfer,
                    groupValue: _init,
                    onChanged: (Paymentmethod? value) =>
                        setState(() => {_init = value}),
                    activeColor: Colors.deepPurple[500],
                    title: const RadiotileCSS(
                      imagestring:
                          'assets/icons/213750_bank_card_checkout_online shopping_payment method_icon.png',
                      text: 'Bank Transfer',
                    ),
                    selected: false,
                  ),
                  const divider(),
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Total',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        Column(
                          children: [
                            if (context.read<Cart>().cart.isNotEmpty)
                              Text(
                                // '${context.watch<Cart>().total}',
                                '${Provider.of<Cart>(context, listen: false).total.toStringAsFixed(2)}',
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              )
                            else
                              Text(
                                'k 0.0',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 25),
                              ),
                          ],
                        )
                      ],
                    ),
                    height: 30,
                  ),

                  AppButton(
                    text: 'Proceed',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    borderRadius: 40,
                    height: 20,
                    textColor: Colors.white,
                    bgColor: Colors.black,
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                                backgroundColor: Colors.white,
                                title: Container(
                                  alignment: Alignment.centerRight,
                                  child: IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: Icon(
                                        Icons.close,
                                        color: Colors.black,
                                      )),
                                ),
                                content: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.4,
                                  padding: EdgeInsets.all(20),
                                  alignment: Alignment.center,
                                  child: Form(
                                    key: _formkey,
                                    child: Column(children: [
                                      Text('Mobile Money',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      TextFormField(
                                        validator: (value) {
                                          if (value!.isEmpty ||
                                              value.characters.length < 10) {
                                            return 'Please enter valid phone number';
                                          } else {
                                            return null;
                                          }
                                        },
                                        style: TextStyle(color: Colors.black),
                                        controller: textcontroller,
                                        decoration: InputDecoration(
                                          hintText: 'enter phone number',
                                          hintStyle: TextStyle(
                                              color: Colors.grey.shade700),
                                          labelText: 'phone number',
                                          labelStyle: TextStyle(
                                              color: Colors.grey.shade700),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: bGcolor),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide:
                                                  BorderSide(color: bGcolor)),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        'your cart total is ${context.read<Cart>().total}',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      AppButton(
                                        text: 'pay',
                                        fontSize: 25,
                                        textColor: Colors.white,
                                        bgColor: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        borderRadius: 30,
                                        height: 10,
                                        onTap: () {
                                          context.read<Cart>().clearall();
                                          if (_formkey.currentState!
                                              .validate()) {
                                            gateway(
                                                textcontroller.text,
                                                context
                                                    .read<Cart>()
                                                    .carttotal());
                                            Navigator.of(context).pop();
                                            final SnackBar snackBar = SnackBar(
                                                content: Text(
                                                    'payment in progress'));
                                            snackbarKey.currentState
                                                ?.showSnackBar(snackBar);
                                          }
                                        },
                                      )
                                    ]),
                                  ),
                                ));
                          });
                    },
                  ),
                  // ignore: prefer_const_constructors
                  SizedBox(
                    height: 20,
                  ),
                ]))
          ])
        ]));
  }
}

class divider extends StatelessWidget {
  const divider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      thickness: 1,
      indent: 50,
      endIndent: 50,
    );
  }
}

class RadiotileCSS extends StatelessWidget {
  final String text;
  final String imagestring;
  const RadiotileCSS({
    Key? key,
    required this.text,
    required this.imagestring,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Expanded(
          flex: 1,
          child: InkWell(
            child: Row(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Image.asset(
                  imagestring,
                  height: 25,
                ),
                const SizedBox(
                  width: 33,
                ),
                Text(
                  text,
                  // ignore: prefer_const_constructors
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )
              ],
            ),
          )),
    ]);
  }
}
