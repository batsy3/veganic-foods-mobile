import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:veganic_foods_app/constants.dart';
import 'package:veganic_foods_app/providers/Api_provider.dart';
import 'package:veganic_foods_app/providers/cart_provider.dart';
import 'package:veganic_foods_app/widgets/custom_button.dart';
import 'package:veganic_foods_app/widgets/loading_button.dart';
import 'package:email_validator/email_validator.dart';

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
  late bool isvalid;
  @override
  void initState() {
    // TODO: implement initState
    controller.addListener(update);
    _tabController = new TabController(length: 2, vsync: this);
    citycontroller = TextEditingController();
    streetController = TextEditingController();
    emailcontroller = TextEditingController();
    countrycontroller = TextEditingController();
    phoneNumberController = TextEditingController();
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
    return Dialog(
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
          child: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(color: Colors.white70),
                      child: Column(children: [
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: TabBar(controller: _tabController, tabs: [
                            Tab(
                              text: "data",
                            ),
                            Tab(
                              text: "more text",
                            )
                          ]),
                        )
                      ]),
                    ),
                    Container(
                      height: 500,
                      child: TabBarView(controller: _tabController, children: [
                        Container(
                          padding: EdgeInsets.only(
                            top: 50,
                          ),
                          child: Column(
                            children: [
                              CardFormField(
                                controller: controller,
                                style: CardFormStyle(
                                  backgroundColor: Colors.white,
                                  // borderColor: Colors.white,
                                  placeholderColor: bGcolor,
                                  fontSize: 15,
                                  borderRadius: 20,
                                  borderWidth: 1,

                                  textColor: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              LoadingButton(
                                text: "next",
                                onpressed: controller.details.complete == true
                                    ? _handlePay
                                    : null,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            children: [
                              TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty || isvalid != true) {
                                    return 'enter valid email address';
                                  } else {
                                    return null;
                                  }
                                },
                                controller: emailcontroller,
                                decoration: InputDecoration(
                                    hintText: "email address",
                                    hintStyle: TextStyle(color: bGcolor)),
                                keyboardType: TextInputType.emailAddress,
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty || isvalid != true) {
                                    return 'enter valid email address';
                                  } else {
                                    return null;
                                  }
                                },
                                controller: phoneNumberController,
                                decoration: InputDecoration(
                                    hintText: "phone Number",
                                    hintStyle: TextStyle(color: bGcolor)),
                                keyboardType: TextInputType.emailAddress,
                              ),
                            ],
                          ),
                        )
                      ]),
                    )
                  ],
                )),
          ),
        ));
  }

  Future<void> _handlePay() async {
    if (!controller.details.complete) {
      return;
    }
    try {} catch (e) {}
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


                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Container(
                //       decoration: BoxDecoration(
                //           border: Border.all(color: bGcolor),
                //           borderRadius: BorderRadius.circular(20)),
                //       padding: EdgeInsets.only(left: 20),
                //       child: TextField(
                //         decoration: InputDecoration(
                //             border: InputBorder.none,
                //             hintText: 'card number'),
                //         onChanged: (number) {
                //           setState(() {
                //             _card = _card.copyWith(number: number);
                //           });
                //         },
                //         keyboardType: TextInputType.number,
                //       )),
                // ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //     children: [
                //       Expanded(
                //         flex: 2,
                //         child: Container(
                //             padding: EdgeInsets.only(
                //               left: 20,
                //             ),
                //             decoration: BoxDecoration(
                //                 border: Border.all(color: bGcolor),
                //                 borderRadius: BorderRadius.circular(20)),
                //             child: TextField(
                //               keyboardType: TextInputType.number,
                //               onChanged: (number) {
                //                 setState(() {
                //                   _card = _card.copyWith(
                //                       expirationYear: int.tryParse(number));
                //                 });
                //               },
                //               decoration: InputDecoration(
                //                   border: InputBorder.none,
                //                   hintText: "exp year"),
                //             )),
                //       ),
                //       SizedBox(
                //         width: 10,
                //       ),
                //       Expanded(
                //         flex: 2,
                //         child: Container(
                //             padding: EdgeInsets.only(left: 20),
                //             decoration: BoxDecoration(
                //                 border: Border.all(color: bGcolor),
                //                 borderRadius: BorderRadius.circular(20)),
                //             child: TextField(
                //               keyboardType: TextInputType.number,
                //               onChanged: (number) {
                //                 setState(() {
                //                   _card = _card.copyWith(
                //                       expirationMonth: int.tryParse(number));
                //                 });
                //               },
                //               decoration: InputDecoration(
                //                   border: InputBorder.none,
                //                   hintText: "exp month"),
                //             )),
                //       ),
                //       SizedBox(
                //         width: 10,
                //       ),
                //       Expanded(
                //         flex: 1,
                //         child: Container(
                //             padding: EdgeInsets.only(left:10),
                //             decoration: BoxDecoration(
                //                 border: Border.all(color: bGcolor),
                //                 borderRadius: BorderRadius.circular(20)),
                //             child: TextField(
                //               keyboardType: TextInputType.number,
                //               onChanged: (number) {
                //                 setState(() {
                //                   _card = _card.copyWith(cvc: number);
                //                 });
                //               },
                //               decoration: InputDecoration(
                //                   border: InputBorder.none, hintText: "cvc"),
                //             )),
                //       ),
                //     ],
                //   ),
                // ),
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
