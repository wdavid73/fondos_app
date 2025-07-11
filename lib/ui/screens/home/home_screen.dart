import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/ui/widgets/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_starter_kit/config/config.dart';
import 'package:flutter_starter_kit/ui/shared/shared.dart';
import 'package:flutter_starter_kit/ui/screens/home/expanded_layout/home_screen_expanded_layout.dart';
import 'package:flutter_starter_kit/ui/screens/home/medium_layout/home_screen_medium_layout.dart';
import './widgets/drawer_home.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      appBar: _appBarHome(context),
      drawer: DrawerHome(),
      bottomNavigationBar: _BottomNavigationBar(),
      navigationRail: _MediumNavigationRailHome(),
      navigationDrawer: _ExpandedNavigationDrawerHome(),
      expandedLayout: HomeScreenExpandedLayout(),
      mediumLayout: HomeScreenMediumLayout(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: FlutterLogo(
              size: context.dp(30),
            ),
          ),
          AppSpacing.md,
          Text(
            key: Key("home_title"),
            context.l10n.home,
            style: context.textTheme.titleLarge,
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget? _appBarHome(BuildContext context) {
    return AppBar(
      title: Text(
        context.l10n.home,
      ),
      actions: [
        IconButton(
          onPressed: () => context.push('/settings'),
          icon: Icon(Icons.settings),
        )
      ],
    );
  }
}

class _BottomNavigationBar extends StatelessWidget {
  const _BottomNavigationBar();

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 0,
      onTap: (index) {},
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
      ],
    );
  }
}

class _MediumNavigationRailHome extends StatelessWidget {
  const _MediumNavigationRailHome();

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      selectedIndex: 0,
      onDestinationSelected: (index) {},
      destinations: const [
        NavigationRailDestination(
          icon: Icon(Icons.home),
          label: Text("Home"),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.person),
          label: Text("Profile"),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.settings),
          label: Text("Settings"),
        ),
      ],
    );
  }
}

class _ExpandedNavigationDrawerHome extends StatelessWidget {
  const _ExpandedNavigationDrawerHome();

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      selectedIndex: 0,
      onDestinationSelected: (index) {},
      children: [
        CustomDrawerHeader(),
        const NavigationDrawerDestination(
          icon: Icon(Icons.home),
          label: Text("Home"),
        ),
        const NavigationDrawerDestination(
          icon: Icon(Icons.person),
          label: Text("Profile"),
        ),
        const NavigationDrawerDestination(
          icon: Icon(Icons.settings),
          label: Text("Settings"),
        ),
      ],
    );
  }
}
