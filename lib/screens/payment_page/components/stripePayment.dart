import 'package:credit_card_input_form/model/card_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:veganic_foods_app/constants.dart';
import 'package:veganic_foods_app/providers/Api_provider.dart';
import 'package:veganic_foods_app/providers/cart_provider.dart';
import 'package:veganic_foods_app/screens/payment_page/payment.dart';
import 'package:veganic_foods_app/screens/scanning_page/scan.dart';
import 'package:veganic_foods_app/widgets/default_back_button.dart';
import 'package:veganic_foods_app/widgets/loading_button.dart';
import 'package:email_validator/email_validator.dart';
import 'package:credit_card_input_form/credit_card_input_form.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StripePayment extends StatefulWidget {
  final String text;
  final String validator;
  const StripePayment({Key? key, required this.text, required this.validator})
      : super(key: key);

  @override
  State<StripePayment> createState() => _StripePaymentState();
}

class _StripePaymentState extends State<StripePayment>
    with TickerProviderStateMixin {
  final controller = CardFormEditController();
  late bool isvalid;
  late bool _check;
  late var _billingInfo = {};
  late TextEditingController emailcontroller;
  CardDetails _card = CardDetails();
  late CardInfo _cardInfo;
  @override
  void initState() {
    controller.addListener(update);
    _check = false;
    emailcontroller = TextEditingController();
    isvalid = EmailValidator.validate(emailcontroller.text);
    _billingInfo = {
      "name": null,
      "email": null,
      "phone": null,
    };
    _cardInfo =
        CardInfo(cardNumber: null, name: null, cvv: null, validate: null);
    _card = _card.copyWith(
        number: _cardInfo.cardNumber,
        cvc: _cardInfo.cvv,
        expirationMonth:
            int.tryParse(_cardInfo.validate.toString().split("/")[0][0]),
        expirationYear:
            int.tryParse(_cardInfo.validate.toString().split("/")[0][1]));

    super.initState();
  }

  void update() => setState(() {
        @override
        void dispose() {
          controller.removeListener(update);
          controller.dispose();
          super.dispose();
        }
      });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final buttonstyle = TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black,
        backgroundColor: Colors.amber);
    final buttondecoration = BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.amber));
    return Scaffold(
      backgroundColor: bGcolor,
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Padding(
                        padding: EdgeInsets.only(
                          left: 0,
                          top: 30,

                        ),
                        child: Text(
                          "Card Details",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: 150,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 30),
                        child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => PaymentPage())));
                            },
                            icon: Icon(
                              Icons.close,
                              color: Colors.black,
                              size: 30,
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 800,
                    child: Column(
                      children: [
                        Container(
                          child: CreditCardInputForm(
                            cardHeight: 190,
                            onStateChange: (inputstate, cardinfo) {
                              setState(() {
                                _cardInfo = cardinfo;
                              });
                            },
                            frontCardDecoration: BoxDecoration(
                              color: Colors.indigo.shade400,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            backCardDecoration: BoxDecoration(
                              color: Colors.indigo.shade400,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            resetButtonDecoration: buttondecoration,
                            nextButtonDecoration: buttondecoration,
                            nextButtonTextStyle: buttonstyle,
                            prevButtonDecoration: buttondecoration,
                            prevButtonTextStyle: buttonstyle,
                          ),
                        ),
                        Column(
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.only(top: 0, left: 10, right: 200),
                              child: Text(
                                "Billing Details",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey.shade400),
                                      borderRadius: BorderRadius.circular(10)),
                                  padding: EdgeInsets.all(0),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            borderSide: BorderSide(
                                                color: Colors.white)),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        hintText: 'Name',
                                        hintStyle:
                                            TextStyle(color: Colors.black)),
                                    onChanged: (value) {
                                      setState(() {
                                        _billingInfo["name"] = value;
                                      });
                                    },
                                    keyboardType: TextInputType.text,
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey.shade400),
                                      borderRadius: BorderRadius.circular(10)),
                                  padding: EdgeInsets.all(0),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            borderSide: BorderSide(
                                                color: Colors.white)),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        hintText: 'Email',
                                        hintStyle:
                                            TextStyle(color: Colors.black)),
                                    onChanged: (value) {
                                      setState(() {
                                        _billingInfo["email"] = value;
                                      });
                                    },
                                    keyboardType: TextInputType.text,
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey.shade400),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(0),
                                            borderSide: BorderSide(
                                                color: Colors.white)),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.white),
),
                                        hintText: 'phone',
                                        hintStyle:
                                            TextStyle(color: Colors.black)),
                                    onChanged: (value) {
                                      setState(() {
                                        _billingInfo["phone"] = value;
                                      });
                                    },
                                    keyboardType: TextInputType.number,
                                  )),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: size.width * 0.4),
                              child: Text(
                                "save billing details",
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 20),
                              ),
                            ),
                            Checkbox(
                                activeColor: Colors.indigo.shade400,
                                checkColor: Colors.white,
                                value: _check,
                                onChanged: (value) {
                                  setState(() {
                                    _check = value!;
                                  });
                                }),
                          ],
                        ),
                        Container(
                            padding: EdgeInsets.only(bottom: 15),
                            child: LoadingButton(
                                onpressed: _stripe_payment, text: "pay"))
                      ],
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _read() async {
    final pref = await SharedPreferences.getInstance();
    final key = "customer";
    final value = pref.getString(key) ?? null;
    print({"read value is ": value});
  }

  _write(String customerID) async {
    final pref = await SharedPreferences.getInstance();
    final key = "customer";
    final value = customerID;
    pref.setString(key, value).then((value) => print({"saved value": value}));
  }

  Future _stripe_payment() async {
    setState(() {
      _card = _card.copyWith(
          number: _cardInfo.cardNumber,
          cvc: _cardInfo.cvv,
          expirationMonth:
              int.tryParse(_cardInfo.validate.toString().split("/")[0]),
          expirationYear:
              int.tryParse(_cardInfo.validate.toString().split("/")[1]));
    });

    try {
      await Stripe.instance.dangerouslyUpdateCardDetails(_card);
      final billingDetails = BillingDetails(
          email: _billingInfo["email"],
          phone: _billingInfo["phone"],
          name: _billingInfo["name"]);
      await Stripe.instance.createPaymentMethod(PaymentMethodParams.card(
          paymentMethodData:
              PaymentMethodData(billingDetails: billingDetails)));
    } catch (e) {
      if (e.toString().contains("Your card number is incorrect")) {
        Get.snackbar("Sorry", 'your card number is incorrect',
            snackPosition: SnackPosition.TOP,
            duration: Duration(seconds: 3),
            icon: Icon(Icons.error),
            backgroundColor: Colors.red,
            colorText: Colors.white);
      } else {
        print(e);
        Get.snackbar("sorry", "recheck your credentials please",
            snackPosition: SnackPosition.TOP,
            duration: Duration(seconds: 3),
            icon: Icon(Icons.error),
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    }
    if (_check == true) {
      setState(() {
        _check = false;
      });
      try {
        ApiProvider().createCustomer().then((value) {
          _write(value);
          _read().toString();
          ApiProvider()
              .returningCustomer(
                  context.read<Cart>().carttotal(), value.toString(), "usd")
              .then((value) {
            // context.read<Cart>().clearall();
            Get.snackbar('Hey', 'Payment was succesfull',
                snackPosition: SnackPosition.TOP,
                duration: Duration(seconds: 3),
                icon: Icon(Icons.check),
                backgroundColor: Colors.green,
                colorText: Colors.white);
            Get.to(() => PaymentPage());
          });
        });
      } catch (e) {
        Get.snackbar('sorry', '$e',
            snackPosition: SnackPosition.TOP,
            duration: Duration(seconds: 3),
            icon: Icon(Icons.check),
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    } else {
      ApiProvider()
          .makePayment(context.read<Cart>().carttotal())
          .then((value) async {
        if (value["client_secret"] != null) {
          context.read<Cart>().clearall();
          Get.snackbar('Hey', 'Payment was succesfull',
              snackPosition: SnackPosition.TOP,
              duration: Duration(seconds: 3),
              icon: Icon(Icons.check),
              backgroundColor: Colors.green,
              colorText: Colors.white);
          Get.to(() => ScanningPage());
        } else {
          Get.snackbar('Error', '${value}',
              snackPosition: SnackPosition.TOP,
              duration: Duration(seconds: 3),
              icon: Icon(Icons.error),
              backgroundColor: Colors.red,
              colorText: Colors.white);
          Get.to(() => PaymentPage());
        }
      });
    }
  }
}
