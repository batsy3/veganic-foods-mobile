import 'package:flutter/material.dart';
import 'package:veganic_foods_app/utils/routes.dart';
import 'package:veganic_foods_app/widgets/custom_button.dart';
import 'background_utils.dart';

class Components extends StatelessWidget {
  const Components({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(10),
              child: AppButton(
                text: "Get Started",
                bgColor: Colors.white,
                textColor: Colors.purple,
                borderRadius: 30,
                fontSize: 25,
                fontWeight: FontWeight.w600,
                onTap: () {
                  Navigator.pushNamed(context, Routes.scan);
                },
                height: 24,
              )),
        ],
      ),
    );
  }
}
