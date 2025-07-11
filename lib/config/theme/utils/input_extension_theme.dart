import 'package:flutter/material.dart';

/// An extension on [BuildContext] that provides easy access to the current
/// [InputDecorationTheme].
///
/// this extension allows you to access the [InputDecorationTheme] associated with the
/// current [BuildContext] directly through the `inputDecorationTheme` getter.
extension InputExtensionTheme on BuildContext {
  /// Gets the [InputDecorationTheme] associated with the current [BuildContext].
  ///
  /// this getter provides a convenient way to access the current [InputDecorationTheme]
  /// without having to call `Theme.of(context).inputDecorationTheme` repeatedly.
  ///
  /// Returns:
  ///   - The [InputDecorationTheme] associated with the current [BuildContext].
  InputDecorationTheme get inputDecorationTheme =>
      Theme.of(this).inputDecorationTheme;
}