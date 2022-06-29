import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:veganic_foods_app/constants.dart';
import 'package:veganic_foods_app/widgets/custom_button.dart';
import '../../providers/cart_provider.dart';
import '../../utils/routes.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../../widgets/divider.dart';
import '../../widgets/radiotile_css.dart';
import '../../widgets/transaction_alert_dialog.dart';
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



