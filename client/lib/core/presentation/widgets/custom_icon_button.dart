import 'package:flutter/material.dart';
import 'package:mbschool/core/theme/theme_helper.dart';
import 'package:mbschool/core/utils/size_utils.dart';


class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    this.alignment,
    this.height,
    this.width,
    this.padding,
    this.decoration,
    this.child,
    this.onTap,
  });

  final Alignment? alignment;

  final double? height;

  final double? width;

  final EdgeInsetsGeometry? padding;

  final BoxDecoration? decoration;

  final Widget? child;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: iconButtonWidget,
          )
        : iconButtonWidget;
  }

  Widget get iconButtonWidget => SizedBox(
        height: height ?? 0,
        width: width ?? 0,
        child: IconButton(
          padding: EdgeInsets.zero,
          icon: Container(
            height: height ?? 0,
            width: width ?? 0,
            padding: padding ?? EdgeInsets.zero,
            decoration: decoration ??
                BoxDecoration(
                  color: appTheme.gray100,
                  borderRadius: BorderRadius.circular(24.h),
                ),
            child: child,
          ),
          onPressed: onTap,
        ),
      );
}

/// Extension on [CustomIconButton] to facilitate inclusion of all types of border style etc
extension IconButtonStyleHelper on CustomIconButton {
  static BoxDecoration get fillWhiteA => BoxDecoration(
        color: appTheme.whiteA700,
        borderRadius: BorderRadius.circular(24.h),
      );

  static BoxDecoration get fillGray => BoxDecoration(
        color: appTheme.gray100,
        borderRadius: BorderRadius.circular(24.h),
      );

  static BoxDecoration get fillIndigoTL28 => BoxDecoration(
        color: appTheme.indigo50,
        borderRadius: BorderRadius.circular(28.h),
      );

  static BoxDecoration get fillBlack => BoxDecoration(
        color: appTheme.black900.withValues(alpha: .5),
        borderRadius: BorderRadius.circular(32.h),
      );

  static BoxDecoration get fillWhiteATL36 => BoxDecoration(
        color: appTheme.whiteA700,
        borderRadius: BorderRadius.circular(36.h),
      );

  static BoxDecoration get fillGrayTL12 => BoxDecoration(
        color: appTheme.gray100,
        borderRadius: BorderRadius.circular(12.h),
      );

  static BoxDecoration get outlineBlack => BoxDecoration(
        color: appTheme.whiteA700,
        borderRadius: BorderRadius.circular(20.h),
        boxShadow: [
          BoxShadow(
            color: appTheme.black900.withValues(alpha: 0.06),
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: const Offset(
              -4,
              5,
            ),
          ),
        ],
      );

  static BoxDecoration get fillIndigoTL12 => BoxDecoration(
        color: appTheme.indigo50,
        borderRadius: BorderRadius.circular(12.h),
      );
}
