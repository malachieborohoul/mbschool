import 'package:flutter/material.dart';
import 'package:mbschool/core/constants/colors.dart';

class CustomCategoriesButton extends StatelessWidget {
  const CustomCategoriesButton({
    super.key,
    required this.title,
  });

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
        color: primary.withValues(alpha:0.7),
        borderRadius: BorderRadius.circular(100.0),
        boxShadow: [
          BoxShadow(
            color: primary.withValues(alpha:0.5),
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
