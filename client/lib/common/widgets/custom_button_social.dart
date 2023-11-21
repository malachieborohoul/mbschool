import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/constants/utils.dart';

class CustomButtonSocial extends StatelessWidget {
  final String svgIcon;
  const CustomButtonSocial({Key? key, required this.svgIcon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 85,
      height: 50,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: secondary.withOpacity(0.25), width: 1)
      ),
      child: SvgPicture.asset(assetImg+svgIcon, fit: BoxFit.none,),
      
    );
  }
}
