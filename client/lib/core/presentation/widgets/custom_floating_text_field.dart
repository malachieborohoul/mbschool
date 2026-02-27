// import 'package:flutter/material.dart';
// import '../core/app_export.dart';

// class CustomFloatingTextField extends StatelessWidget {
//   CustomFloatingTextField({
//     Key? key,
//     this.alignment,
//     this.width,
//     this.scrollPadding,
//     this.controller,
//     this.focusNode,
//     this.autofocus = true,
//     this.textStyle,
//     this.obscureText = false,
//     this.textInputAction = TextInputAction.next,
//     this.textInputType = TextInputType.text,
//     this.maxLines,
//     this.hintText,
//     this.hintStyle,
//     this.labelText,
//     this.labelStyle,
//     this.prefix,
//     this.prefixConstraints,
//     this.suffix,
//     this.suffixConstraints,
//     this.contentPadding,
//     this.borderDecoration,
//     this.fillColor,
//     this.filled = true,
//     this.validator,
//   }) : super(
//           key: key,
//         );

//   final Alignment? alignment;

//   final double? width;

//   final TextEditingController? scrollPadding;

//   final TextEditingController? controller;

//   final FocusNode? focusNode;

//   final bool? autofocus;

//   final TextStyle? textStyle;

//   final bool? obscureText;

//   final TextInputAction? textInputAction;

//   final TextInputType? textInputType;

//   final int? maxLines;

//   final String? hintText;

//   final TextStyle? hintStyle;

//   final String? labelText;

//   final TextStyle? labelStyle;

//   final Widget? prefix;

//   final BoxConstraints? prefixConstraints;

//   final Widget? suffix;

//   final BoxConstraints? suffixConstraints;

//   final EdgeInsets? contentPadding;

//   final InputBorder? borderDecoration;

//   final Color? fillColor;

//   final bool? filled;

//   final FormFieldValidator<String>? validator;

//   @override
//   Widget build(BuildContext context) {
//     return alignment != null
//         ? Align(
//             alignment: alignment ?? Alignment.center,
//             child: floatingTextFieldWidget,
//           )
//         : floatingTextFieldWidget;
//   }

//   Widget get floatingTextFieldWidget => SizedBox(
//         width: width ?? double.maxFinite,
//         child: TextFormField(
//           scrollPadding: EdgeInsets.only(
//               bottom: MediaQuery.of(Get.context!).viewInsets.bottom),
//           controller: controller,
//           focusNode: focusNode ?? FocusNode(),
//           autofocus: autofocus!,
//           style: textStyle ?? theme.textTheme.titleMedium,
//           obscureText: obscureText!,
//           textInputAction: textInputAction,
//           keyboardType: textInputType,
//           maxLines: maxLines ?? 1,
//           decoration: decoration,
//           validator: validator,
//         ),
//       );
//   InputDecoration get decoration => InputDecoration(
//         hintText: hintText ?? "",
//         hintStyle: hintStyle ?? theme.textTheme.titleMedium,
//         labelText: labelText ?? "",
//         labelStyle: labelStyle,
//         prefixIcon: prefix,
//         prefixIconConstraints: prefixConstraints,
//         suffixIcon: suffix,
//         suffixIconConstraints: suffixConstraints,
//         isDense: true,
//         contentPadding:
//             contentPadding ?? EdgeInsets.fromLTRB(14.h, 47.v, 14.h, 14.v),
//         fillColor: fillColor ?? appTheme.whiteA700,
//         filled: filled,
//         border: borderDecoration ??
//             OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12.h),
//               borderSide: BorderSide.none,
//             ),
//         enabledBorder: borderDecoration ??
//             OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12.h),
//               borderSide: BorderSide.none,
//             ),
//         focusedBorder: borderDecoration ??
//             OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12.h),
//               borderSide: BorderSide.none,
//             ),
//       );
// }
