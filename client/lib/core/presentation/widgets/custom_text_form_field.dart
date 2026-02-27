import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mbschool/core/theme/custom_text_style.dart';
import 'package:mbschool/core/theme/theme_helper.dart';
import 'package:mbschool/core/utils/size_utils.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    this.alignment,
    this.width,
    this.margin,
    this.controller,
    // this.focusNode,
    this.autofocus = false,
    this.textStyle,
    this.obscureText = false,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.maxLines,
    this.hintText,
    this.hintStyle,
    this.prefix,
    this.prefixConstraints,
    this.suffix,
    this.suffixConstraints,
    this.contentPadding,
    this.borderDecoration,
    this.fillColor,
    this.e,
    this.filled = true,
    this.validator,
    this.textAlign,
    this.inputFormatters,
  });

  final Alignment? alignment;

  final double? width;

  final EdgeInsetsGeometry? margin;

  final TextEditingController? controller;

  // final FocusNode? focusNode;

  final bool? autofocus;

  final TextStyle? textStyle;

  final bool? obscureText;

  final TextInputAction? textInputAction;

  final TextInputType? textInputType;

  final int? maxLines;

  final String? e;

  final String? hintText;

  final TextStyle? hintStyle;

  final Widget? prefix;

  final BoxConstraints? prefixConstraints;

  final Widget? suffix;

  final BoxConstraints? suffixConstraints;

  final EdgeInsets? contentPadding;

  final InputBorder? borderDecoration;

  final Color? fillColor;

  final bool? filled;

  final TextAlign? textAlign;

  final FormFieldValidator<String>? validator;

  final List<TextInputFormatter>? inputFormatters;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  String? errorText;
  @override
  Widget build(BuildContext context) {
    return widget.alignment != null
        ? Align(
      alignment: widget.alignment ?? Alignment.center,
      child: textFormFieldWidget,
    )
        : textFormFieldWidget;
  }

  Widget get textFormFieldWidget =>
      Container(
        width: widget.width ?? double.maxFinite,
        margin: widget.margin,
        child: TextFormField(
          controller: widget.controller,
          // focusNode: focusNode ?? FocusNode(),
          autofocus: widget.autofocus!,
          style: widget.textStyle ??
              theme.textTheme.bodyLarge!.copyWith(
                color: Colors.black,
              ),

          textAlign: widget.textAlign ?? TextAlign.start,
          obscureText: widget.obscureText!,
          textInputAction: widget.textInputAction,
          keyboardType: widget.textInputType,
          maxLines: widget.maxLines ?? 1,
          decoration: decoration,
          validator: widget.validator,
          inputFormatters: widget.inputFormatters,
           onChanged: (value) {
            setState(() {
              // Appelle la fonction validator et met à jour errorText
              errorText = widget.validator?.call(value);
            });
          },
        ),
      );

  InputDecoration get decoration =>
      InputDecoration(
        hintText: widget.hintText ?? "",
        hintStyle: widget.hintStyle ?? CustomTextStyles.bodyLargeGray600,
        errorText: errorText,
        errorStyle: TextStyle(
          color: appTheme.error,
          fontSize: 14.fSize,
          fontWeight: FontWeight.w400,
        ),
        errorMaxLines: 3,
        prefixIcon: widget.prefix ??
            SizedBox(
              width: 16.h,
            ),
        prefixIconConstraints:
        widget.prefixConstraints ?? BoxConstraints(maxHeight: 56.v),
        suffixIcon: widget.suffix,
        suffixIconConstraints: widget.suffixConstraints,
        isDense: true,
        contentPadding: widget.contentPadding ??
            EdgeInsets.only(
              left: 0.h,
              top: 16.h,
              right: 16.h,
              bottom: 16.h,
            ),
        fillColor: widget.fillColor ?? appTheme.textfeild,
        filled: widget.filled,
        border: widget.borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.h),
              borderSide: BorderSide.none,
            ),
        enabledBorder: widget.borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.h),
              borderSide: BorderSide.none,
            ),
        focusedBorder: widget.borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.h),
              borderSide: BorderSide.none,
            ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.h),
          borderSide: BorderSide(
            color: appTheme.error,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.h),
          borderSide: BorderSide(
            color: appTheme.error,
          ),
        ),
      );
}

/// Extension on [CustomTextFormField] to facilitate inclusion of all types of border style etc
extension TextFormFieldStyleHelper on CustomTextFormField {
  static OutlineInputBorder get outlineBlack =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.h),
        borderSide: BorderSide.none,
      );

  static OutlineInputBorder get fillGrayTL16 =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.h),
        borderSide: BorderSide.none,
      );
}
