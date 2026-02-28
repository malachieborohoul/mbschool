import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mbschool/core/constants/colors.dart';
import 'package:mbschool/core/constants/padding.dart';
import 'package:mbschool/core/constants/utils.dart';
import 'package:mbschool/core/l10n/app_localizations.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.prefixIcon,
    required this.labelText,
    this.controller, // Made optional to prevent null errors
    this.readOnlyField = false,
    this.isPassword = false,
    this.iconHeight = 17.0,
    this.maxLine = 1,
    this.height = 50.0,
    this.keyboardType,
    this.iconColor,
    this.codeKey = 1,
  });

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
  final int codeKey;

  @override
  CustomTextFieldState createState() => CustomTextFieldState(); // Public State
}

class CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    // Access localizations for error messages
    final l10n = AppLocalizations.of(context)!;

    return Container(
      height: widget.height,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: secondary.withValues(alpha: 0.25), width: 0.5),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 50.0,
            width: 50.0,
            alignment: Alignment.center,
            child: SvgPicture.asset(
              assetImg + widget.prefixIcon,
              height: widget.iconHeight,
              colorFilter: ColorFilter.mode(
                widget.iconColor ?? secondary, 
                BlendMode.srcIn,
              ),
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
                  color: secondary.withValues(alpha: 0.5),
                  fontSize: 15.0,
                  height: 1,
                ),
              ),
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return l10n.err_field_required; // Generic "Required" message
                }

                switch (widget.codeKey) {
                  case 1: // Last Name
                    return !RegExp(r'^[a-z A-Z]+$').hasMatch(val) 
                        ? l10n.err_invalid_name : null;
                  case 2: // First Name
                    return !RegExp(r'^[a-z A-Z]+$').hasMatch(val) 
                        ? l10n.err_invalid_name : null;
                  case 3: // Email
                    return !RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$').hasMatch(val)
                        ? l10n.err_invalid_email : null;
                  case 4: // Password
                    return val.length < 8 ? l10n.err_password_short : null;
                  default:
                    return null;
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}