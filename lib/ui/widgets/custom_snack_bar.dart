import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/config/config.dart';

class CustomSnackBar {
  /// Displays a custom SnackBar.
  ///
  /// This method shows a SnackBar with either a custom content widget or a
  /// text message. You can also provide an icon, an action, and customize
  /// the background color, text style, and duration.
  ///
  /// Only one of `message` or `customContent` should be provided. If both are
  /// provided or if neither is provided (and `message` is null or empty), an
  /// [ArgumentError] will be thrown.
  ///
  /// Parameters:
  ///   - [context]: The [BuildContext] to use for showing the SnackBar.
  ///   - [message]: The text message to display in the SnackBar.
  ///   - [action]: An optional [SnackBarAction] to add to the SnackBar.
  ///   - [customContent]: An optional custom widget to display in the SnackBar.
  ///   - [icon]: An optional icon to display in the SnackBar.
  ///   - [colorIcon]: The color of the icon. Defaults to [ColorTheme.white] if not provided.
  ///   - [backgroundColor]: The background color of the SnackBar.
  ///   - [textStyle]: The text style for the message.
  ///   - [duration]: The duration for which the SnackBar should be displayed.
  ///     Defaults to 3000 milliseconds (3 seconds).
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
