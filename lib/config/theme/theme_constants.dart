import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/config/config.dart';
import 'package:flutter_starter_kit/config/theme/widget_themes/widget_themes.dart';

/// A utility class that centralizes all constant values and base theme data
/// used across both light and dark themes in the application.
///
/// This class ensures consistency in styling by providing a single source
/// for [ColorScheme] definitions, base [ThemeData] components, and
/// utility functions for resolving widget states.
class ThemeConstants {
  /// The global font size scaling factor for text elements in the application.
  ///
  /// This factor is applied to text themes to adjust font sizes based on
  /// device settings or application-wide preferences.
  static final fontSizeFactor = 0.8;

  /// The base [ColorScheme] for the **light theme**.
  ///
  /// Defines the semantic colors for different parts of the UI in light mode,
  /// such as primary, secondary, tertiary, surface, and error colors,
  /// along with their "on" counterparts for text/icons placed on them.
  static final ColorScheme colorScheme = ColorScheme(
    brightness: Brightness.light,

    /// The primary color of the app.
    primary: ColorTheme.primaryColor,

    /// The color of text and icons on top of the primary color.
    onPrimary: ColorTheme.iconsColor,

    /// A lighter shade of the primary color, used for containers.
    primaryContainer: ColorTheme.lightPrimaryColor,

    /// The color of text and icons on top of the primary container color.
    onPrimaryContainer: ColorTheme.textPrimary,

    /// A secondary color for the app, often used for accents.
    secondary: ColorTheme.secondaryColor,

    /// The color of text and icons on top of the secondary color.
    onSecondary: ColorTheme.iconsColor,

    /// A lighter shade of the secondary color, used for containers.
    secondaryContainer: ColorTheme.lightPrimaryColor,

    /// The color of text and icons on top of the secondary container color.
    onSecondaryContainer: ColorTheme.textPrimary,

    /// An accent color for the app, providing visual emphasis.
    tertiary: ColorTheme.accentColor,

    /// The color of text and icons on top of the tertiary color.
    onTertiary: ColorTheme.iconsColor,

    /// A lighter shade of the tertiary color, used for containers.
    tertiaryContainer: ColorTheme.lightPrimaryColor,

    /// The color of text and icons on top of the tertiary container color.
    onTertiaryContainer: ColorTheme.textPrimary,

    /// The color of surfaces (background), such as cards and dialogs.
    surface: ColorTheme.backgroundColor,

    /// The color of text and icons on top of the surface color (onBackground).
    onSurface: ColorTheme.textPrimary,

    /// The color used for error states, indicating invalid input or issues.
    error: ColorTheme.error,

    /// The color of text and icons on top of the error color.
    onError: ColorTheme.iconsColor,

    /// The color used for outlines, such as dividers and borders.
    outline: ColorTheme.divider,

    // //! Deprecated background: ColorTheme.backgroundColor, // The background color of the app.
    // //! Deprecated onBackground: ColorTheme.textPrimary, // The color of text and icons on top of the background color.
  );

  /// The base [ColorScheme] for the **dark theme**.
  ///
  /// This scheme is derived from [colorScheme] (the light theme scheme)
  /// but overrides specific properties for dark mode, such as [brightness],
  /// [surface], and [onSurface] colors.
  static final ColorScheme darkColorScheme = ColorScheme(
    brightness: Brightness.dark,

    // Primary brand colors: often the same as in light theme,
    // but the contrast with onPrimary changes.
    primary: ColorTheme.primaryColor, // Your main purple brand color
    // onPrimary should contrast well with primary on a dark background
    // White or ColorTheme.iconsColor if it's the same
    onPrimary: ColorTheme.white,

    // Primary containers: should be darker in the dark theme
    // A darker shade of the primary
    primaryContainer: ColorTheme.secondaryColor,
    // Light text/icons on the dark container
    onPrimaryContainer: ColorTheme.white,

    // Secondary brand colors
    secondary: ColorTheme.accentColor, // Your accent color
    // onSecondary should contrast well with secondary on a dark background
    onSecondary: ColorTheme.textPrimary,
    // Or ColorTheme.white, depending on contrast

    // Secondary containers: darker
    secondaryContainer: ColorTheme.navigationBackgroundColorDark,
    // Another dark gray
    onSecondaryContainer: ColorTheme.white,

    // Tertiary colors (accent, etc.)
    tertiary: ColorTheme.accentColor, // Your accent color
    onTertiary: ColorTheme.white,

    // Tertiary containers: darker
    tertiaryContainer: ColorTheme.backgroundColorDark, // Another dark gray
    onTertiaryContainer: ColorTheme.white,

    // UI surface (cards, dialogs, etc.): should be dark
    surface: ColorTheme.backgroundColorDark, // The main dark background
    // onSurface should contrast well with surface (light text/icons)
    onSurface: ColorTheme.white, // Or a very light gray for text/icons

    // Colors for error states
    error: ColorTheme.error, // The error color is usually the same
    onError: ColorTheme.white, // Error text should be light on the dark error

    // Colors for outline lines/dividers
    outline: ColorTheme.textSecondary,
    // A medium-dark gray for the divider in dark theme

    // 'background' and 'onBackground' properties are deprecated in M3,
    // 'surface' and 'onSurface' are the recommended equivalents.
    // If you truly need them for M2 compatibility, you could define them like this:
    // background: ColorTheme.backgroundColorDark,
    // onBackground: ColorTheme.white,
  );

  /// Base [IconThemeData].
  ///
  /// Used as a starting point for customizing the icon styles in both
  /// light and dark themes, ensuring a consistent base appearance for icons.
  static final baseIconTheme = IconThemeData();

  /// Base [AppBarTheme].
  ///
  /// Used as a starting point for customizing the app bar styles in both
  /// light and dark themes. It sets common properties like title centering,
  /// elevation, and default icon/text styles.
  static final baseAppBarTheme = AppBarTheme(
    centerTitle: false,
    elevation: 0,
    titleTextStyle: baseTextTheme.titleMedium?.copyWith(
      color: ColorTheme.textPrimary,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  );

  /// Base [AppBarTheme] **for dark them**
  ///
  /// Used as a starting point for customizing the app bar styles in both
  /// light and dark themes. It sets common properties like title centering,
  /// elevation, and default icon/text styles.
  static final baseAppBarDarkTheme = AppBarTheme(
    backgroundColor: darkColorScheme.primary,
    titleTextStyle: baseTextThemeDark.titleMedium,
    centerTitle: false,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  );

  /// Base [ChipThemeData].
  ///
  /// Used as a starting point for customizing the chip styles in both
  /// light and dark themes. Defines default background, label style,
  /// shape, and border properties for chips.
  static final baseChipTheme = ChipThemeData(
    backgroundColor: ColorTheme.accentColor,
    labelStyle: baseTextTheme.bodyMedium,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    side: BorderSide(width: 1, color: ColorTheme.accentColor),
  );

  /// Base [DividerThemeData].
  ///
  /// Used as a starting point for customizing the divider styles in both
  /// light and dark themes. The color is set to [ColorTheme.divider]
  /// to ensure consistency across all dividers.
  static final baseDividerTheme = DividerThemeData(
    color: ColorTheme.divider,
  );

  /// Base [ListTileThemeData].
  ///
  /// Used as a starting point for customizing the list tile styles in both
  /// light and dark themes. It defines default text styles for title and
  /// subtitle, text color, and colors for selected states and icons.
  static final baseListTileTheme = ListTileThemeData(
    titleTextStyle: baseTextTheme.bodyLarge,
    subtitleTextStyle: baseTextTheme.bodySmall,
    textColor: ColorTheme.textPrimary,
    selectedTileColor: ColorTheme.accentColor,
    selectedColor: ColorTheme.white,
    iconColor: ColorTheme.secondaryColor,
  );

  /// Base [CardTheme].
  ///
  /// Used as a starting point for customizing the card styles in both
  /// light and dark themes. It sets a default elevation, a rounded
  /// rectangle shape with a border.
  static final baseCardTheme = CardThemeData(
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
      side: BorderSide(
        color: ColorTheme.textPrimary,
        width: 2,
      ),
    ),
  );

  /// Base [FloatingActionButtonThemeData].
  ///
  /// Used as a starting point for customizing the floating action button
  /// (FAB) styles in both light and dark themes. Defines default background,
  /// foreground colors, text style for extended FABs, icon size, and splash color.
  static final baseFABTheme = FloatingActionButtonThemeData(
    backgroundColor: ColorTheme.accentColor,
    foregroundColor: ColorTheme.white,
    extendedTextStyle: baseTextTheme.bodyLarge,
    iconSize: 16,
    splashColor: ColorTheme.primaryColor,
  );

  /// Base [DrawerThemeData].
  ///
  /// Used as a starting point for customizing the drawer styles in both
  /// light and dark themes. It sets properties like the scrim color
  /// and the shape of the drawer.
  static final baseDrawerTheme = DrawerThemeData(
    scrimColor: ColorTheme.backgroundColorDark.withValues(
      alpha: 0.5,
    ),
    endShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
  );

  /// Base [SnackBarThemeData].
  ///
  /// Used as a starting point for customizing the snack bar styles in both
  /// light and dark themes. Defines properties like close icon color,
  /// padding, action button colors, content text style, and shape.
  static final baseSnackBarTheme = SnackBarThemeData(
    closeIconColor: ColorTheme.white,
    // showCloseIcon: true,
    // behavior: SnackBarBehavior.floating,
    insetPadding: const EdgeInsets.all(10),
    actionBackgroundColor: ColorTheme.accentColor,
    disabledActionBackgroundColor: ColorTheme.disable,
    disabledActionTextColor: ColorTheme.white,
    contentTextStyle: baseTextTheme.bodyLarge,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
      ),
    ),
  );

  /// Base [ProgressIndicatorThemeData].
  ///
  /// Used as a starting point for customizing the progress indicator styles
  /// in both light and dark themes.
  static final baseProgressIndicatorTheme = ProgressIndicatorThemeData();

  /// Base [BottomSheetThemeData].
  ///
  /// Used as a starting point for customizing the bottom sheet styles in both
  /// light and dark themes. Defines background color, drag handle properties,
  /// surface tint color, shape, and constraints.
  static final baseBottomSheetTheme = BottomSheetThemeData(
    backgroundColor: ColorTheme.backgroundColor,
    dragHandleColor: ColorTheme.backgroundColorDark,
    surfaceTintColor: ColorTheme.lightPrimaryColor,
    showDragHandle: true,
    dragHandleSize: Size(50, 5),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
      ),
    ),
    constraints: BoxConstraints(
      minHeight: 250,
      minWidth: 450,
    ),
  );

  /// Base [SwitchThemeData].
  ///
  /// Used as a starting point for customizing the switch styles in both
  /// light and dark themes. It configures the thumb and track colors
  /// based on the selected/unselected states.
  static final baseSwitchTheme = SwitchThemeData(
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    thumbColor: resolveColorWith(
      ColorTheme.white,
      ColorTheme.disable,
    ),
    trackColor: resolveColorWith(
      ColorTheme.secondaryColor,
      ColorTheme.white,
    ),
  );

  /// Base [RadioThemeData].
  ///
  /// Used as a starting point for customizing the radio button styles in both
  /// light and dark themes. It sets the default fill color.
  static final baseRadioTheme = RadioThemeData(
    fillColor: WidgetStatePropertyAll<Color>(
      ColorTheme.secondaryColor,
    ),
  );

  /// Base [CheckboxThemeData].
  ///
  /// Used as a starting point for customizing the checkbox styles in both
  /// light and dark themes. It configures the fill and check colors
  /// based on the selected/unselected states, and the border side.
  static final baseCheckboxTheme = CheckboxThemeData(
    fillColor: resolveColorWith(
      ColorTheme.secondaryColor,
      ColorTheme.white,
    ),
    checkColor: resolveColorWith(
      ColorTheme.white,
      Colors.transparent,
    ),
    side: BorderSide(width: 1.5),
  );

  /// Base [BottomNavigationBarThemeData].
  ///
  /// Used as a starting point for customizing the bottom navigation bar
  /// styles in both light and dark themes. Defines background color,
  /// selected/unselected item and label colors/styles, and label visibility.
  static final baseBottomNavigationBar = BottomNavigationBarThemeData(
    backgroundColor: ColorTheme.secondaryColor,
    selectedItemColor: Colors.white,
    selectedLabelStyle: baseTextTheme.labelMedium,
    unselectedItemColor: ColorTheme.lightPrimaryColor,
    unselectedLabelStyle: baseTextTheme.labelSmall,
    showUnselectedLabels: false,
  );

  /// Base [NavigationRailThemeData].
  ///
  /// Used as a starting point for customizing the navigation rail styles
  /// in both light and dark themes. Defines background, elevation, label type,
  /// minimum width, and selected/unselected icon/label themes.
  static final baseNavigationRail = NavigationRailThemeData(
    backgroundColor: ColorTheme.secondaryColor,
    elevation: 2,
    labelType: NavigationRailLabelType.none,
    minWidth: 50,
    selectedIconTheme: baseIconTheme.copyWith(
      color: ColorTheme.accentColor,
    ),
    unselectedIconTheme: baseIconTheme.copyWith(
      color: ColorTheme.lightPrimaryColor,
    ),
    selectedLabelTextStyle: baseTextTheme.labelMedium,
    unselectedLabelTextStyle: baseTextTheme.labelSmall?.copyWith(
      color: ColorTheme.lightPrimaryColor,
    ),
    useIndicator: false,
  );

  /// Base [NavigationDrawerThemeData].
  ///
  /// Used as a starting point for customizing the navigation drawer styles
  /// in both light and dark themes. Defines background color, surface tint,
  /// and elevation.
  static final baseNavigationDrawer = NavigationDrawerThemeData(
    backgroundColor: ColorTheme.navigationBackgroundColorLight,
    surfaceTintColor: ColorTheme.secondaryColor,
    elevation: 5,
  );

  /// Base [PopupMenuThemeData].
  ///
  /// Used as a starting point for customizing the popup menu styles in both
  /// light and dark themes. Defines icon color, shape, padding, background color,
  /// and positioning.
  static final basePopupMenuThemeData = PopupMenuThemeData(
    iconColor: ColorTheme.accentColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    menuPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    color: ColorTheme.lightPrimaryColor,
    position: PopupMenuPosition.over,
  );

  /// Resolves a color based on the [WidgetState] of a widget.
  ///
  /// If the widget is in a [WidgetState.selected] state, [selectedColor] is returned.
  /// Otherwise, [unselectedColor] is returned.
  ///
  /// @param selectedColor The color to use when the widget is selected.
  /// @param unselectedColor The color to use when the widget is not selected.
  /// @returns A [WidgetStateProperty] that resolves to a [Color].
  static WidgetStateProperty<Color?> resolveColorWith(
    Color selectedColor,
    Color unselectedColor,
  ) {
    return WidgetStateProperty.resolveWith<Color?>(
      (Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return selectedColor;
        }
        return unselectedColor;
      },
    );
  }

  /// Resolves a [TextStyle] based on the [WidgetState] of a widget.
  ///
  /// If the widget is in a [WidgetState.selected] state, [selectedText] is returned.
  /// Otherwise, [unselectedText] is returned.
  ///
  /// @param selectedText The [TextStyle] to use when the widget is selected.
  /// @param unselectedText The [TextStyle] to use when the widget is not selected.
  /// @returns A [WidgetStateProperty] that resolves to a [TextStyle].
  static WidgetStateProperty<TextStyle?> resolveTextStyleWith(
    TextStyle selectedText,
    TextStyle unselectedText,
  ) {
    return WidgetStateProperty.resolveWith<TextStyle?>(
        (Set<WidgetState> states) {
      return states.contains(WidgetState.selected)
          ? selectedText
          : unselectedText;
    });
  }

  /// Resolves an [IconThemeData] based on the [WidgetState] of a widget.
  ///
  /// If the widget is in a [WidgetState.selected] state, [selectedIcon] is returned.
  /// Otherwise, [unselectedIcon] is returned.
  ///
  /// @param selectedIcon The [IconThemeData] to use when the widget is selected.
  /// @param unselectedIcon The [IconThemeData] to use when the widget is not selected.
  /// @returns A [WidgetStateProperty] that resolves to an [IconThemeData].
  static WidgetStateProperty<IconThemeData?> resolveIconThemeDataWith(
    IconThemeData selectedIcon,
    IconThemeData unselectedIcon,
  ) {
    return WidgetStateProperty.resolveWith<IconThemeData?>(
        (Set<WidgetState> states) {
      return states.contains(WidgetState.selected)
          ? selectedIcon
          : unselectedIcon;
    });
  }

  /// Resolves a color based on the active or disabled state of a widget.
  ///
  /// If the widget is in a [WidgetState.disabled] state, [disabledColor] is returned.
  /// Otherwise, [activeColor] is returned.
  ///
  /// @param activeColor The color to use when the widget is active.
  /// @param disabledColor The color to use when the widget is disabled.
  /// @returns A [WidgetStateProperty] that resolves to a [Color].
  static WidgetStateProperty<Color?> resolveColorStatusWith(
    Color activeColor,
    Color disabledColor,
  ) {
    return WidgetStateProperty.resolveWith<Color?>(
      (Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return disabledColor;
        }
        return activeColor;
      },
    );
  }
}
