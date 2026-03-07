import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr')
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'MBSchool'**
  String get appTitle;

  /// Welcome message displayed on the authentication screen
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get lbl_welcome;

  /// Text for the login tab and login button
  ///
  /// In en, this message translates to:
  /// **'Log In'**
  String get lbl_log_in;

  /// Text for the registration tab and signup button
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get lbl_sign_up;

  /// Label for the email input field
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get lbl_email_address;

  /// Label for the password input field
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get lbl_password;

  /// Label for the first name input field
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get lbl_first_name;

  /// Label for the last name input field
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lbl_last_name;

  /// Link text for password recovery
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get msg_forgot_password;

  /// Legal disclaimer prefix for terms of service
  ///
  /// In en, this message translates to:
  /// **'By submitting, I agree to the'**
  String get msg_by_submitting;

  /// Hyperlink text for the terms and conditions
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get msg_terms_conditions;

  /// Error message for incorrect phone format
  ///
  /// In en, this message translates to:
  /// **'Invalid phone number'**
  String get phone_ipt_invalidNum;

  /// Placeholder for the country picker search bar
  ///
  /// In en, this message translates to:
  /// **'Search for a country'**
  String get phone_ipt_searchText;

  /// Loading message displayed during app initialization
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get lbl_loading;

  /// Text for the logout button in the user profile
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get lbl_logout;

  /// Label for the user profile section
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get lbl_profile;

  /// Label for the user's favorite courses section
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get lbl_favorites;

  /// Label for the application settings section
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get lbl_settings;

  /// Message displayed when the user has no favorite courses
  ///
  /// In en, this message translates to:
  /// **'No favorites found'**
  String get lbl_no_favorites;

  /// Title for the course details screen
  ///
  /// In en, this message translates to:
  /// **'Course Details'**
  String get lbl_course_details;

  /// Confirmation message when the user attempts to log out
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get msg_are_you_sure_you_want_to_logout;

  /// Text for the confirmation button to proceed with logout
  ///
  /// In en, this message translates to:
  /// **'Yes, Logout'**
  String get lbl_yes_logout;

  /// Text for the cancel button in the logout confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get lbl_cancel;

  /// Generic error message displayed when an unexpected error occurs
  ///
  /// In en, this message translates to:
  /// **'Oops! Something went wrong.'**
  String get lbl_oops_something_went_wrong;

  /// Message prompting the user to retry an action after an error
  ///
  /// In en, this message translates to:
  /// **'Please try again.'**
  String get lbl_please_try_again;

  /// Text for the button that allows users to retry an action after an error
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get lbl_try_again;

  /// Generic error for empty fields
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get err_field_required;

  /// Error for name regex failure
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid last name'**
  String get err_invalid_name;

  /// Error for email regex failure
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address'**
  String get err_invalid_email;

  /// Error for short password
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get err_password_short;

  /// Error message displayed when there is no internet connection
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get no_internet_connection;

  /// Generic error message for unexpected errors
  ///
  /// In en, this message translates to:
  /// **'An error occurred'**
  String get msg_error_occurred;

  /// Text for the button that allows users to skip the onboarding process
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// Title for the first onboarding screen, emphasizing accessibility of learning
  ///
  /// In en, this message translates to:
  /// **'Making Learning Accessible Everywhere'**
  String get intro_title_1;

  /// Description for the first onboarding screen, highlighting the ability to access a wide range of online courses anytime and anywhere
  ///
  /// In en, this message translates to:
  /// **'Access a vast library of online courses anytime, anywhere.'**
  String get intro_desc_1;

  /// Title for the second onboarding screen, emphasizing personalized learning experience
  ///
  /// In en, this message translates to:
  /// **'Personalized Learning for Your Needs'**
  String get intro_title_2;

  /// Description for the second onboarding screen, highlighting personalized course recommendations based on user interests and learning history
  ///
  /// In en, this message translates to:
  /// **'Receive personalized course recommendations based on your interests and learning history.'**
  String get intro_desc_2;

  /// Title for the third onboarding screen, emphasizing progress tracking and rewards
  ///
  /// In en, this message translates to:
  /// **'Progress Tracking and Rewards'**
  String get intro_title_3;

  /// Description for the third onboarding screen, highlighting the ability to track learning progress, set goals, and celebrate achievements with a progress tracking dashboard
  ///
  /// In en, this message translates to:
  /// **'Track your learning progress, set goals, and celebrate your achievements with our progress tracking dashboard.'**
  String get intro_desc_3;

  /// Text for the button that takes users to the authentication screen after onboarding
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get lbl_get_started;

  /// Welcome message displayed on the login screen for returning users
  ///
  /// In en, this message translates to:
  /// **'Welcome back!'**
  String get lbl_welcome_back;

  /// Message prompting users to log in to access the app's features
  ///
  /// In en, this message translates to:
  /// **'Please log in to continue'**
  String get msg_please_log_in_to_continue;

  /// Text prompting users to sign up if they don't have an account
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get lbl_dont_have_an_account;

  /// Text prompting users to log in if they already have an account
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get lbl_already_have_an_account;

  /// Text for the hyperlink that takes users to the registration screen
  ///
  /// In en, this message translates to:
  /// **'Sign up here'**
  String get lbl_sign_up_here;

  /// Text for the hyperlink that takes users to the login screen
  ///
  /// In en, this message translates to:
  /// **'Log in here'**
  String get lbl_log_in_here;

  /// Text prompting users to sign up if they don't have an account, used in both login and registration screens
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account yet?'**
  String get lbl_no_account_yet;

  /// Error message displayed when a user tries to register with an email or username that already exists in the system
  ///
  /// In en, this message translates to:
  /// **'Username or email already exists'**
  String get msg_username_or_email_already_exists;

  /// Success message displayed after a user successfully registers, prompting them to log in,
  ///
  /// In en, this message translates to:
  /// **'Registration successful! You can now log in.'**
  String get msg_registration_successful;

  /// Error message displayed when a user fails to log in due to incorrect credentials
  ///
  /// In en, this message translates to:
  /// **'Login failed. Please check your credentials and try again.'**
  String get msg_login_failure;

  /// Success message displayed after a user successfully logs out
  ///
  /// In en, this message translates to:
  /// **'Logout successful. See you soon!'**
  String get msg_logout_successful;

  /// Success message displayed after a user requests a password reset, indicating that an    email has been sent with instructions
  ///
  /// In en, this message translates to:
  /// **'Password reset email sent. Please check your inbox.'**
  String get msg_password_reset_email_sent;

  /// Success message displayed after a user successfully resets their password, prompting them to log in with the new password
  ///
  /// In en, this message translates to:
  /// **'Password reset successful. You can now log in with your new password'**
  String get msg_password_reset_successful;

  /// Error message displayed when a user fails to reset their password, possibly due to an invalid email or server error
  ///
  /// In en, this message translates to:
  /// **'Password reset failed. Please check your email and try again.'**
  String get msg_password_reset_failure;

  /// Error message displayed when there is a network issue preventing the user from completing an action, such as logging in or registering
  ///
  /// In en, this message translates to:
  /// **'Network error. Please check your internet connection and try again.'**
  String get msg_network_error;

  /// Generic error message displayed when an unexpected error occurs that doesn't fit other specific error categories
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred. Please try again later.'**
  String get msg_unexpected_error;

  /// Error message displayed when a user enters an incorrect email or password during login
  ///
  /// In en, this message translates to:
  /// **'Invalid email or password. Please try again.'**
  String get msg_invalid_email_or_password;

  /// Success message displayed after a user successfully creates an account, prompting them to log in
  ///
  /// In en, this message translates to:
  /// **'Account created successfully! You can now log in.'**
  String get msg_account_created_successfully;

  /// Error message displayed when a user fails to create an account, possibly due to server error or validation issues
  ///
  /// In en, this message translates to:
  /// **'Account creation failed. Please try again.'**
  String get msg_account_creation_failed;

  /// Error message displayed when a user tries to log in but their account has not been verified yet, prompting them to check their email for the verification link
  ///
  /// In en, this message translates to:
  /// **'Your account is not verified. Please check your email for the verification link.'**
  String get msg_account_not_verified;

  /// Success message displayed after a user requests a verification email, indicating that an email has been sent with instructions
  ///
  /// In en, this message translates to:
  /// **'Verification email sent. Please check your inbox.'**
  String get msg_verification_email_sent;

  /// Success message displayed after a user successfully verifies their account, prompting them to log in
  ///
  /// In en, this message translates to:
  /// **'Account verified successfully! You can now log in.'**
  String get msg_account_verified;

  /// Error message displayed when a user enters an incorrect verification code during account verification
  ///
  /// In en, this message translates to:
  /// **'Invalid verification code. Please try again.'**
  String get msg_invalid_verification_code;

  /// Error message displayed when a user tries to register with an email that already  exists in the system, prompting them to use a different email or log in if they already have an account
  ///
  /// In en, this message translates to:
  /// **'Email already exists. Please use a different email or log in.'**
  String get msg_email_already_exists;

  /// Error message displayed when there is an issue sending an email, such as during password reset or account verification, prompting the user to try again later
  ///
  /// In en, this message translates to:
  /// **'Error sending email. Please try again later.'**
  String get msg_mail_send_error;

  /// Success message displayed after a user successfully signs in, welcoming them back to the app
  ///
  /// In en, this message translates to:
  /// **'Sign in successful! Welcome back.'**
  String get msg_signin_success;

  /// Error message displayed when the first name field is left empty during registration
  ///
  /// In en, this message translates to:
  /// **'First name cannot be empty'**
  String get ipt_val_firstName_empty;

  /// Error message displayed when the last name field is left empty during registration
  ///
  /// In en, this message translates to:
  /// **'Last name cannot be empty'**
  String get ipt_val_lastName_empty;

  /// Error message displayed when the email field is left empty during registration or login
  ///
  /// In en, this message translates to:
  /// **'Email cannot be empty'**
  String get ipt_val_email_empty;

  /// Error message displayed when the password field is left empty during registration or login
  ///
  /// In en, this message translates to:
  /// **'Password cannot be empty'**
  String get ipt_val_password_empty;

  /// Error message displayed when the email entered does not match a valid email format during registration or login
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address'**
  String get ipt_val_email_invalid;

  /// Error message displayed when the password entered does not meet the strength requirements during registration
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters, include an uppercase letter, a lowercase letter, a number, and a special character'**
  String get ipt_val_password_strong;

  /// Error message displayed when the last name entered is shorter than 2 characters during registration
  ///
  /// In en, this message translates to:
  /// **'Last name must be at least 2 characters'**
  String get ipt_val_lastName_min_length;

  /// Error message displayed when the first name entered is shorter than 2 characters          during registration
  ///
  /// In en, this message translates to:
  /// **'First name must be at least 2 characters'**
  String get ipt_val_firstName_min_length;

  /// Error message displayed when the last name entered exceeds 50 characters during registration
  ///
  /// In en, this message translates to:
  /// **'Last name cannot exceed 50 characters'**
  String get ipt_val_lastName_max_length;

  /// Error message displayed when the first name entered exceeds 50 characters during registration
  ///
  /// In en, this message translates to:
  /// **'First name cannot exceed 50 characters'**
  String get ipt_val_firstName_max_length;

  /// Error message displayed when a user's session has expired, prompting them to log in again to continue using the app
  ///
  /// In en, this message translates to:
  /// **'Your session has expired. Please log in again to continue.'**
  String get msg_session_expired;

  /// Welcome message displayed on the home screen after a successful login
  ///
  /// In en, this message translates to:
  /// **'Welcome to MBSchool!'**
  String get lbl_welcome_to_mbschool;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
