import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../providers/Api_provider.dart';
import '../providers/cart_provider.dart';
import '../utils/globals.dart';
import 'custom_button.dart';

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
                    ApiProvider().gateway(
                        textcontroller.text, context.read<Cart>().carttotal());
                    Navigator.of(context).pop();
                    Get.snackbar('', '',
                        // borderRadius: 30,
                        messageText: Text('hey thanks'),
                        titleText: Text(
                          'your paymnt is in progress',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        icon: Icon(Icons.playlist_add_check),
                        padding: EdgeInsets.all(15),
                        backgroundColor: Colors.amberAccent.shade700);
                  }
                },
              )
            ]),
          ),
        ));
  }
}
