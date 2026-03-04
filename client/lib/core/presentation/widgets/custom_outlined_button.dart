import 'package:flutter/material.dart';
import 'package:mbschool/core/theme/custom_text_style.dart';

import 'package:mbschool/core/utils/size_utils.dart';

import 'base_button.dart';

class CustomOutlinedButton extends BaseButton {
  const CustomOutlinedButton({super.key, 
    this.decoration,
    this.leftIcon,
    this.rightIcon,
    this.label,
    VoidCallback? onPressed,
    super.buttonStyle,
    super.buttonTextStyle,
    super.isDisabled,
    super.alignment,
    super.height,
    super.width,
    super.margin,
    required super.text,
  }) : super(
          onTap: onPressed,
        );

  final BoxDecoration? decoration;

  final Widget? leftIcon;

  final Widget? rightIcon;

  final Widget? label;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: buildOutlinedButtonWidget,
          )
        : buildOutlinedButtonWidget;
  }

  Widget get buildOutlinedButtonWidget => Container(
        height: height ?? 56.v,
        width: width ?? double.maxFinite,
        margin: margin,
        decoration: decoration,
        child: OutlinedButton(
          style: buttonStyle,
          onPressed: isDisabled ?? false ? null : onTap ?? () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              leftIcon ?? const SizedBox.shrink(),
              Text(
                text,
                style: buttonTextStyle ??
                    CustomTextStyles.titleMediumPrimaryMedium,
              ),
              rightIcon ?? const SizedBox.shrink(),
            ],
          ),
        ),
      );
}
