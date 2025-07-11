import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

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
    Locale('es')
  ];

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get language;

  /// No description provided for @general.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get general;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @greeting.
  ///
  /// In en, this message translates to:
  /// **'Hello {name}!'**
  String greeting(Object name);

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error!'**
  String get error;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @notFoundItem.
  ///
  /// In en, this message translates to:
  /// **'No items found!'**
  String get notFoundItem;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @open.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get open;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @notUser.
  ///
  /// In en, this message translates to:
  /// **'No user'**
  String get notUser;

  /// No description provided for @endList.
  ///
  /// In en, this message translates to:
  /// **'You\'ve reached the end of the list.'**
  String get endList;

  /// No description provided for @maintenanceApp.
  ///
  /// In en, this message translates to:
  /// **'App under maintenance'**
  String get maintenanceApp;

  /// No description provided for @errorApp.
  ///
  /// In en, this message translates to:
  /// **'Could not check for a new version. Please ensure you have an internet connection and try again.'**
  String get errorApp;

  /// No description provided for @newVersionAvailable.
  ///
  /// In en, this message translates to:
  /// **'New version available'**
  String get newVersionAvailable;

  /// No description provided for @updateNow.
  ///
  /// In en, this message translates to:
  /// **'Update now!'**
  String get updateNow;

  /// No description provided for @updateMessage.
  ///
  /// In en, this message translates to:
  /// **'Update available! Tap to download the latest version for the best experience.'**
  String get updateMessage;

  /// No description provided for @accountDetails.
  ///
  /// In en, this message translates to:
  /// **'Account details'**
  String get accountDetails;

  /// No description provided for @comingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming soon...'**
  String get comingSoon;

  /// No description provided for @signInAccount.
  ///
  /// In en, this message translates to:
  /// **'Sign in to your account'**
  String get signInAccount;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Log In'**
  String get login;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get logout;

  /// No description provided for @notHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get notHaveAccount;

  /// No description provided for @createOneHere.
  ///
  /// In en, this message translates to:
  /// **'Create one here'**
  String get createOneHere;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @forgetPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot your password?'**
  String get forgetPassword;

  /// No description provided for @recoveryPassword.
  ///
  /// In en, this message translates to:
  /// **'Recover password'**
  String get recoveryPassword;

  /// No description provided for @signInFailed.
  ///
  /// In en, this message translates to:
  /// **'Sign‑in failed'**
  String get signInFailed;

  /// No description provided for @confirmEmail.
  ///
  /// In en, this message translates to:
  /// **'Confirm Email'**
  String get confirmEmail;

  /// No description provided for @confirmEmailMsg.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email to verify it and continue the password reset process'**
  String get confirmEmailMsg;

  /// No description provided for @passwordUpdate.
  ///
  /// In en, this message translates to:
  /// **'Password updated successfully'**
  String get passwordUpdate;

  /// No description provided for @signInWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Google'**
  String get signInWithGoogle;

  /// No description provided for @signInWithApple.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Apple ID'**
  String get signInWithApple;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email address'**
  String get emailAddress;

  /// No description provided for @acceptBtn.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get acceptBtn;

  /// No description provided for @cancelBtn.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelBtn;

  /// No description provided for @itsEmpty.
  ///
  /// In en, this message translates to:
  /// **'Oops! It\'s empty'**
  String get itsEmpty;

  /// No description provided for @notFoundTitle.
  ///
  /// In en, this message translates to:
  /// **'Not found'**
  String get notFoundTitle;

  /// No description provided for @notFoundInfo.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t find what you were looking for'**
  String get notFoundInfo;

  /// No description provided for @registerSuccess.
  ///
  /// In en, this message translates to:
  /// **'Registration successful'**
  String get registerSuccess;

  /// No description provided for @registerError.
  ///
  /// In en, this message translates to:
  /// **'An error occurred during registration'**
  String get registerError;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @reportBug.
  ///
  /// In en, this message translates to:
  /// **'Report a bug'**
  String get reportBug;

  /// No description provided for @sendFeedback.
  ///
  /// In en, this message translates to:
  /// **'Send feedback'**
  String get sendFeedback;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete account'**
  String get deleteAccount;

  /// No description provided for @feedback.
  ///
  /// In en, this message translates to:
  /// **'Feedback'**
  String get feedback;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @darkTheme.
  ///
  /// In en, this message translates to:
  /// **'Dark theme'**
  String get darkTheme;

  /// No description provided for @permission.
  ///
  /// In en, this message translates to:
  /// **'Permissions'**
  String get permission;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @connectionTimeOut.
  ///
  /// In en, this message translates to:
  /// **'The connection request timed out.'**
  String get connectionTimeOut;

  /// No description provided for @sendTimeOut.
  ///
  /// In en, this message translates to:
  /// **'The connection request timed out.'**
  String get sendTimeOut;

  /// No description provided for @receiveTimeOut.
  ///
  /// In en, this message translates to:
  /// **'The connection was interrupted, please try again.'**
  String get receiveTimeOut;

  /// No description provided for @connectionError.
  ///
  /// In en, this message translates to:
  /// **'Connection error.'**
  String get connectionError;

  /// No description provided for @badCertificate.
  ///
  /// In en, this message translates to:
  /// **'Bad certificate'**
  String get badCertificate;

  /// No description provided for @badResponse.
  ///
  /// In en, this message translates to:
  /// **'Received a non‑standard status code, possibly due to server software.'**
  String get badResponse;

  /// No description provided for @unknown.
  ///
  /// In en, this message translates to:
  /// **'An unknown error occurred while processing the request.'**
  String get unknown;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'The request was manually cancelled by the user.'**
  String get cancel;

  /// No description provided for @notInternet.
  ///
  /// In en, this message translates to:
  /// **'No internet connection detected, please try again.'**
  String get notInternet;

  /// No description provided for @imageNotFound.
  ///
  /// In en, this message translates to:
  /// **'Image not found'**
  String get imageNotFound;

  /// No description provided for @errorGetImage.
  ///
  /// In en, this message translates to:
  /// **'Error retrieving the image.'**
  String get errorGetImage;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @isRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get isRequired;

  /// No description provided for @isEmpty.
  ///
  /// In en, this message translates to:
  /// **'Please fill out the field'**
  String get isEmpty;

  /// No description provided for @isEmptyList.
  ///
  /// In en, this message translates to:
  /// **'Please select at least one item'**
  String get isEmptyList;

  /// No description provided for @isEmptySelect.
  ///
  /// In en, this message translates to:
  /// **'Please select an option'**
  String get isEmptySelect;

  /// No description provided for @isEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get isEmail;

  /// No description provided for @isNotEqual.
  ///
  /// In en, this message translates to:
  /// **'Values do not match'**
  String get isNotEqual;

  /// No description provided for @isNotEqualPassword.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get isNotEqualPassword;

  /// No description provided for @isPasswordLength.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters long'**
  String get isPasswordLength;

  /// No description provided for @isInvalidPasswordPattern.
  ///
  /// In en, this message translates to:
  /// **'Password must be 6–20 characters with uppercase, lowercase, and a number.'**
  String get isInvalidPasswordPattern;

  /// No description provided for @fullnameLabel.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get fullnameLabel;

  /// No description provided for @fullnameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your full name'**
  String get fullnameHint;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// No description provided for @emailHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get emailHint;

  /// No description provided for @passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// No description provided for @passwordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get passwordHint;

  /// No description provided for @confirmPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPasswordLabel;

  /// No description provided for @confirmPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Re-enter your password'**
  String get confirmPasswordHint;

  /// No description provided for @selectAnOption.
  ///
  /// In en, this message translates to:
  /// **'Select an option'**
  String get selectAnOption;

  /// No description provided for @selectAnOptionDisabled.
  ///
  /// In en, this message translates to:
  /// **'Selecting an option is disabled'**
  String get selectAnOptionDisabled;

  /// No description provided for @networkRequestFailed.
  ///
  /// In en, this message translates to:
  /// **'Network request failed. Check your internet connection.'**
  String get networkRequestFailed;

  /// No description provided for @errorNetworkRequestFailed.
  ///
  /// In en, this message translates to:
  /// **'Network request failed. Check your internet connection.'**
  String get errorNetworkRequestFailed;

  /// No description provided for @tooManyRequests.
  ///
  /// In en, this message translates to:
  /// **'Too many requests. Please try again later.'**
  String get tooManyRequests;

  /// No description provided for @errorTooManyRequests.
  ///
  /// In en, this message translates to:
  /// **'Too many requests. Please try again later.'**
  String get errorTooManyRequests;

  /// No description provided for @userDisabled.
  ///
  /// In en, this message translates to:
  /// **'This user account has been disabled.'**
  String get userDisabled;

  /// No description provided for @errorUserDisabled.
  ///
  /// In en, this message translates to:
  /// **'This user account has been disabled.'**
  String get errorUserDisabled;

  /// No description provided for @operationNotAllowed.
  ///
  /// In en, this message translates to:
  /// **'This operation is not allowed. Check your auth provider settings.'**
  String get operationNotAllowed;

  /// No description provided for @errorOperationNotAllowed.
  ///
  /// In en, this message translates to:
  /// **'This operation is not allowed. Check your auth provider settings.'**
  String get errorOperationNotAllowed;

  /// No description provided for @internalError.
  ///
  /// In en, this message translates to:
  /// **'An unexpected internal error occurred. Please try again later.'**
  String get internalError;

  /// No description provided for @errorInternalError.
  ///
  /// In en, this message translates to:
  /// **'An unexpected internal error occurred. Please try again later.'**
  String get errorInternalError;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Invalid email format.'**
  String get invalidEmail;

  /// No description provided for @errorInvalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Invalid email format.'**
  String get errorInvalidEmail;

  /// No description provided for @userNotFound.
  ///
  /// In en, this message translates to:
  /// **'No user found with this email.'**
  String get userNotFound;

  /// No description provided for @errorUserNotFound.
  ///
  /// In en, this message translates to:
  /// **'No user found with this email.'**
  String get errorUserNotFound;

  /// No description provided for @wrongPassword.
  ///
  /// In en, this message translates to:
  /// **'Incorrect password.'**
  String get wrongPassword;

  /// No description provided for @errorWrongPassword.
  ///
  /// In en, this message translates to:
  /// **'Incorrect password.'**
  String get errorWrongPassword;

  /// No description provided for @invalidCredential.
  ///
  /// In en, this message translates to:
  /// **'Invalid credentials. Check your email and password.'**
  String get invalidCredential;

  /// No description provided for @errorInvalidCredential.
  ///
  /// In en, this message translates to:
  /// **'Invalid credentials. Check your email and password.'**
  String get errorInvalidCredential;

  /// No description provided for @accountExistsWithDifferentCredential.
  ///
  /// In en, this message translates to:
  /// **'An account already exists with this email using a different sign‑in method (e.g., Google, Facebook).'**
  String get accountExistsWithDifferentCredential;

  /// No description provided for @errorAccountExistsWithDifferentCredential.
  ///
  /// In en, this message translates to:
  /// **'An account already exists with this email using a different sign‑in method.'**
  String get errorAccountExistsWithDifferentCredential;

  /// No description provided for @multiFactorAuthRequired.
  ///
  /// In en, this message translates to:
  /// **'Multi‑factor authentication is required to complete this operation.'**
  String get multiFactorAuthRequired;

  /// No description provided for @errorMultiFactorAuthRequired.
  ///
  /// In en, this message translates to:
  /// **'Multi‑factor authentication is required to complete this operation.'**
  String get errorMultiFactorAuthRequired;

  /// No description provided for @emailAlreadyInUse.
  ///
  /// In en, this message translates to:
  /// **'This email is already registered.'**
  String get emailAlreadyInUse;

  /// No description provided for @errorEmailAlreadyInUse.
  ///
  /// In en, this message translates to:
  /// **'This email is already registered.'**
  String get errorEmailAlreadyInUse;

  /// No description provided for @weakPassword.
  ///
  /// In en, this message translates to:
  /// **'Password is too weak (must be at least 6 characters).'**
  String get weakPassword;

  /// No description provided for @errorWeakPassword.
  ///
  /// In en, this message translates to:
  /// **'Password is too weak (must be at least 6 characters).'**
  String get errorWeakPassword;

  /// No description provided for @requiresRecentLogin.
  ///
  /// In en, this message translates to:
  /// **'This action requires a recent login. Please re‑authenticate.'**
  String get requiresRecentLogin;

  /// No description provided for @errorRequiresRecentLogin.
  ///
  /// In en, this message translates to:
  /// **'This action requires a recent login. Please re‑authenticate.'**
  String get errorRequiresRecentLogin;

  /// No description provided for @errorTimeout.
  ///
  /// In en, this message translates to:
  /// **'The operation timed out.'**
  String get errorTimeout;

  /// No description provided for @errorUserTokenExpired.
  ///
  /// In en, this message translates to:
  /// **'Your session has expired. Please log in again.'**
  String get errorUserTokenExpired;

  /// No description provided for @errorInvalidUserToken.
  ///
  /// In en, this message translates to:
  /// **'Your session is invalid. Please log in again.'**
  String get errorInvalidUserToken;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @recommendationsForYou.
  ///
  /// In en, this message translates to:
  /// **'Recommendations for you'**
  String get recommendationsForYou;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @favorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  /// No description provided for @noSuggestions.
  ///
  /// In en, this message translates to:
  /// **'No suggestions...'**
  String get noSuggestions;

  /// No description provided for @detail.
  ///
  /// In en, this message translates to:
  /// **'Detail'**
  String get detail;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get tryAgain;
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
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
