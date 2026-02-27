import 'package:flutter/material.dart';
import 'package:mbschool/core/constants/colors.dart';

AppBar customAppBarPanel ({required String texte}){
    return AppBar(
      foregroundColor: textBlack,
      backgroundColor: textWhite,
      elevation: 0,
      shadowColor: Colors.transparent,
      centerTitle: true,
      title: Text(texte),
    );

}