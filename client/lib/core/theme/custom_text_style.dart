// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:mbschool/core/theme/theme_helper.dart';
import 'package:mbschool/core/utils/size_utils.dart';


/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.

class CustomTextStyles {
  // Body text style
  static TextStyle get bodyLargeBlack900 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.black900,
      );

  static TextStyle get bodyLargeGray600 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.hintColor,
      );

  static TextStyle get bodyLargeGray700_1 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.gray700,
      );

  static TextStyle get titleMedium18 => theme.textTheme.titleMedium!.copyWith(
        fontSize: 18.fSize,
      );

  static TextStyle get bodyLargeGray100 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.gray100,
      );

  static TextStyle get bodyLargePrimary => theme.textTheme.bodyLarge!.copyWith(
        color: theme.colorScheme.primary,
      );

  static TextStyle get bodyLargeRed400 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.red400,
      );

  static TextStyle get bodyLargeSatoshiBlack900 =>
      theme.textTheme.bodyLarge!.satoshi.copyWith(
        color: appTheme.black900,
      );

  static TextStyle get bodyLargeff000000 => theme.textTheme.bodyLarge!.copyWith(
        color: const Color(0XFF000000),
      );

  static TextStyle get bodyLargeff5486e9 => theme.textTheme.bodyLarge!.copyWith(
        color: const Color(0XFF5486E9),
      );

  static TextStyle get bodyMediumBlack900 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.black900,
        fontSize: 13.fSize,
      );

  static TextStyle get bodyMediumBlack900_1 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.black900,
      );

  // Headline text style
  static TextStyle get headlineMediumWhiteA700 =>
      theme.textTheme.headlineMedium!.copyWith(
        color: appTheme.whiteA700,
      );

  static TextStyle get headlineMediumff000000 => theme.textTheme.headlineMedium!.copyWith(
        color: const Color(0XFF000000),
      );

  static TextStyle get homeWelcome => theme.textTheme.headlineMedium!.copyWith(
        color: appTheme.whiteA700,
      );

  static TextStyle get headlineMediumff000000Regular =>
      theme.textTheme.headlineMedium!.copyWith(
        color: const Color(0XFF000000),
        fontWeight: FontWeight.w400,
      );

  // Title text style
  static TextStyle get titleLarge22 => theme.textTheme.titleLarge!.copyWith(
        fontSize: 22.fSize,
      );

  static TextStyle get titleLargeBlack900 => theme.textTheme.titleLarge!.copyWith(
        color: appTheme.black900,
        fontSize: 22.fSize,
        fontWeight: FontWeight.w700,
      );

  static TextStyle get titleLargeBlack900_1 => theme.textTheme.titleLarge!.copyWith(
        color: appTheme.black900,
      );

  static TextStyle get titleMediumPrimary => theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.primary,
      );

  static TextStyle get titleMediumPrimaryMedium => theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.primary,
        fontSize: 16.fSize,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get titleMediumWhiteA700 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.whiteA700,
        fontSize: 18.fSize,
        fontWeight: FontWeight.w700,
      );

  static TextStyle get titleSmallBlack900 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.black900,
      );

  static TextStyle get titleSmallGray700 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.gray700,
        fontSize: 14.fSize,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get titleSmallSemiBold => theme.textTheme.titleSmall!.copyWith(
        fontWeight: FontWeight.w600,
      );

  static TextStyle get titleSmallSemiBold14 => theme.textTheme.titleSmall!.copyWith(
        fontSize: 14.fSize,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get titleMediumOnPrimaryContainerMedium =>
      theme.textTheme.titleMedium!.copyWith(
        // color: theme.colorScheme.onPrimaryContainer,
        color: appTheme.whiteA700,
        fontSize: 16.fSize,
        fontWeight: FontWeight.w500,
      );
}

extension on TextStyle {
  TextStyle get satoshi {
    return copyWith(
      fontFamily: 'Satoshi',
    );
  }

  TextStyle get sFProDisplay {
    return copyWith(
      fontFamily: 'SF Pro Display',
    );
  }
}
