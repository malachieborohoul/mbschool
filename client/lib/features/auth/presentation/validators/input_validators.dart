

import 'package:mbschool/core/l10n/app_localizations.dart';

class InputValidators {
  static String? firstNameValidator(String? value, AppLocalizations appLocalization) {
  if (value == null || value.isEmpty) {
    return appLocalization.ipt_val_firstName_empty;
  }
  if (value.length < 2) {
        return appLocalization.ipt_val_firstName_min_length;

  }
  if (value.length > 50) {
            return appLocalization.ipt_val_firstName_max_length;

  }
  // if (!RegExp(r"^[A-Za-zÀ-ÖØ-öø-ÿ]+(?:[-' ][A-Za-zÀ-ÖØ-öø-ÿ]+)*$").hasMatch(value)) {
  //           return appLocalization.ipt_val_firstName;

  // }
  return null;
}

  static String? lastNameValidator(String? value, AppLocalizations appLocalization) {
  if (value == null || value.isEmpty) {
    return appLocalization.ipt_val_lastName_empty;
  }
  if (value.length < 2) {
        return appLocalization.ipt_val_lastName_min_length;

  }
  if (value.length > 50) {
            return appLocalization.ipt_val_lastName_max_length;

  }
  // if (!RegExp(r"^[A-Za-zÀ-ÖØ-öø-ÿ]+(?:[-' ][A-Za-zÀ-ÖØ-öø-ÿ]+)*$").hasMatch(value)) {
  //           return appLocalization.ipt_val_firstName;

  // }
  return null;
}
static String? emailValidator(String? value, AppLocalizations appLocalization) {
  if (value == null || value.isEmpty) {
    return appLocalization.ipt_val_email_empty;
  }
  // Regex amélioré pour un email plus solide
  if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value)) {
        return appLocalization.ipt_val_email_invalid;

  }
  return null;
}

static String? emailValidatorLogin(String? value, AppLocalizations appLocalization) {
  if (value == null || value.isEmpty) {
    return appLocalization.ipt_val_email_empty;
  }
  // Regex amélioré pour un email plus solide
  if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value)) {
        return appLocalization.ipt_val_email_invalid;

  }
  return null;
}
static String? passwordValidator(String? value, AppLocalizations appLocalization) {
  if (value == null || value.isEmpty) {
        return appLocalization.ipt_val_password_empty;

  }
  if (!RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&#])[A-Za-z\d@$!%*?&#]{8,}$").hasMatch(value)) {
            return appLocalization.ipt_val_password_strong;

  }
  return null;
}
static String? passwordValidatorLogin(String? value, AppLocalizations appLocalization) {
  if (value == null || value.isEmpty) {
        return appLocalization.ipt_val_password_empty;

  }
  
  return null;
}


// static String? otpValidator(String? value, AppLocalizations appLocalization) {
//   if (value == null || value.isEmpty || value.length < 6) {
//         return appLocalization.ipt_val_otp_empty;

//   }
  
//   return null;
// }
}
