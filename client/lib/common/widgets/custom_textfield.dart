import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/constants/padding.dart';
import 'package:mbschool/constants/utils.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    Key? key,
    required this.prefixIcon,
    required this.labelText,
    required this.controller,
    this.readOnlyField = false,
    this.isPassword = false,
    this.iconHeight = 17.0,
    this.maxLine = 1,
    this.height = 50.0,
    this.keyboardType,
    this.iconColor,
  }) : super(key: key);
  final String prefixIcon;
  final double iconHeight;
  final String labelText;
  final TextEditingController? controller;
  final bool isPassword;
  final bool readOnlyField;
  final int maxLine;
  final double height;
  final TextInputType? keyboardType;
  final Color? iconColor;

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return 
    Container(
      height: widget.height,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: secondary.withOpacity(0.25), width: 0.5),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 50.0,
            width: 50.0,
            // color: grey,
            alignment: Alignment.center,
            child: SvgPicture.asset(
              assetImg + widget.prefixIcon,
              height: widget.iconHeight,
              color: widget.iconColor,
            ),
          ),
          const SizedBox(width: miniSpacer),
          Flexible(
              child: TextFormField(
            keyboardType: widget.keyboardType,
            readOnly: widget.readOnlyField,
            obscureText: widget.isPassword,
            controller: widget.controller,
            maxLines: widget.maxLine,
            style: const TextStyle(
              fontSize: 15.0,
              color: secondary,
              fontWeight: FontWeight.w500,
            ),
            cursorColor: secondary,
            decoration: InputDecoration(
              border: InputBorder.none,
              labelText: widget.labelText,
              labelStyle: TextStyle(
                color: secondary.withOpacity(0.5),
                fontSize: 15.0,
                height: 1,
              ),
            ),
            validator: (val) {
              if (val == null || val.isEmpty) {
                return "Entrez votre ${widget.labelText}";
              }
              return null;
            },
          )),
        ],
      ),
    );
 
  }
}
