import 'package:flutter/material.dart';
import 'package:mbschool/core/l10n/app_localizations.dart';
import 'package:mbschool/core/theme/theme_helper.dart';
import 'package:mbschool/core/utils/size_utils.dart';


class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    var appLocalization = AppLocalizations.of(context);

    return  Center(
      
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          
          CircularProgressIndicator(color: ColorSchemes.primaryColorScheme.primary,),
              SizedBox(height: 42.v),

          Text(appLocalization!.lbl_loading,
                      style: theme.textTheme.bodyLarge)

        ],
      ),
    );
  }
}