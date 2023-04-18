import 'package:flutter/material.dart';
import 'package:mbschool/constants/colors.dart';

AppBar CustomAppBarPanel ({required String texte}){
    return AppBar(
      foregroundColor: textBlack,
      backgroundColor: textWhite,
      elevation: 0,
      shadowColor: Colors.transparent,
      centerTitle: true,
      title: Text(texte),
    );

}