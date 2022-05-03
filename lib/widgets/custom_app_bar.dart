import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar(this.leftArrowIcon, this.rightExtraIcon, {this.leftCallback, Key? key}) : super(key: key);
  final IconData leftArrowIcon;
  final IconData rightExtraIcon;
  final Function? leftCallback;

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
          right: 25,
          left: 25
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: leftCallback != null ? () => leftCallback!() : null,
            child: _buildContainer(leftArrowIcon),
          ),
          _buildContainer(rightExtraIcon)
        ],
      ),
    );
  }

  Widget _buildContainer(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: Icon(icon),
    );
  }
}
