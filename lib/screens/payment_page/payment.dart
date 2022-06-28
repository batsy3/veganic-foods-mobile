import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:veganic_foods_app/constants.dart';
import 'package:veganic_foods_app/screens/payment_page/components/transaction_function.dart';
import 'package:veganic_foods_app/utils/globals.dart';
import 'package:veganic_foods_app/widgets/custom_button.dart';
import '../../providers/cart_provider.dart';
import '../../utils/routes.dart';
import '../../widgets/bottom_nav_bar.dart';
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

enum Paymentmethod { mobile_money, visa, bank_transfer, master_card }

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
    return LayoutBuilder(builder: ((context, constraints) {
      final width = constraints.maxWidth;
      final height = constraints.maxHeight;
      return SafeArea(
        top: false,
        child: Scaffold(
            extendBody: true,
            resizeToAvoidBottomInset: false,
            backgroundColor: bGcolor,
            bottomNavigationBar: Bottombar(),
            body: SafeArea(
              top: false,
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                // ignore: prefer_const_constructors
                backgroundbubbles(
                  // height: size.height*0.1719.h,
                  height: height * 0.1,
                  name: '',
                ),

                Column(children: [
                  Container(
                    padding: EdgeInsets.only(left: 40),
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Payment',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Container(
                      width: width.w,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                            // bottomLeft: Radius.elliptical(200,50 ),
                          )),
                      child: Column(children: [
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Container(
                          padding:
                              EdgeInsets.only(left: 30, top: height * 0.01),
                          child: Row(
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(context, Routes.cart);
                                },
                              ),
                              SizedBox(
                                width: width * 0.08,
                              ),
                              Text(
                                'Payment methods',
                                style: TextStyle(
                                    fontSize: 23, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        RadioListTile<Paymentmethod>(
                          contentPadding: EdgeInsets.only(left: 40),
                          value: Paymentmethod.mobile_money,
                          groupValue: _init,
                          onChanged: (Paymentmethod? value) =>
                              setState(() => {_init = value}),
                          activeColor: Colors.deepPurple[500],
                          title: RadiotileCSS(
                            imagestring: 'assets/icons/mbilemoney.png',
                            text: 'Mobile Money',
                          ),
                          selected: false,
                        ),
                        divider(),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        RadioListTile<Paymentmethod>(
                          contentPadding: EdgeInsets.only(left: 40),
                          value: Paymentmethod.master_card,
                          groupValue: _init,
                          onChanged: (Paymentmethod? value) =>
                              setState(() => {_init = value}),
                          activeColor: Colors.deepPurple[500],
                          title: RadiotileCSS(
                            imagestring: 'assets/icons/master-card-icon-4.png',
                            text: 'Master Card',
                          ),
                          selected: false,
                        ),
                        divider(),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        RadioListTile<Paymentmethod>(
                          contentPadding: EdgeInsets.only(left: 40),
                          value: Paymentmethod.visa,
                          groupValue: _init,
                          onChanged: (Paymentmethod? value) =>
                              setState(() => {_init = value}),
                          activeColor: Colors.deepPurple[500],
                          title: RadiotileCSS(
                            imagestring:
                                'assets/icons/3069706_circle_payment_round icon_visa_icon.png',
                            text: 'Visa',
                          ),
                          selected: false,
                        ),
                        divider(),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        RadioListTile<Paymentmethod>(
                          contentPadding: EdgeInsets.only(left: 40),
                          value: Paymentmethod.bank_transfer,
                          groupValue: _init,
                          onChanged: (Paymentmethod? value) =>
                              setState(() => {_init = value}),
                          activeColor: Colors.deepPurple[500],
                          title: RadiotileCSS(
                            imagestring:
                                'assets/icons/213750_bank_card_checkout_online shopping_payment method_icon.png',
                            text: 'Bank Transfer',
                          ),
                          selected: false,
                        ),
                        divider(),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        SizedBox(
                          height: height * 0.06,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'Total',
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                              if (context.read<Cart>().cart.isNotEmpty)
                                Text(
                                  // '${context.watch<Cart>().total}',
                                  '${Provider.of<Cart>(context, listen: false).total.toStringAsFixed(2)}',
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                )
                              else
                                Text(
                                  'k 0.0',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30),
                                )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.003,
                        ),
                        AppButton(
                          text: 'Proceed',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          borderRadius: 40,
                          height: height * 0.01,
                          textColor: Colors.white,
                          bgColor: Colors.black,
                          onTap: () {
                            if (context.read<Cart>().carttotal() == 0.0) {
                              Get.snackbar(
                                'opps',
                                'please add items to cart',
                                backgroundColor: Colors.red.shade300,
                                colorText: Colors.black,
                                snackPosition: SnackPosition.TOP,
                                duration: Duration(seconds: 5),
                                icon: Icon(Icons.alarm),
                                snackStyle: SnackStyle.FLOATING,
                              );
                            } else {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  if (_init == Paymentmethod.mobile_money)
                                    return TransactionAlertDalog(
                                      text: 'Mobile Money',
                                      hint: 'phone number',
                                      formkey: _formkey,
                                      textcontroller: textcontroller,
                                      validator: 'enter valid phone number',
                                    );
                                  else if (_init == Paymentmethod.visa)
                                    return TransactionAlertDalog(
                                      text: 'Visa',
                                      hint: 'card number',
                                      formkey: _formkey,
                                      textcontroller: textcontroller,
                                      validator: 'enter valid card number',
                                    );
                                  else if (_init == Paymentmethod.master_card)
                                    return TransactionAlertDalog(
                                      text: 'Visa',
                                      hint: 'card number',
                                      formkey: _formkey,
                                      textcontroller: textcontroller,
                                      validator: 'enter valid card number',
                                    );
                                  else
                                    return TransactionAlertDalog(
                                      text: 'Bank Transfer',
                                      hint: 'bank account number',
                                      formkey: _formkey,
                                      textcontroller: textcontroller,
                                      validator:
                                          'enter valid bank account number',
                                    );
                                },
                              );
                            }
                          },
                        ),
                      ]))
                ]),
                // ignore: prefer_const_constructors
              ]),
            )),
      );
    }));
  }
}

class TransactionAlertDalog extends StatelessWidget {
  final String text;
  final String validator;
  final String hint;
  const TransactionAlertDalog({
    Key? key,
    required GlobalKey<FormState> formkey,
    required this.textcontroller,
    required this.text,
    required this.validator,
    required this.hint,
  })  : _formkey = formkey,
        super(key: key);

  final GlobalKey<FormState> _formkey;
  final TextEditingController textcontroller;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //total height and width of screen

    return AlertDialog(
        shape: ShapeBorder.lerp(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          0.5,
        ),
        backgroundColor: Colors.white,
        title: Container(
          alignment: Alignment.centerRight,
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.close,
                size: 30,
                color: Colors.black,
              )),
        ),
        content: Container(
          height: size.height * 0.4,
          padding: EdgeInsets.all(20),
          alignment: Alignment.center,
          child: Form(
            key: _formkey,
            child: Column(children: [
              Text(text,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(
                height: size.height * 0.02,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty || value.characters.length < 10) {
                    return '$validator';
                  } else {
                    return null;
                  }
                },
                style: TextStyle(color: Colors.black),
                controller: textcontroller,
                decoration: InputDecoration(
                  hintText: '260 ',
                  hintStyle: TextStyle(color: Colors.grey.shade700),
                  labelText: hint,
                  labelStyle: TextStyle(color: Colors.grey.shade700),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: bGcolor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: bGcolor)),
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Text(
                'your cart total is ${context.read<Cart>().total}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              AppButton(
                text: 'pay',
                fontSize: 25,
                textColor: Colors.white,
                bgColor: Colors.black,
                fontWeight: FontWeight.bold,
                borderRadius: 30,
                height: size.height * 0.02,
                onTap: () {
                  if (_formkey.currentState!.validate()) {
                    gateway(
                        textcontroller.text, context.read<Cart>().carttotal());
                    Navigator.of(context).pop();
                    final SnackBar snackBar = SnackBar(
                        duration: Duration(seconds: 3),
                        padding: EdgeInsets.only(top: 250, bottom: 300),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        backgroundColor: Colors.transparent,
                        content: AlertDialog(
                          title: Text(''),
                          content: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(70),
                            ),
                            alignment: Alignment.center,
                            child: Column(
            
                              children: [
                                if (context.read<Cart>().carttotal() != 0.0)
                                  Icon(
                                    Icons.check,
                                    color: Colors.green,
                                    size: 50,
                                  ),
                                Text(
                                  'Transaction in progress',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ));
                    snackbarKey.currentState?.showSnackBar(snackBar);
                  }
                },
              )
            ]),
          ),
        ));
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
    Size size = MediaQuery.of(context).size;
    return Row(children: <Widget>[
      InkWell(
        child: Row(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Image.asset(
              imagestring,
              height: 25.h,
            ),
            SizedBox(
              width: size.height * 0.02,
            ),
            Text(
              text,
              // ignore: prefer_const_constructors
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    ]);
  }
}
