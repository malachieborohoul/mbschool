import 'package:flutter/material.dart';
import 'package:mbschool/constants/colors.dart';

class CustomCategoriesButton extends StatelessWidget {
  const CustomCategoriesButton({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      // alignment: Alignment.center,
      padding: const EdgeInsets.only(
        left: 20.0,
        right: 20.0,
        top: 10.0,
        bottom: 10.0,
      ),
      decoration: BoxDecoration(
        color: primary.withOpacity(0.7),
        borderRadius: BorderRadius.circular(100.0),
        boxShadow: [
          BoxShadow(
            color: primary.withOpacity(0.5),
            spreadRadius: 0.0,
            blurRadius: 6.0,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: textWhite,
          fontSize: 15.0,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
