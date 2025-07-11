// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get language => 'English';

  @override
  String get general => 'General';

  @override
  String get name => 'Name';

  @override
  String get email => 'Email';

  @override
  String get home => 'Home';

  @override
  String greeting(Object name) {
    return 'Hello $name!';
  }

  @override
  String get error => 'Error!';

  @override
  String get loading => 'Loading...';

  @override
  String get notFoundItem => 'No items found!';

  @override
  String get save => 'Save';

  @override
  String get update => 'Update';

  @override
  String get delete => 'Delete';

  @override
  String get close => 'Close';

  @override
  String get open => 'Open';

  @override
  String get edit => 'Edit';

  @override
  String get notUser => 'No user';

  @override
  String get endList => 'You\'ve reached the end of the list.';

  @override
  String get maintenanceApp => 'App under maintenance';

  @override
  String get errorApp =>
      'Could not check for a new version. Please ensure you have an internet connection and try again.';

  @override
  String get newVersionAvailable => 'New version available';

  @override
  String get updateNow => 'Update now!';

  @override
  String get updateMessage =>
      'Update available! Tap to download the latest version for the best experience.';

  @override
  String get accountDetails => 'Account details';

  @override
  String get comingSoon => 'Coming soon...';

  @override
  String get signInAccount => 'Sign in to your account';

  @override
  String get login => 'Log In';

  @override
  String get signUp => 'Sign Up';

  @override
  String get logout => 'Log Out';

  @override
  String get notHaveAccount => 'Don\'t have an account?';

  @override
  String get createOneHere => 'Create one here';

  @override
  String get password => 'Password';

  @override
  String get newPassword => 'New Password';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get forgetPassword => 'Forgot your password?';

  @override
  String get recoveryPassword => 'Recover password';

  @override
  String get signInFailed => 'Sign‑in failed';

  @override
  String get confirmEmail => 'Confirm Email';

  @override
  String get confirmEmailMsg =>
      'Please enter your email to verify it and continue the password reset process';

  @override
  String get passwordUpdate => 'Password updated successfully';

  @override
  String get signInWithGoogle => 'Sign in with Google';

  @override
  String get signInWithApple => 'Sign in with Apple ID';

  @override
  String get emailAddress => 'Email address';

  @override
  String get acceptBtn => 'Accept';

  @override
  String get cancelBtn => 'Cancel';

  @override
  String get itsEmpty => 'Oops! It\'s empty';

  @override
  String get notFoundTitle => 'Not found';

  @override
  String get notFoundInfo => 'We couldn\'t find what you were looking for';

  @override
  String get registerSuccess => 'Registration successful';

  @override
  String get registerError => 'An error occurred during registration';

  @override
  String get profile => 'Profile';

  @override
  String get settings => 'Settings';

  @override
  String get reportBug => 'Report a bug';

  @override
  String get sendFeedback => 'Send feedback';

  @override
  String get account => 'Account';

  @override
  String get deleteAccount => 'Delete account';

  @override
  String get feedback => 'Feedback';

  @override
  String get theme => 'Theme';

  @override
  String get darkTheme => 'Dark theme';

  @override
  String get permission => 'Permissions';

  @override
  String get notifications => 'Notifications';

  @override
  String get connectionTimeOut => 'The connection request timed out.';

  @override
  String get sendTimeOut => 'The connection request timed out.';

  @override
  String get receiveTimeOut =>
      'The connection was interrupted, please try again.';

  @override
  String get connectionError => 'Connection error.';

  @override
  String get badCertificate => 'Bad certificate';

  @override
  String get badResponse =>
      'Received a non‑standard status code, possibly due to server software.';

  @override
  String get unknown =>
      'An unknown error occurred while processing the request.';

  @override
  String get cancel => 'The request was manually cancelled by the user.';

  @override
  String get notInternet =>
      'No internet connection detected, please try again.';

  @override
  String get imageNotFound => 'Image not found';

  @override
  String get errorGetImage => 'Error retrieving the image.';

  @override
  String get skip => 'Skip';

  @override
  String get done => 'Done';

  @override
  String get back => 'Back';

  @override
  String get next => 'Next';

  @override
  String get isRequired => 'This field is required';

  @override
  String get isEmpty => 'Please fill out the field';

  @override
  String get isEmptyList => 'Please select at least one item';

  @override
  String get isEmptySelect => 'Please select an option';

  @override
  String get isEmail => 'Please enter a valid email';

  @override
  String get isNotEqual => 'Values do not match';

  @override
  String get isNotEqualPassword => 'Passwords do not match';

  @override
  String get isPasswordLength => 'Password must be at least 6 characters long';

  @override
  String get isInvalidPasswordPattern =>
      'Password must be 6–20 characters with uppercase, lowercase, and a number.';

  @override
  String get fullnameLabel => 'Full name';

  @override
  String get fullnameHint => 'Enter your full name';

  @override
  String get emailLabel => 'Email';

  @override
  String get emailHint => 'Enter your email';

  @override
  String get passwordLabel => 'Password';

  @override
  String get passwordHint => 'Enter your password';

  @override
  String get confirmPasswordLabel => 'Confirm Password';

  @override
  String get confirmPasswordHint => 'Re-enter your password';

  @override
  String get selectAnOption => 'Select an option';

  @override
  String get selectAnOptionDisabled => 'Selecting an option is disabled';

  @override
  String get networkRequestFailed =>
      'Network request failed. Check your internet connection.';

  @override
  String get errorNetworkRequestFailed =>
      'Network request failed. Check your internet connection.';

  @override
  String get tooManyRequests => 'Too many requests. Please try again later.';

  @override
  String get errorTooManyRequests =>
      'Too many requests. Please try again later.';

  @override
  String get userDisabled => 'This user account has been disabled.';

  @override
  String get errorUserDisabled => 'This user account has been disabled.';

  @override
  String get operationNotAllowed =>
      'This operation is not allowed. Check your auth provider settings.';

  @override
  String get errorOperationNotAllowed =>
      'This operation is not allowed. Check your auth provider settings.';

  @override
  String get internalError =>
      'An unexpected internal error occurred. Please try again later.';

  @override
  String get errorInternalError =>
      'An unexpected internal error occurred. Please try again later.';

  @override
  String get invalidEmail => 'Invalid email format.';

  @override
  String get errorInvalidEmail => 'Invalid email format.';

  @override
  String get userNotFound => 'No user found with this email.';

  @override
  String get errorUserNotFound => 'No user found with this email.';

  @override
  String get wrongPassword => 'Incorrect password.';

  @override
  String get errorWrongPassword => 'Incorrect password.';

  @override
  String get invalidCredential =>
      'Invalid credentials. Check your email and password.';

  @override
  String get errorInvalidCredential =>
      'Invalid credentials. Check your email and password.';

  @override
  String get accountExistsWithDifferentCredential =>
      'An account already exists with this email using a different sign‑in method (e.g., Google, Facebook).';

  @override
  String get errorAccountExistsWithDifferentCredential =>
      'An account already exists with this email using a different sign‑in method.';

  @override
  String get multiFactorAuthRequired =>
      'Multi‑factor authentication is required to complete this operation.';

  @override
  String get errorMultiFactorAuthRequired =>
      'Multi‑factor authentication is required to complete this operation.';

  @override
  String get emailAlreadyInUse => 'This email is already registered.';

  @override
  String get errorEmailAlreadyInUse => 'This email is already registered.';

  @override
  String get weakPassword =>
      'Password is too weak (must be at least 6 characters).';

  @override
  String get errorWeakPassword =>
      'Password is too weak (must be at least 6 characters).';

  @override
  String get requiresRecentLogin =>
      'This action requires a recent login. Please re‑authenticate.';

  @override
  String get errorRequiresRecentLogin =>
      'This action requires a recent login. Please re‑authenticate.';

  @override
  String get errorTimeout => 'The operation timed out.';

  @override
  String get errorUserTokenExpired =>
      'Your session has expired. Please log in again.';

  @override
  String get errorInvalidUserToken =>
      'Your session is invalid. Please log in again.';

  @override
  String get search => 'Search';

  @override
  String get recommendationsForYou => 'Recommendations for you';

  @override
  String get editProfile => 'Edit Profile';

  @override
  String get favorites => 'Favorites';

  @override
  String get noSuggestions => 'No suggestions...';

  @override
  String get detail => 'Detail';

  @override
  String get about => 'About';

  @override
  String get version => 'Version';

  @override
  String get tryAgain => 'Try again';
}
