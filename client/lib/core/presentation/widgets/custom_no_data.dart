import 'package:flutter/material.dart';
import 'package:mbschool/core/theme/theme_helper.dart';
import 'package:mbschool/core/utils/image_constant.dart';
import 'package:mbschool/core/utils/size_utils.dart';


class CustomNoData extends StatelessWidget {
  const CustomNoData({super.key,  required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
  

    return Column(
                    children: [
                      Image.asset(ImageConstant.nodata, width: 300.h,),
                      Text(message, style: theme.textTheme.titleLarge!.copyWith(color: Colors.black),),
             
                    ],
                  );
  }
}