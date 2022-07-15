import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:veganic_foods_app/constants.dart';
import 'package:veganic_foods_app/providers/Api_provider.dart';
import 'package:veganic_foods_app/providers/cart_provider.dart';
import 'package:veganic_foods_app/widgets/loading_button.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

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
  late TabController _tabController;
  final controller = CardFormEditController();
  late TextEditingController citycontroller;
  late TextEditingController streetController;
  late TextEditingController emailcontroller;
  late TextEditingController countrycontroller;
  late TextEditingController phoneNumberController;
  late TextEditingController cvcCOntroller;
  late TextEditingController expdateCOntroller;
  late TextEditingController cardHolderController;
  late TextEditingController cardNUmberCOntroller;
  late bool isvalid;
  CardDetails _card = CardDetails();
  @override
  void initState() {
    controller.addListener(update);
    _tabController = new TabController(length: 2, vsync: this);
    citycontroller = TextEditingController();
    streetController = TextEditingController();
    emailcontroller = TextEditingController();
    countrycontroller = TextEditingController();
    phoneNumberController = TextEditingController();
    cvcCOntroller = TextEditingController();
    cardHolderController = TextEditingController();
    expdateCOntroller = TextEditingController();
    cardNUmberCOntroller = TextEditingController();
    isvalid = EmailValidator.validate(emailcontroller.text);
    super.initState();
  }

  void update() => setState(() {
        @override
        void dispose() {
          _tabController.dispose();
          controller.removeListener(update);
          controller.dispose();
          super.dispose();
        }
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bGcolor,
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Dialog(
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
                child: Container(
                  // height: 800,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(1),
                        child: CreditCardWidget(
                          backgroundImage: "assets/images/1_No Connection.png",
                          cardNumber: "",
                          expiryDate: "",
                          cardHolderName: "",
                          cvvCode: "",
                          cardBgColor: bGcolor,
                          showBackView: false,
                          glassmorphismConfig: Glassmorphism.defaultConfig(),
                          obscureCardNumber: true,
                          obscureCardCvv: true,
                          isHolderNameVisible: true,
                          height: 175,
                          cardType: CardType.mastercard,
                          textStyle: TextStyle(color: Colors.white),
                          width: MediaQuery.of(context).size.width,
                          isChipVisible: true,
                          isSwipeGestureEnabled: true,
                          animationDuration: Duration(milliseconds: 1000),
                          onCreditCardWidgetChange: (CreditCardBrand) {},
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: bGcolor),
                                    borderRadius: BorderRadius.circular(20)),
                                padding: EdgeInsets.only(left: 20),
                                child: TextField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'card number'),
                                  onChanged: (number) {
                                    setState(() {
                                      _card = _card.copyWith(number: number);
                                    });
                                  },
                                  keyboardType: TextInputType.number,
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                      padding: EdgeInsets.only(
                                        left: 20,
                                      ),
                                      decoration: BoxDecoration(
                                          border: Border.all(color: bGcolor),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: TextField(
                                        keyboardType: TextInputType.number,
                                        onChanged: (number) {
                                          setState(() {
                                            _card = _card.copyWith(
                                                expirationYear:
                                                    int.tryParse(number));
                                          });
                                        },
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "exp year"),
                                      )),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                      padding: EdgeInsets.only(left: 20),
                                      decoration: BoxDecoration(
                                          border: Border.all(color: bGcolor),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: TextField(
                                        keyboardType: TextInputType.number,
                                        onChanged: (number) {
                                          setState(() {
                                            _card = _card.copyWith(
                                                expirationMonth:
                                                    int.tryParse(number));
                                          });
                                        },
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "exp month"),
                                      )),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                      padding: EdgeInsets.only(left: 10),
                                      decoration: BoxDecoration(
                                          border: Border.all(color: bGcolor),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: TextField(
                                        keyboardType: TextInputType.number,
                                        onChanged: (number) {
                                          setState(() {
                                            _card = _card.copyWith(cvc: number);
                                          });
                                        },
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "cvc"),
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          padding: EdgeInsets.only(bottom: 15),
                          child: LoadingButton(
                              onpressed: _makepyment, text: "pay"))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _makepyment() async {
    await Stripe.instance.dangerouslyUpdateCardDetails(_card);

    final billingDetails = BillingDetails(
        email: "someemail.@123.com", phone: "098765433221", name: "bankss");
    final paymentMethod = await Stripe.instance.createPaymentMethod(
        PaymentMethodParams.card(
            paymentMethodData:
                PaymentMethodData(billingDetails: billingDetails)));
    var paymentINtent = ApiProvider()
        .makePayment(context.read<Cart>().carttotal())
        .then((value) => print("intent result" + value.toString()));
    print({
      "total":context.read<Cart>().total.ceil(),
      // "payment_method": paymentMethod.toString(),
      "payment_intent": paymentINtent.toString(),
    });
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
