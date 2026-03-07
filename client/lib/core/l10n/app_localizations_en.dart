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

  @override
  String get err_field_required => 'This field is required';

  @override
  String get err_invalid_name => 'Please enter a valid last name';

  @override
  String get err_invalid_email => 'Please enter a valid email address';

  @override
  String get err_password_short => 'Password must be at least 8 characters';

  @override
  String get no_internet_connection => 'No internet connection';

  @override
  String get msg_error_occurred => 'An error occurred';

  @override
  String get skip => 'Skip';

  @override
  String get intro_title_1 => 'Making Learning Accessible Everywhere';

  @override
  String get intro_desc_1 =>
      'Access a vast library of online courses anytime, anywhere.';

  @override
  String get intro_title_2 => 'Personalized Learning for Your Needs';

  @override
  String get intro_desc_2 =>
      'Receive personalized course recommendations based on your interests and learning history.';

  @override
  String get intro_title_3 => 'Progress Tracking and Rewards';

  @override
  String get intro_desc_3 =>
      'Track your learning progress, set goals, and celebrate your achievements with our progress tracking dashboard.';

  @override
  String get lbl_get_started => 'Get Started';

  @override
  String get lbl_welcome_back => 'Welcome back!';

  @override
  String get msg_please_log_in_to_continue => 'Please log in to continue';

  @override
  String get lbl_dont_have_an_account => 'Don\'t have an account?';

  @override
  String get lbl_already_have_an_account => 'Already have an account?';

  @override
  String get lbl_sign_up_here => 'Sign up here';

  @override
  String get lbl_log_in_here => 'Log in here';

  @override
  String get lbl_no_account_yet => 'Don\'t have an account yet?';

  @override
  String get msg_username_or_email_already_exists =>
      'Username or email already exists';

  @override
  String get msg_registration_successful =>
      'Registration successful! You can now log in.';

  @override
  String get msg_login_failure =>
      'Login failed. Please check your credentials and try again.';

  @override
  String get msg_logout_successful => 'Logout successful. See you soon!';

  @override
  String get msg_password_reset_email_sent =>
      'Password reset email sent. Please check your inbox.';

  @override
  String get msg_password_reset_successful =>
      'Password reset successful. You can now log in with your new password';

  @override
  String get msg_password_reset_failure =>
      'Password reset failed. Please check your email and try again.';

  @override
  String get msg_network_error =>
      'Network error. Please check your internet connection and try again.';

  @override
  String get msg_unexpected_error =>
      'An unexpected error occurred. Please try again later.';

  @override
  String get msg_invalid_email_or_password =>
      'Invalid email or password. Please try again.';

  @override
  String get msg_account_created_successfully =>
      'Account created successfully! You can now log in.';

  @override
  String get msg_account_creation_failed =>
      'Account creation failed. Please try again.';

  @override
  String get msg_account_not_verified =>
      'Your account is not verified. Please check your email for the verification link.';

  @override
  String get msg_verification_email_sent =>
      'Verification email sent. Please check your inbox.';

  @override
  String get msg_account_verified =>
      'Account verified successfully! You can now log in.';

  @override
  String get msg_invalid_verification_code =>
      'Invalid verification code. Please try again.';

  @override
  String get msg_email_already_exists =>
      'Email already exists. Please use a different email or log in.';

  @override
  String get msg_mail_send_error =>
      'Error sending email. Please try again later.';

  @override
  String get msg_signin_success => 'Sign in successful! Welcome back.';

  @override
  String get ipt_val_firstName_empty => 'First name cannot be empty';

  @override
  String get ipt_val_lastName_empty => 'Last name cannot be empty';

  @override
  String get ipt_val_email_empty => 'Email cannot be empty';

  @override
  String get ipt_val_password_empty => 'Password cannot be empty';

  @override
  String get ipt_val_email_invalid => 'Please enter a valid email address';

  @override
  String get ipt_val_password_strong =>
      'Password must be at least 8 characters, include an uppercase letter, a lowercase letter, a number, and a special character';

  @override
  String get ipt_val_lastName_min_length =>
      'Last name must be at least 2 characters';

  @override
  String get ipt_val_firstName_min_length =>
      'First name must be at least 2 characters';

  @override
  String get ipt_val_lastName_max_length =>
      'Last name cannot exceed 50 characters';

  @override
  String get ipt_val_firstName_max_length =>
      'First name cannot exceed 50 characters';

  @override
  String get msg_session_expired =>
      'Your session has expired. Please log in again to continue.';

  @override
  String get lbl_welcome_to_mbschool => 'Welcome to MBSchool!';
}
