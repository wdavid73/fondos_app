import 'package:flutter/material.dart';
import 'package:fondos_app/config/config.dart';

/// Utility class for displaying custom SnackBars in the application.
///
/// Provides a static method to show a SnackBar with customizable content, icon, color, and duration.
class CustomSnackBar {
  /// Displays a custom SnackBar in the given [context].
  ///
  /// Shows either a text [message] or a [customContent] widget. You can also provide an [icon],
  /// [colorIcon], [backgroundColor], [textStyle], [action], and [duration].
  ///
  /// Only one of [message] or [customContent] should be provided. If both or neither are provided,
  /// an [ArgumentError] is thrown.
  static void showSnackBar(
    BuildContext context, {
    String? message,
    SnackBarAction? action,
    Widget? customContent,
    IconData? icon,
    Color? colorIcon,
    Color? backgroundColor,
    TextStyle? textStyle,
    Duration duration = const Duration(milliseconds: 3000),
  }) {
    // Check if the arguments are valid.
    // An ArgumentError is thrown if both customContent and message are provided,
    // or if neither is provided (and message is null or empty).
    if ((customContent == null && (message == null || message.isEmpty)) ||
        (customContent != null && message != null)) {
      throw ArgumentError(
          "You must provide either 'message' or 'customContent', but not both.");
    }

    // Remove any currently displayed SnackBar.
    ScaffoldMessenger.of(context).removeCurrentSnackBar();

    // Show the new SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: duration,
        backgroundColor: backgroundColor,
        // If customContent is provided, use it. Otherwise, build a default Row with an icon and text.
        content: customContent ??
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Display the icon if provided.
                if (icon != null)
                  Icon(icon, size: 30, color: colorIcon ?? ColorTheme.white),
                const SizedBox(width: 10),
                // Display the message text.
                Flexible(
                  child: Text(
                    "$message",
                    style: textStyle ??
                        context.textTheme.bodyLarge?.copyWith(
                          color: ColorTheme.white,
                        ),
                  ),
                ),
              ],
            ),
        action: action,
      ),
    );
  }
}
