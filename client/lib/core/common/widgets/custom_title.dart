
import 'package:flutter/material.dart';
import 'package:mbschool/core/constants/colors.dart';
import 'package:mbschool/features/course/screens/all_course_screen.dart';

class CustomTitle extends StatelessWidget {
  const CustomTitle({
    super.key,
    required this.title,
    this.route = '/404',
    this.extend = true,
    this.fontSize = 20.0,
    this.arg, 
    this.titreLien = "",
  });

  final String title;
  final String route;
  final bool extend;
  final double fontSize;
  final dynamic arg;
  final String titreLien;
  

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: secondary,
            fontSize: fontSize,
            fontWeight: FontWeight.w700,
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, AllCourseScreen.routeName, arguments: arg);
          },
          child: Text(
            titreLien,
            style: const TextStyle(
                color: primary, fontSize: 15.0, fontWeight: FontWeight.w400),
          ),
        )
      ],
    );
  }
}
