
import 'package:flutter/material.dart';
import 'package:mbschool/core/theme/custom_text_style.dart';
import 'package:mbschool/core/theme/theme_helper.dart';
import 'package:mbschool/core/utils/size_utils.dart';

class CustomRadioButton extends StatelessWidget {
  const CustomRadioButton({
    super.key,
    required this.onChange,
    this.decoration,
    this.alignment,
    this.isRightCheck,
    this.iconSize,
    this.value,
    this.groupValue,
    this.text,
    this.width,
    this.padding,
    this.textStyle,
    this.textAlignment,
    this.gradient,
    this.backgroundColor,
  });

  final BoxDecoration? decoration;

  final Alignment? alignment;

  final bool? isRightCheck;

  final double? iconSize;

  final String? value;

  final String? groupValue;

  final Function(String) onChange;

  final String? text;

  final double? width;

  final EdgeInsetsGeometry? padding;

  final TextStyle? textStyle;

  final TextAlign? textAlignment;

  final Gradient? gradient;

  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: buildRadioButtonWidget,
          )
        : buildRadioButtonWidget;
  }

  bool get isGradient => gradient != null;

  BoxDecoration get gradientDecoration => BoxDecoration(gradient: gradient);

  Widget get buildRadioButtonWidget => InkWell(
        onTap: () {
          onChange(value!);
        },
        child: Container(
          decoration: decoration,
          width: width,
          padding: padding,
          child: (isRightCheck ?? false)
              ? rightSideRadioButton
              : leftSideRadioButton,
        ),
      );

  Widget get leftSideRadioButton => Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 8.v),
            child: radioButtonWidget,
          ),
          textWidget,
        ],
      );

  Widget get rightSideRadioButton => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          textWidget,
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: radioButtonWidget,
          ),
        ],
      );

  Widget get textWidget => Text(
        text ?? "",
        textAlign: textAlignment ?? TextAlign.center,
        style: textStyle ?? CustomTextStyles.bodyLargeBlack900,
      );

Widget get radioButtonWidget => SizedBox(
      height: iconSize,
      width: iconSize,
      child: Theme(
        data: ThemeData(
          // Note: In 2026, prefer using radioTheme over unselectedWidgetColor
          radioTheme: RadioThemeData(
            fillColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return theme.colorScheme.primary;
              }
              return appTheme.textfeild;
            }),
          ),
        ),
        child: Radio<String>(
          activeColor: theme.colorScheme.primary,
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          value: value ?? "",
          // groupValue: groupValue, // DEPRECATED: Remove this
          // onChanged: (val) => onChange(val!), // DEPRECATED: Remove this
        ),
      ),
    );

  BoxDecoration get radioButtonDecoration =>
      BoxDecoration(color: backgroundColor);
}
