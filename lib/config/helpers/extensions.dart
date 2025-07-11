import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/config/config.dart';

extension L10nX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}

extension AppLocalizationsX on AppLocalizations {
  String? getByKey(String? key) {
    final map = <String, String>{
      'is_required': isRequired,
      'is_email': isEmail,
      'is_password_length': isPasswordLength,
      'is_invalid_password_pattern': isInvalidPasswordPattern,
      'is_not_equal_password': isNotEqualPassword,
      'is_empty': isEmpty,
      'is_empty_list': isEmptyList,
      'is_empty_select': isEmptySelect,
      'is_not_equal': isNotEqual,
      'connection_time_out': connectionTimeOut,
      'invalid-credential': invalidCredential,
      'email-already-in-use': emailAlreadyInUse,
      'wrong-password': wrongPassword,
      'invalid-email': invalidEmail,
      'weak-password': weakPassword,
    };
    return map[key] ?? key;
  }
}

extension GetLocale on BuildContext {
  String currentLocale() {
    return Localizations.localeOf(this).toString();
  }
}

extension UnFocusScreen on BuildContext {
  void unfocus() {
    return FocusScope.of(this).unfocus();
  }
}

extension StringCapitalizeExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
