// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:mbschool/core/theme/custom_text_style.dart';
import 'package:mbschool/core/theme/theme_helper.dart';
import 'package:mbschool/core/utils/size_utils.dart';

class CustomSearchView extends StatelessWidget {
  const CustomSearchView({
    super.key,
    // this.focusNode,
    this.alignment,
    this.width,
    this.margin,
    this.controller,
    this.autofocus = false,
    this.textStyle,
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
    this.filled = true,
    this.readOnly = false,
    this.validator, this.onTap,
  });

  final Alignment? alignment;

  final double? width;

  final EdgeInsetsGeometry? margin;

  final TextEditingController? controller;

  // final FocusNode? focusNode;

  final bool? autofocus;

  final TextStyle? textStyle;

  final TextInputType? textInputType;

  final int? maxLines;

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

  final bool? readOnly;

  final void Function()? onTap;

  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: searchViewWidget,
          )
        : searchViewWidget;
  }

  Widget get searchViewWidget => Container(
        width: width ?? double.maxFinite,
        margin: margin,
        decoration: BoxDecoration(
          color: fillColor ?? appTheme.textfeild,
          borderRadius: BorderRadius.circular(12.h),
        ),
        child: TextFormField(
          controller: controller,
          // focusNode: focusNode ?? FocusNode(),
          onTap: () {
            onTap?.call();
          },
          autofocus: autofocus!,
          style: textStyle ?? theme.textTheme.bodyLarge,
          keyboardType: textInputType,
          maxLines: maxLines ?? 1,
          decoration: decoration,
          validator: validator,
          readOnly: readOnly!,
        ),
      );

  InputDecoration get decoration => InputDecoration(
        hintText: hintText ?? "",
        hintStyle: hintStyle ?? CustomTextStyles.bodyLargeGray700_1,
        prefixIcon: prefix,
        prefixIconConstraints: prefixConstraints,
        suffixIcon: suffix ??
            Padding(
              padding: EdgeInsets.only(
                right: 15.h,
              ),
              child: IconButton(
                onPressed: () => controller!.clear(),
                icon: Icon(
                  Icons.clear,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
        suffixIconConstraints: suffixConstraints,
        isDense: false,
        contentPadding: contentPadding ??
            EdgeInsets.only(
              top: 14.v,
              left: 16.h,
              right: 16.h,
              bottom: 14.h,
            ),
        fillColor: fillColor ?? appTheme.textfeild,
        filled: filled,
        border: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.h),
              borderSide: BorderSide.none,
            ),
        enabledBorder: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.h),
              borderSide: BorderSide.none,
            ),
        focusedBorder: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.h),
              borderSide: BorderSide.none,
            ),
      );
}
