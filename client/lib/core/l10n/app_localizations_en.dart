// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'MBSchool';

  @override
  String get lbl_welcome => 'Welcome';

  @override
  String get lbl_log_in => 'Log In';

  @override
  String get lbl_sign_up => 'Sign Up';

  @override
  String get lbl_email_address => 'Email Address';

  @override
  String get lbl_password => 'Password';

  @override
  String get lbl_first_name => 'First Name';

  @override
  String get lbl_last_name => 'Last Name';

  @override
  String get msg_forgot_password => 'Forgot Password?';

  @override
  String get msg_by_submitting => 'By submitting, I agree to the';

  @override
  String get msg_terms_conditions => 'Terms & Conditions';

  @override
  String get phone_ipt_invalidNum => 'Invalid phone number';

  @override
  String get phone_ipt_searchText => 'Search for a country';

  @override
  String get lbl_loading => 'Loading...';

  @override
  String get lbl_logout => 'Logout';

  @override
  String get lbl_profile => 'Profile';

  @override
  String get lbl_favorites => 'Favorites';

  @override
  String get lbl_settings => 'Settings';

  @override
  String get lbl_no_favorites => 'No favorites found';

  @override
  String get lbl_course_details => 'Course Details';

  @override
  String get msg_are_you_sure_you_want_to_logout =>
      'Are you sure you want to logout?';

  @override
  String get lbl_yes_logout => 'Yes, Logout';

  @override
  String get lbl_cancel => 'Cancel';

  @override
  String get lbl_oops_something_went_wrong => 'Oops! Something went wrong.';

  @override
  String get lbl_please_try_again => 'Please try again.';

  @override
  String get lbl_try_again => 'Try Again';
}
