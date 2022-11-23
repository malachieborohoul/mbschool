import 'package:flutter/material.dart';
import 'package:mbschool/constants/colors.dart';

class CustomButtonBoxPanel extends StatelessWidget {
  const CustomButtonBoxPanel({
    Key? key,
    required this.title,
    this.width = 80
  }) : super(key: key);

  final String title;
  final double width;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: width,
      height: 45.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: primary.withOpacity(0.7),
        borderRadius: BorderRadius.circular(17.5),
        boxShadow: [
          BoxShadow(
            color: primary.withOpacity(0.5),
            spreadRadius: 0.0,
            blurRadius: 6.0,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w700,
          color: textWhite,
        ),
      ),
    );
  }
}
