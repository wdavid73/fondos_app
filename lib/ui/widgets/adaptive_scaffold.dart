import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/config/theme/theme.dart';

enum DeviceType { phone, tablet, other }

class AdaptiveScaffold extends StatelessWidget {
  final Widget child;
  final PreferredSizeWidget? appBar;
  final Widget? mediumLayout;
  final Widget? expandedLayout;
  final Widget? bottomNavigationBar;
  final Widget? navigationRail;
  final Widget? navigationDrawer;
  final Widget? drawer;
  final Widget? floatingActionButton;
  final Color? scaffoldBackgroundColor;

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
      appBar: context.orientation == Orientation.portrait ? appBar : null,
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
        child: expandedLayout!,
      );
    }

    if ((deviceType == DeviceType.phone && isLandscape) ||
        deviceType == DeviceType.tablet) {
      return _MediumLayout(
        navigationRail: navigationRail,
        child: mediumLayout!,
      );
    }

    return _CompactLayout(child: child);
  }
}

class _CompactLayout extends StatelessWidget {
  final Widget child;
  const _CompactLayout({required this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: child);
  }
}

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
