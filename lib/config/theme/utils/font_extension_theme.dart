import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/config/theme/utils/responsive.dart';

/// An extension on [BuildContext] that provides easy access to the current
/// [TextTheme].
///
/// This extension allows you to access the [TextTheme] associated with the
/// current [BuildContext] directly through the `textTheme` getter.
extension FontExtensionTheme on BuildContext {
  /// Gets the [TextTheme] associated with the current [BuildContext].
  ///
  /// This getter provides a convenient way to access the current [TextTheme]
  /// without having to call `Theme.of(context).textTheme` repeatedly.
  ///
  /// Returns:
  ///   - The [TextTheme] associated with the current [BuildContext].
  TextTheme get textTheme => Theme.of(this).textTheme;
}

extension TextScaleFactorExtension on BuildContext {
  TextScaler get adjustedTextScaleFactor {
    final textScaler = this.textScaler;
    return textScaler.clamp(minScaleFactor: 0.8, maxScaleFactor: 1.0);
  }

  TextScaler get tsf => adjustedTextScaleFactor;
}
