import 'package:flutter/material.dart';
import 'package:mbschool/constants/colors.dart';

class CustomButtonBox extends StatelessWidget {
  const CustomButtonBox({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return 
    Container(
      width: size.width,
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
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w700,
          color: textWhite,
        ),
      ),
    );
  
  }
}
