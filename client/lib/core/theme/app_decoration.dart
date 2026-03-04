import 'package:flutter/material.dart';
import 'package:mbschool/core/theme/theme_helper.dart';
import 'package:mbschool/core/utils/size_utils.dart';


class AppDecoration {
  // Fill decorations
  static BoxDecoration get fillGray => BoxDecoration(
        color: appTheme.gray100,
      );

  static BoxDecoration get fillIndigo => BoxDecoration(
        color: appTheme.indigo50,
      );

  static BoxDecoration get fillPrimary => BoxDecoration(
        color: theme.colorScheme.primary,
      );

  static BoxDecoration get fillRed => BoxDecoration(
        color: appTheme.red400,
      );

  static BoxDecoration get fillSecondaryContainer => BoxDecoration(
        color: theme.colorScheme.secondaryContainer,
      );

  static BoxDecoration get fillWhiteA => BoxDecoration(
        color: appTheme.whiteA700,
      );

  // Menu decorations
  static BoxDecoration get menu => BoxDecoration(
        color: appTheme.whiteA700,
        boxShadow: [
          BoxShadow(
            color: appTheme.indigo8001e,
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: const Offset(
              4,
              0,
            ),
          ),
        ],
      );

  // Outline decorations
  static BoxDecoration get outlineBlack => BoxDecoration(
        color: appTheme.whiteA700,
        boxShadow: [
          BoxShadow(
            color: appTheme.black900.withValues(alpha: 0.06),
            spreadRadius: 0.h,
            blurRadius: 16.h,
            offset: const Offset(
              -4,
              5,
            ),
          ),
        ],
      );

  static BoxDecoration get outlineGray => BoxDecoration(
        border: Border.all(
          color: appTheme.gray700,
          width: 1.h,
        ),
      );

  static BoxDecoration get outlineWhiteA => BoxDecoration(
        color: appTheme.gray100,
        border: Border.all(
          color: appTheme.whiteA700,
          width: 1.h,
        ),
      );
}

class BorderRadiusStyle {
  // Circle borders
  static BorderRadius get circleBorder16 => BorderRadius.circular(
        16.h,
      );

  static BorderRadius get roundedBorder16 => BorderRadius.circular(
        16.h,
      );

  static BorderRadius get circleBorder28 => BorderRadius.circular(
        28.h,
      );

  static BorderRadius get circleBorder40 => BorderRadius.circular(
        40.h,
      );

  static BorderRadius get circleBorder58 => BorderRadius.circular(
        58.h,
      );

  // Custom borders
  static BorderRadius get customBorderBL24 => BorderRadius.vertical(
        bottom: Radius.circular(24.h),
      );

  static BorderRadius get customBorderTL12 => BorderRadius.vertical(
        top: Radius.circular(12.h),
      );

  // Rounded borders
  static BorderRadius get roundedBorder12 => BorderRadius.circular(
        12.h,
      );

  static BorderRadius get roundedBorder37 => BorderRadius.circular(
        37.h,
      );

  static BorderRadius get roundedBorder5 => BorderRadius.circular(
        5.h,
      );

  static BorderRadius get roundedBorder55 => BorderRadius.circular(
        55.h,
      );
}

// Comment/Uncomment the below code based on your Flutter SDK version.

// For Flutter SDK Version 3.7.2 or greater.

double get strokeAlignInside => BorderSide.strokeAlignInside;

double get strokeAlignCenter => BorderSide.strokeAlignCenter;

double get strokeAlignOutside => BorderSide.strokeAlignOutside;

// For Flutter SDK Version 3.7.1 or less.

// StrokeAlign get strokeAlignInside => StrokeAlign.inside;
//
// StrokeAlign get strokeAlignCenter => StrokeAlign.center;
//
// StrokeAlign get strokeAlignOutside => StrokeAlign.outside;
