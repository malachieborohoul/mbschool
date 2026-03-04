import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:mbschool/core/constants/colors.dart';
import 'package:mbschool/core/constants/utils.dart';

class CustomButtonSocial extends StatelessWidget {
  final String svgIcon;
  const CustomButtonSocial({super.key, required this.svgIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 85,
      height: 50,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: secondary.withValues(alpha: 0.25), width: 1)
      ),
      child: SvgPicture.asset(assetImg+svgIcon, fit: BoxFit.none,),
      
    );
  }
}
