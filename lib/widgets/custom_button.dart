import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  final double borderRadius;
  final Color bgColor;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final VoidCallback onTap;
  final double height;
  const AppButton(
      {required this.text,
      required this.fontSize,
      required this.textColor,
      required this.bgColor,
      required this.onTap,
      required this.fontWeight,
      required this.borderRadius,
      required this.height,
      Key? key,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        margin:  EdgeInsets.symmetric(horizontal: 16, vertical: height),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: bgColor, borderRadius: BorderRadius.circular(borderRadius)),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(color: textColor, fontSize: fontSize),
        ),
      ),
    );
  }
}
