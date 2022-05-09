// ignore: file_names
import 'package:flutter/material.dart';
import 'package:veganic_foods_app/constants.dart';
import 'package:veganic_foods_app/utils/routes.dart';
import 'package:veganic_foods_app/widgets/custom_button.dart';
import 'components/background_eclipses.dart';
import 'components/default_back_button.dart';

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

enum Paymentmethod { mtn, airtel, zanaco, fnb, card }

class _PaymentListState extends State<PaymentList> {
  Paymentmethod? _init = Paymentmethod.mtn;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; //total height and width of screen

    return Scaffold(
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
                    height: 30,
                  ),
                  RadioListTile<Paymentmethod>(
                    contentPadding: const EdgeInsets.only(left: 40),
                    value: Paymentmethod.mtn,
                    groupValue: _init,
                    onChanged: (Paymentmethod? value) =>
                        setState(() => {_init = value}),
                    activeColor: Colors.deepPurple[500],
                    title: const RadiotileCSS(
                      imagestring: 'assets/icons/mtn.png',
                      text: 'MTN',
                    ),
                    selected: false,
                  ),
                  const divider(),
                  RadioListTile<Paymentmethod>(
                    contentPadding: const EdgeInsets.only(left: 40),
                    value: Paymentmethod.airtel,
                    groupValue: _init,
                    onChanged: (Paymentmethod? value) =>
                        setState(() => {_init = value}),
                    activeColor: Colors.deepPurple[500],
                    title: const RadiotileCSS(
                      imagestring: 'assets/icons/airtel.png',
                      text: 'AIRTEL',
                    ),
                    selected: false,
                  ),
                  const divider(),
                  RadioListTile<Paymentmethod>(
                    contentPadding: const EdgeInsets.only(left: 40),
                    value: Paymentmethod.zanaco,
                    groupValue: _init,
                    onChanged: (Paymentmethod? value) =>
                        setState(() => {_init = value}),
                    activeColor: Colors.deepPurple[500],
                    title: const RadiotileCSS(
                      imagestring:
                          'assets/icons/ec7e7369341529.Y3JvcCwxNTQzLDEyMDcsMTI5LDA.png',
                      text: 'ZANACO',
                    ),
                    selected: false,
                  ),
                  const divider(),
                  RadioListTile<Paymentmethod>(
                    contentPadding: const EdgeInsets.only(left: 40),
                    value: Paymentmethod.fnb,
                    groupValue: _init,
                    onChanged: (Paymentmethod? value) =>
                        setState(() => {_init = value}),
                    activeColor: Colors.deepPurple[500],
                    title: const RadiotileCSS(
                      imagestring: 'assets/icons/fnb.png',
                      text: 'FNB',
                    ),
                    selected: false,
                  ),
                  const divider(),

                  const SizedBox(
                    height: 10,
                  ),
                  AppButton(
                    text: 'Proceed',
                    fontSize: 20,
                    textColor: Colors.white,
                    bgColor: Colors.black,
                    onTap: () {
                      Navigator.pushNamed(context, Routes.home);
                    },
                    fontWeight: FontWeight.bold,
                    borderRadius: 30,
                    height: 10,
                  ),
                  // ElevatedButton(
                  //   style: ElevatedButton.styleFrom(
                  //       shadowColor: Colors.black,
                  //       shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(20)),
                  //       primary: Colors.black,
                  //       onPrimary: Colors.white,
                  //       // ignore: prefer_const_constructors
                  //       textStyle: TextStyle(
                  //           fontSize: 20, fontWeight: FontWeight.normal),
                  //       minimumSize: const Size(280, 40)),
                  //   child: const Text('Proceed'),
                  //   onPressed: () {},
                  // ),
                  // ignore: prefer_const_constructors
                  SizedBox(
                    height: 20,
                  )
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
//                 ),
//               ]),
//             ),
//           ],
//         ));
