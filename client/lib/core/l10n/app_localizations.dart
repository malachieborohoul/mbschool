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
