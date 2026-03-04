// import 'package:flutter/material.dart';


// class CustomDropDown extends StatelessWidget {
//   CustomDropDown({
//     Key? key,
//     this.alignment,
//     this.width,
//     this.focusNode,
//     this.icon,
//     this.autofocus = true,
//     this.textStyle,
//     this.items,
//     this.hintText,
//     this.hintStyle,
//     this.prefix,
//     this.prefixConstraints,
//     this.suffix,
//     this.suffixConstraints,
//     this.contentPadding,
//     this.borderDecoration,
//     this.fillColor,
//     this.filled = true,
//     this.validator,
//     this.onChanged,
//   }) : super(
//           key: key,
//         );

//   final Alignment? alignment;

//   final double? width;

//   final FocusNode? focusNode;

//   final Widget? icon;

//   final bool? autofocus;

//   final TextStyle? textStyle;

//   final List<SelectionPopupModel>? items;

//   final String? hintText;

//   final TextStyle? hintStyle;

//   final Widget? prefix;

//   final BoxConstraints? prefixConstraints;

//   final Widget? suffix;

//   final BoxConstraints? suffixConstraints;

//   final EdgeInsets? contentPadding;

//   final InputBorder? borderDecoration;

//   final Color? fillColor;

//   final bool? filled;

//   final FormFieldValidator<SelectionPopupModel>? validator;

//   final Function(SelectionPopupModel)? onChanged;

//   @override
//   Widget build(BuildContext context) {
//     return alignment != null
//         ? Align(
//             alignment: alignment ?? Alignment.center,
//             child: dropDownWidget,
//           )
//         : dropDownWidget;
//   }

//   Widget get dropDownWidget => SizedBox(
//         width: width ?? double.maxFinite,
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 20.h),
//           child: DropdownButtonFormField<SelectionPopupModel>(
//             focusNode: focusNode ?? FocusNode(),
//             icon: icon,
//             // dropdownColor: Colors.yellow,
//             autofocus: autofocus!,
//             style: textStyle ?? CustomTextStyles.bodyLargeBlack900,
//             items: items?.map((SelectionPopupModel item) {
//               return DropdownMenuItem<SelectionPopupModel>(
//                 value: item,
//                 child: Text(
//                   item.title,
//                   overflow: TextOverflow.ellipsis,
//                   style: hintStyle ?? theme.textTheme.bodyLarge,
//                 ),
//               );
//             }).toList(),
//             decoration: decoration,
//             validator: validator,
//             onChanged: (value) {
//               onChanged!(value!);
//             },
//           ),
//         ),
//       );

//   InputDecoration get decoration => InputDecoration(
//         hintText: hintText ?? "",
//         hintStyle: hintStyle ?? theme.textTheme.bodyLarge,
//         prefixIcon: prefix,
//         prefixIconConstraints: prefixConstraints,
//         suffixIcon: suffix,
//         suffixIconConstraints: suffixConstraints,
//         isDense: true,
//         contentPadding: contentPadding ??
//             EdgeInsets.only(
//               left: 17.h,
//               top: 17.v,
//               bottom: 17.v,
//             ),
//         fillColor: fillColor ?? appTheme.gray100,
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
