import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veganic_foods_app/constants.dart';
import 'package:veganic_foods_app/providers/Api_provider.dart';
import 'package:veganic_foods_app/screens/payment_page/components/stripePayment.dart';
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
  var _isnull;
  @override
  void initState() {
    _isnull = "";
    super.initState();
  }

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
              body: Stack(children: [
                backgroundbubbles(
                  height: height * 0.19,
                  name: 'Payment',
                ),
                Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Container(
                      width: width.w,
                      height: height * 0.8,
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
                          height: height * 0.0003,
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
                            } else if (_init == Paymentmethod.mobile_money) {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return TransactionAlertDalog(
                                      text: 'Mobile Money',
                                      hint: 'phone number',
                                      formkey: _formkey,
                                      textcontroller: textcontroller,
                                      validator: 'enter valid phone number',
                                    );
                                  });
                            } else if (_init == Paymentmethod.master_card) {
                              _read().then((value) {
                                if (value != null) {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AcceptDialog();
                                      });
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => StripePayment(
                                            text: "text",
                                            validator: "validator"),
                                      ));
                                }
                              });
                            }
                          },
                        )
                      ]))
                ])
              ])));
    }));
  }
}

Future<String?> _read() async {
  final pref = await SharedPreferences.getInstance();
  final key = "customer";
  var value = (pref.getString(key)) ?? null;
  print(value);
  return value;
}

class AcceptDialog extends StatefulWidget {
  const AcceptDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<AcceptDialog> createState() => _AcceptDialogState();
}

class _AcceptDialogState extends State<AcceptDialog> {
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  late String _id = "";
  bool _isloading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        height: 30,
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
        height: 140,
        child: Column(
          children: [
            Center(
                child: Text(
              "would you like to use previous billing detaiils ?",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              textAlign: TextAlign.center,
            )),
            SizedBox(
              height: 18,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _isloading
                    ? CircularProgressIndicator(
                        backgroundColor: Colors.white,
                        color: bGcolor,
                      )
                    : Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: bGcolor),
                        child: IconButton(
                          icon: Icon(
                            Icons.check,
                            size: 30,
                            color: Colors.white,
                          ),
                          onPressed: () async {
                            setState(() {
                              _isloading = true;
                            });
                            try {
                              final SharedPreferences pref = await _pref;
                              final String value =
                                  pref.getString("customer").toString();

                              ApiProvider()
                                  .returningCustomer(
                                      context.read<Cart>().carttotal(),
                                      value,
                                      "usd")
                                  .then((value) {
                                Get.snackbar(
                                    "heyy", 'your payment was successfull',
                                    snackPosition: SnackPosition.TOP,
                                    duration: Duration(seconds: 3),
                                    icon: Icon(Icons.handshake),
                                    backgroundColor: Colors.green,
                                    colorText: Colors.white);

                                setState(() {
                                  _isloading = false;
                                });
                                Navigator.pop(context);
                              });
                            } catch (e) {
                              Get.snackbar(
                                  "Sorry", 'your payment was not successful',
                                  snackPosition: SnackPosition.TOP,
                                  duration: Duration(seconds: 3),
                                  icon: Icon(Icons.error),
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white);

                              print(e);
                            }
                          },
                        ),
                      ),
                SizedBox(
                  width: 30,
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.redAccent),
                  child: IconButton(
                      onPressed: () async {
                        final SharedPreferences pref = await _pref;
                        pref.clear().then((value) => print(value));
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StripePayment(
                                    text: "text", validator: "validator")));
                      },
                      icon: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 30,
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
