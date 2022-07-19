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
import 'package:veganic_foods_app/widgets/loading_button.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:credit_card_input_form/credit_card_input_form.dart';

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
  late var _billingInfo = {};
  late TextEditingController emailcontroller;
  CardDetails _card = CardDetails();
  late CardInfo _cardInfo;
  @override
  void initState() {
    controller.addListener(update);
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
                height: 40,
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, left: 10, right: 200),
                child: Text(
                  "Card Details",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
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
                            print(_cardInfo);
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
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: bGcolor),
                                  borderRadius: BorderRadius.circular(20)),
                              padding: EdgeInsets.all(8),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide:
                                            BorderSide(color: Colors.white)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    hintText: 'Name',
                                    hintStyle: TextStyle(color: Colors.black)),
                                onChanged: (value) {
                                  setState(() {
                                    _billingInfo["name"] = value;
                                  });
                                },
                                keyboardType: TextInputType.text,
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: bGcolor),
                                  borderRadius: BorderRadius.circular(20)),
                              padding: EdgeInsets.all(8),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide:
                                            BorderSide(color: Colors.white)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    hintText: 'Email',
                                    hintStyle: TextStyle(color: Colors.black)),
                                onChanged: (value) {
                                  setState(() {
                                    _billingInfo["email"] = value;
                                  });
                                },
                                keyboardType: TextInputType.text,
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: bGcolor),
                                  borderRadius: BorderRadius.circular(20)),
                              padding: EdgeInsets.all(8),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide:
                                            BorderSide(color: Colors.white)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    hintText: 'phone',
                                    hintStyle: TextStyle(color: Colors.black)),
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
                    Container(
                        padding: EdgeInsets.only(bottom: 15),
                        child:
                            LoadingButton(onpressed: _makepyment, text: "pay"))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _makepyment() async {
    print(_card);
    setState(() {
      _card = _card.copyWith(
          number: _cardInfo.cardNumber,
          cvc: _cardInfo.cvv,
          expirationMonth:
              int.tryParse(_cardInfo.validate.toString().split("/")[0][0]),
          expirationYear:
              int.tryParse(_cardInfo.validate.toString().split("/")[0][1]));
    });
    try {
      await Stripe.instance.dangerouslyUpdateCardDetails(_card);

      final billingDetails = BillingDetails(
          email: _billingInfo["email"],
          phone: _billingInfo["phone"],
          name: _billingInfo["name"]);
      final paymentMethod = await Stripe.instance.createPaymentMethod(
          PaymentMethodParams.card(
              paymentMethodData:
                  PaymentMethodData(billingDetails: billingDetails)));
      var paymentINtent = ApiProvider()
          .makePayment(context.read<Cart>().carttotal())
          .then((value) async {
        if (value["client_secret"] != null) {
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
    } catch (e) {
      if (e.toString().contains("Your card number is incorrect")) {
        Get.snackbar("Sorry", 'your card number is incorrect',
            snackPosition: SnackPosition.TOP,
            duration: Duration(seconds: 3),
            icon: Icon(Icons.error),
            backgroundColor: Colors.red,
            colorText: Colors.white);
      } else {
        Get.snackbar("sorry", "recheck your credentials please",
            snackPosition: SnackPosition.TOP,
            duration: Duration(seconds: 3),
            icon: Icon(Icons.error),
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    }
  }
}



// CardFormField(
//   controller: controller,
//   style: CardFormStyle(
//     placeholderColor: Colors.red,
//     fontSize: 10,
//     textColor: Colors.white,
//   ),
// ),
// LoadingButton(
//   text: "pay",
//   onpressed:
//       controller.details.complete == true ? _handlePay : null,
// )

// //           CheckboxListTile(
// CheckboxListTile(
//   value: _savecard,
//   onChanged: (value) {
//     setState(() {
//       _savecard = value;
//     });
//   },
//   title: Text("save card during payment"),
// ),

// AppButton(
//     text: "Pay",
//     fontSize: 25,
//     textColor: bGcolor,
//     bgColor: Colors.black,
//     onTap: () {},
//     fontWeight: FontWeight.bold,
//     borderRadius: 30,
//     height: 34)

// Container(
//             child: SingleChildScrollView(
//               child: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 20),
//                   child: Column(
//                     children: [
//                       Container(
//                         decoration: BoxDecoration(color: Colors.white70),
//                         child: Column(children: [
//                           Padding(
//                             padding: EdgeInsets.all(5),
//                             child: TabBar(controller: _tabController, tabs: [
//                               Tab(
//                                 text: "data",
//                               ),
//                               Tab(
//                                 text: "more text",
//                               )
//                             ]),
//                           )
//                         ]),
//                       ),
//                       Container(
//                         height: 400,
//                         child:
//                             TabBarView(controller: _tabController, children: [
//                           Container(
//                             padding: EdgeInsets.only(
//                               top: 50,
//                             ),
//                             child: Column(
//                               children: [
//                                 CardFormField(
//                                   controller: controller,
//                                   style: CardFormStyle(
//                                     backgroundColor: Colors.white,
//                                     // borderColor: Colors.white,
//                                     placeholderColor: bGcolor,
//                                     fontSize: 15,
//                                     borderRadius: 20,
//                                     borderWidth: 1,

//                                     textColor: Colors.black,
//                                   ),
//                                 ),
//                                 // SizedBox(
//                                 //   height: 30,
//                                 // ),
//                                 ElevatedButton(
//                                     onPressed: () => _tabController
//                                         .animateTo((_tabController.index + 1)),
//                                     child: Text("next"))
//                                 // LoadingButton(
//                                 //   text: "next",
//                                 //   onpressed: controller.details.complete == true
//                                 //       ? _handlePay
//                                 //       : null,
//                                 // ),
//                               ],
//                             ),
//                           ),
//                           Container(
//                             padding: EdgeInsets.all(20),
//                             child: Column(
//                               children: [
//                                 SizedBox(
//                                   height: 20,
//                                 ),
//                                 TextFormField(
//                                   validator: (value) {
//                                     if (value!.isEmpty ||
//                                         isvalid != true ||
//                                         !value.isEmail) {
//                                       return 'enter valid email address';
//                                     } else {
//                                       return null;
//                                     }
//                                   },
//                                   controller: emailcontroller,
//                                   decoration: InputDecoration(
//                                       hintText: "email address",
//                                       hintStyle: TextStyle(
//                                           color: Colors.grey.shade300)),
//                                   keyboardType: TextInputType.emailAddress,
//                                 ),
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                                 TextFormField(
//                                   validator: (value) {
//                                     if (value!.isEmpty || value.isNumericOnly) {
//                                       return 'enter valid phone number';
//                                     } else {
//                                       return null;
//                                     }
//                                   },
//                                   controller: phoneNumberController,
//                                   decoration: InputDecoration(
//                                       hintText: "phone Number",
//                                       hintStyle: TextStyle(
//                                           color: Colors.grey.shade300)),
//                                   keyboardType: TextInputType.number,
//                                 ),
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                                 TextFormField(
//                                     controller: countrycontroller,
//                                     decoration: InputDecoration(
//                                         hintText: "country",
//                                         hintStyle: TextStyle(
//                                             color: Colors.grey.shade300)),
//                                     keyboardType: TextInputType.text),
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                                 TextFormField(
//                                   controller: citycontroller,
//                                   decoration: InputDecoration(
//                                       hintText: "City",
//                                       hintStyle: TextStyle(
//                                           color: Colors.grey.shade300)),
//                                   keyboardType: TextInputType.text,
//                                 ),
//                                 SizedBox(
//                                   height: 40,
//                                 ),
//                                 LoadingButton(
//                                     text: "pay",
//                                     onpressed: () async {
//                                       await Stripe.instance.createPaymentMethod(
//                                           PaymentMethodParams.card(
//                                               paymentMethodData:
//                                                   PaymentMethodData(
//                                         billingDetails: null,
//                                       )));
//                                     })
//                               ],
//                             ),
//                           )
//                         ]),
//                       ),
//                     ],
//                   )),
//             ),
//           )),
