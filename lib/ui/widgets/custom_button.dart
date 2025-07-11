import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/config/config.dart';

/// Defines the various types of buttons that [CustomButton] can render.
enum CustomButtonType {
  /// A Material Design elevated button with a shadow.
  elevated,

  /// A Material Design text button without elevation.
  text,

  /// A Material Design button with a thin border.
  outlined,

  /// A Material Design filled button with a solid background color.
  filled,

  /// A Material Design icon button, typically used without text.
  icon,

  /// A Material Design filled tonal button, a variation of [filled] with a subtle color.
  filledTonal,
}

/// A highly customizable button widget that can render different Material Design button types.
///
/// It supports displaying a label (String) or a child (Widget), an optional icon,
/// and handles a loading state with a [CircularProgressIndicator].
///
/// The type of button can be specified using [CustomButtonType].
class CustomButton extends StatelessWidget {
  /// The text label to display on the button.
  /// Cannot be used with [child].
  final String? label;

  /// The widget to display as the main content of the button.
  /// Cannot be used with [label].
  final Widget? child;

  /// The icon to display alongside the label or child.
  /// Required if [buttonType] is [CustomButtonType.icon].
  final Widget? icon;

  /// Whether the button is in a loading state.
  /// When true, the button is disabled and shows a [CircularProgressIndicator]
  /// and "Loading..." text (if applicable).
  final bool isLoading;

  /// The callback function to be called when the button is pressed.
  /// If [isLoading] is true, the button is disabled and this callback is not invoked.
  final void Function()? onPressed;

  /// A key to identify this widget in the widget tree.
  final Key? buttonKey;

  /// The type of Material Design button to render.
  /// Defaults to [CustomButtonType.filled].
  final CustomButtonType buttonType;

  /// The background color of the button.
  /// If provided, this color will override the theme's default background color for the button type.
  /// Not applicable for [CustomButtonType.icon] as it typically doesn't have a background color.
  final Color? backgroundColor;

  /// Creates a [CustomButton] widget.
  ///
  /// Requires either a [label] or a [child] for most button types, but not both.
  /// If [buttonType] is [CustomButtonType.icon], then [icon] must be provided
  /// and [label] and [child] must be null.
  const CustomButton({
    super.key,
    this.label,
    this.child,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    this.buttonKey,
    this.buttonType = CustomButtonType.filled,
    this.backgroundColor,
  }) : assert(
          // Assertions for valid parameter combinations based on button type.
          (buttonType == CustomButtonType.icon &&
                  icon != null &&
                  label == null &&
                  child == null) ||
              (buttonType != CustomButtonType.icon &&
                  (label != null || child != null) &&
                  !(label != null && child != null)),
          'For CustomButtonType.icon, "icon" must be provided, and "label" and "child" must be null. '
          'For other button types, either "label" or "child" must be provided, but not both.',
        );

  @override
  Widget build(BuildContext context) {
    // Determine the actual icon to display, considering the loading state.
    final Widget? actualIcon = _buttonIcon(icon: icon, context: context);

    // Determine the actual label/child to display, considering the loading state
    // and button type (icon buttons don't have a label/child).
    final Widget? actualLabelOrChild = (buttonType == CustomButtonType.icon)
        ? null
        : _buttonLabelOrChild(context: context);

    // Common style for all buttons to apply the optional background color
    ButtonStyle? getButtonStyle(BuildContext context) {
      if (backgroundColor == null) return null; // No override needed
      switch (buttonType) {
        case CustomButtonType.elevated:
        case CustomButtonType.filled:
        case CustomButtonType
              .filledTonal: // Tonal buttons also take background color style
          return ButtonStyle(
              backgroundColor: WidgetStatePropertyAll<Color>(backgroundColor!));
        case CustomButtonType.outlined:
          // For outlined buttons, backgroundColor typically affects the fill inside the border
          return ButtonStyle(
            backgroundColor: WidgetStatePropertyAll<Color>(backgroundColor!),
            side: WidgetStatePropertyAll<BorderSide>(
              BorderSide(
                  color: backgroundColor!,
                  width:
                      1), // Border color can match background for consistency
            ),
          );
        case CustomButtonType.text:
          // Text buttons don't usually have a solid background, but can have a splash color.
          // If you want a background, it's typically set via other properties or not directly here.
          // For simplicity, we'll make it behave like a filled button if backgroundColor is provided.
          return ButtonStyle(
              backgroundColor: WidgetStatePropertyAll<Color>(backgroundColor!));
        case CustomButtonType.icon:
          // Icon buttons usually don't have a background color directly.
          // If you want a background, you might wrap it in a Container or specify splash/highlight color.
          return null; // Return null as background color is not typically applied here.
      }
    }

    // Render the appropriate button type based on `buttonType` parameter.
    switch (buttonType) {
      case CustomButtonType.elevated:
        return actualIcon != null
            ? ElevatedButton.icon(
                key: buttonKey,
                onPressed: isLoading ? null : onPressed,
                icon: actualIcon,
                label: actualLabelOrChild!,
                style: getButtonStyle(context),
              )
            : ElevatedButton(
                key: buttonKey,
                onPressed: isLoading ? null : onPressed,
                style: getButtonStyle(context),
                child: actualLabelOrChild!,
              );
      case CustomButtonType.text:
        return actualIcon != null
            ? TextButton.icon(
                key: buttonKey,
                onPressed: isLoading ? null : onPressed,
                icon: actualIcon,
                label: actualLabelOrChild!,
                style: getButtonStyle(context),
              )
            : TextButton(
                key: buttonKey,
                onPressed: isLoading ? null : onPressed,
                style: getButtonStyle(context),
                child: actualLabelOrChild!,
              );
      case CustomButtonType.outlined:
        return actualIcon != null
            ? OutlinedButton.icon(
                key: buttonKey,
                onPressed: isLoading ? null : onPressed,
                style: getButtonStyle(context),
                icon: actualIcon,
                label: actualLabelOrChild!,
              )
            : OutlinedButton(
                key: buttonKey,
                onPressed: isLoading ? null : onPressed,
                style: getButtonStyle(context),
                child: actualLabelOrChild!,
              );
      case CustomButtonType.filledTonal:
        return actualIcon != null
            ? FilledButton.tonalIcon(
                key: buttonKey,
                onPressed: isLoading ? null : onPressed,
                icon: actualIcon,
                style: getButtonStyle(context),
                label: actualLabelOrChild!,
              )
            : FilledButton.tonal(
                key: buttonKey,
                onPressed: isLoading ? null : onPressed,
                style: getButtonStyle(context),
                child: actualLabelOrChild!,
              );
      case CustomButtonType.filled:
        return actualIcon != null
            ? FilledButton.icon(
                key: buttonKey,
                onPressed: isLoading ? null : onPressed,
                icon: actualIcon,
                style: getButtonStyle(context),
                label: actualLabelOrChild!,
              )
            : FilledButton(
                key: buttonKey,
                onPressed: isLoading ? null : onPressed,
                style: getButtonStyle(context),
                child: actualLabelOrChild!,
              );
      case CustomButtonType.icon:
        // IconButton requires a non-null icon. A fallback is provided for safety.
        return IconButton(
          key: buttonKey,
          style: getButtonStyle(context),
          onPressed: isLoading ? null : onPressed,
          icon: actualIcon ?? const Icon(Icons.error),
        );
    }
  }

  /// Determines the primary content widget (label or child) for the button.
  ///
  /// If [isLoading] is true, it returns a "Loading..." text.
  /// Otherwise, it returns the provided [label] as a [Text] widget,
  /// or the [child] widget.
  Widget _buttonLabelOrChild({required BuildContext context}) {
    if (isLoading) {
      return Text(
        context.l10n.loading,
        /* style: context.textTheme.bodyLarge, */
      );
    }
    if (label != null) {
      return Text(
        label!,
        /* style: context.textTheme.bodyLarge, */
      );
    }
    return child!;
  }

  /// Determines the icon widget for the button.
  ///
  /// If [isLoading] is true, it returns a [CircularProgressIndicator].
  /// Otherwise, it returns the provided [icon] widget.
  Widget? _buttonIcon({required BuildContext context, Widget? icon}) {
    if (isLoading) {
      return SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 3,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      );
    }
    return icon;
  }
}
