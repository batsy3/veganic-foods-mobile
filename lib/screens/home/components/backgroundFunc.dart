import 'package:flutter/material.dart';
import 'package:veganic_foods_app/constants/colors.dart';
import 'package:veganic_foods_app/widgets/custom_button.dart';
import 'backgroundUtils.dart';

class Components extends StatelessWidget {
  const Components({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    const color = Color.fromARGB(255, 81, 43, 170);

    //total height and width of screen
    return Background(
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(10),
            child: AppButton(
              text: "Get Started",
              bgColor: kPrimaryColor,
              textColor: Colors.purple,
              borderRadius: 30,
              fontSize: 25,
              fontWeight: FontWeight.w600,
              onTap: (){
              },
            )
          ),
        ],
      ),
    );
  }
}