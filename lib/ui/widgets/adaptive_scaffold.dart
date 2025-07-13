import 'package:flutter/material.dart';
import 'package:fondos_app/config/theme/theme.dart';

enum DeviceType { phone, tablet, other }

/// A responsive scaffold that adapts its layout to different device types and orientations.
///
/// This widget provides different layouts for phones, tablets, and larger screens, supporting
/// navigation drawers, rails, and custom layouts for each device type.
class AdaptiveScaffold extends StatelessWidget {
  /// The main content of the scaffold.
  final Widget child;

  /// The app bar to display at the top of the scaffold.
  final PreferredSizeWidget? appBar;

  /// The layout to use for medium-sized screens (e.g., tablets in portrait).
  final Widget? mediumLayout;

  /// The layout to use for large screens (e.g., tablets in landscape or desktops).
  final Widget? expandedLayout;

  /// The bottom navigation bar widget.
  final Widget? bottomNavigationBar;

  /// The navigation rail widget for medium screens.
  final Widget? navigationRail;

  /// The navigation drawer widget for large screens.
  final Widget? navigationDrawer;

  /// The drawer widget for small screens.
  final Widget? drawer;

  /// The floating action button.
  final Widget? floatingActionButton;

  /// The background color of the scaffold.
  final Color? scaffoldBackgroundColor;

  /// Creates an [AdaptiveScaffold] widget.
  const AdaptiveScaffold({
    super.key,
    required this.child,
    this.appBar,
    this.mediumLayout,
    this.expandedLayout,
    this.bottomNavigationBar,
    this.navigationRail,
    this.navigationDrawer,
    this.drawer,
    this.floatingActionButton,
    this.scaffoldBackgroundColor,
  });

  /// Determines the device type based on the shortest side of the screen.
  DeviceType _getDeviceType(double shortestSide) {
    if (shortestSide < 600) {
      return DeviceType.phone;
    } else if (shortestSide < 900) {
      return DeviceType.tablet;
    } else {
      return DeviceType.other;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      backgroundColor: scaffoldBackgroundColor,
      drawer: (context.width < 900 && drawer != null) ? drawer : null,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final widthScreen = constraints.maxWidth;
          final orientation = context.orientation;
          final isLandscape = orientation == Orientation.landscape;

          final shortestSide = widthScreen < constraints.maxHeight
              ? widthScreen
              : constraints.maxHeight;

          final deviceType = _getDeviceType(shortestSide);

          return _getLayoutForDevice(
            deviceType,
            isLandscape,
            navigationRail,
            navigationDrawer,
          );
        },
      ),
      bottomNavigationBar: _AdaptiveBottomNavigationBar(
        bottomNavigationBar: bottomNavigationBar,
        widthScreen: context.width,
      ),
      floatingActionButton: floatingActionButton,
    );
  }

  /// Returns the appropriate layout widget for the given device type and orientation.
  Widget _getLayoutForDevice(
    DeviceType deviceType,
    bool isLandscape,
    Widget? navigationRail,
    Widget? navigationDrawer,
  ) {
    if (deviceType == DeviceType.tablet && isLandscape ||
        deviceType == DeviceType.other) {
      return _ExpandedLayout(
        navigationDrawer: navigationDrawer,
        child: expandedLayout ?? _CompactLayout(child: child),
      );
    }

    if ((deviceType == DeviceType.phone && isLandscape) ||
        deviceType == DeviceType.tablet) {
      return _MediumLayout(
        navigationRail: navigationRail,
        child: mediumLayout ?? _CompactLayout(child: child),
      );
    }

    return _CompactLayout(child: child);
  }
}

/// Compact layout for small screens (e.g., phones).
class _CompactLayout extends StatelessWidget {
  final Widget child;
  const _CompactLayout({required this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: child);
  }
}

/// Medium layout for tablets or phones in landscape, with optional navigation rail.
class _MediumLayout extends StatelessWidget {
  final Widget child;
  final Widget? navigationRail;
  const _MediumLayout({required this.child, this.navigationRail});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          navigationRail ?? const SizedBox.shrink(),
          Expanded(child: child),
        ],
      ),
    );
  }
}

/// Expanded layout for large screens, with optional navigation drawer.
class _ExpandedLayout extends StatelessWidget {
  final Widget child;
  final Widget? navigationDrawer;
  const _ExpandedLayout({required this.child, this.navigationDrawer});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          navigationDrawer ?? const SizedBox.shrink(),
          Expanded(child: child),
        ],
      ),
    );
  }
}

/// Bottom navigation bar that only appears on small screens.
class _AdaptiveBottomNavigationBar extends StatelessWidget {
  final double widthScreen;
  final Widget? bottomNavigationBar;
  const _AdaptiveBottomNavigationBar({
    this.bottomNavigationBar,
    required this.widthScreen,
  });

  @override
  Widget build(BuildContext context) {
    return (widthScreen < 600 && bottomNavigationBar != null)
        ? bottomNavigationBar!
        : const SizedBox.shrink();
  }
}
