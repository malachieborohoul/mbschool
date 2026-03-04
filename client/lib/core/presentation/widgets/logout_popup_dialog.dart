import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbschool/core/l10n/app_localizations.dart';
import 'package:mbschool/core/presentation/widgets/custom_elevated_button.dart';
import 'package:mbschool/core/presentation/widgets/custom_image_view.dart';
import 'package:mbschool/core/theme/app_decoration.dart';
import 'package:mbschool/core/theme/custom_text_style.dart';
import 'package:mbschool/core/theme/theme_helper.dart';
import 'package:mbschool/core/utils/image_constant.dart';
import 'package:mbschool/core/utils/loader_dialog.dart';
import 'package:mbschool/core/utils/pref_utils.dart';
import 'package:mbschool/core/utils/show_snackbar.dart';
import 'package:mbschool/core/utils/size_utils.dart';
import 'package:flutter/material.dart';

import 'package:mbschool/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mbschool/features/auth/presentation/screens/loading_screen.dart';


class LogoutPopupDialog extends StatelessWidget {
  const LogoutPopupDialog({super.key});

  @override
  Widget build(BuildContext context) {
    var appLocalization = AppLocalizations.of(context);

    return _buildPopup(appLocalization, context);
  }

  /// Section Widget
  Widget _buildPopup(AppLocalizations? appLocalization, BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
                showLoaderDialog(context);
              }else{
                closeLoaderDialog(context);
                if (state is AuthFailure ) {
                  showSnackBar(context, state.message);
                } else if(state is AuthSignOutSuccess){
                  Navigator.pushReplacement(context, LoadingScreen.route());
                }
              }
      },
      builder: (context, state) {
        return Card(
          clipBehavior: Clip.antiAlias,
          elevation: 0,
          margin: const EdgeInsets.all(0),
          color: appTheme.whiteA700,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusStyle.roundedBorder12),
          child: Container(
            height: 218.v,
            width: 388.h,
            padding: EdgeInsets.all(16.h),
            decoration: AppDecoration.fillWhiteA
                .copyWith(borderRadius: BorderRadiusStyle.roundedBorder12),
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.h),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(appLocalization!.lbl_logout,
                            style: CustomTextStyles.titleLargeBlack900),
                        SizedBox(height: 8.v),
                        Text(appLocalization.msg_are_you_sure_you_want_to_logout,
                            style: theme.textTheme.bodyLarge),
                        SizedBox(height: 38.v),
                        CustomElevatedButton(
                          text: appLocalization.lbl_yes_logout,
                          onPressed: () {
                            PrefUtils.setLogin(true);
                            context.read<AuthBloc>().add(AuthSignOut(context: context));

                            // customBottomBarController.getIndex(0);
                            // Navigator.pushReplacement(context, LoginScreen.route());
                          },
                        )
                      ],
                    ),
                  ),
                ),
                CustomImageView(
                  imagePath: ImageConstant.imgCloseFill0Wgh,
                  height: 24.adaptSize,
                  width: 24.adaptSize,
                  alignment: Alignment.topRight,
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
