  import 'package:flutter/material.dart';
import 'package:mbschool/core/common/widgets/custom_textfield.dart';
import 'package:mbschool/core/constants/colors.dart';
import 'package:mbschool/core/constants/padding.dart';

Widget buildTextField(String label, String icon, TextEditingController ctrl, int code, {bool isPass = false, TextInputType? type}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: spacer - 40),
      child: CustomTextField(
        codeKey: code,
        prefixIcon: icon,
        labelText: label,
        controller: ctrl,
        iconColor: primary,
        isPassword: isPass,
        keyboardType: type,
      ),
    );
  }