import 'package:flutter/material.dart';
import 'package:mbschool/core/l10n/app_localizations.dart';
import 'package:mbschool/core/presentation/widgets/custom_elevated_button.dart';
import 'package:mbschool/core/theme/custom_button_style.dart';
import 'package:mbschool/core/theme/theme_helper.dart';
import 'package:mbschool/core/utils/image_constant.dart';
import 'package:mbschool/core/utils/size_utils.dart';

class CustomError404 extends StatelessWidget {
  const CustomError404({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    var appLocalization = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          ImageConstant.error404,
          width: 300.h,
        ),
        Text(
          appLocalization!.lbl_oops_something_went_wrong,
          style: theme.textTheme.titleLarge!.copyWith(color: Colors.black),
        ),
        SizedBox(height: 17.v),
        Text(
          appLocalization.lbl_please_try_again,
          style: theme.textTheme.bodySmall!.copyWith(color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 17.v),
        CustomElevatedButton(
          buttonStyle: CustomButtonStyles.fillPrimary,
          text: appLocalization.lbl_try_again,
          onPressed: onPressed,
        )
      ],
    );
  }
}
