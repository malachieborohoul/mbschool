import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mbschool/constants/colors.dart';

class CustomTextFieldPanel extends StatelessWidget {
  final String hintText;
  final IconData prefixIcon;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final maxLines;
  const CustomTextFieldPanel(
      {Key? key,
      required this.hintText,
      required this.prefixIcon,
      required this.controller,
      this.keyboardType,
      this.maxLines = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: textWhite,
        prefixIcon: Icon(
          prefixIcon,
          color: Colors.grey.shade300,
        ),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey.shade300),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primary),
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return "Entrez ${hintText}";
        }
      },
      maxLines: maxLines,
    );
  }
}
