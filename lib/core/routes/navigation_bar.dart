import 'package:e_commerce/admin/screens/admin_screen.dart';
import 'package:e_commerce/core/utils/screens_names.dart';
import 'package:e_commerce/home/screens/home_screen.dart';
import 'package:e_commerce/home/screens/profile_screen.dart';
import 'package:e_commerce/home/screens/search_screen.dart';
import 'package:e_commerce/home/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class BottomNavBar extends StatelessWidget {
  final Widget child;
  const BottomNavBar({required this.child, super.key});

  int _getSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    if (location == ScreensNames.home) return 0;
    if (location == ScreensNames.search) return 1;
    if (location == ScreensNames.admin) return 2;
    if (location == ScreensNames.profile) return 3;
    if (location == ScreensNames.settings) return 4;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: PersistentTabView(
        context,
        controller:
            PersistentTabController(initialIndex: _getSelectedIndex(context)),
        screens: _buildScreens(),
        items: _navBarItems(context),
        navBarStyle: NavBarStyle.style15,
        // decoration: NavBarDecoration(boxShadow: []),
        backgroundColor: Theme.of(context).colorScheme.surface,
        navBarHeight: 60,
        onItemSelected: (index) {
          switch (index) {
            case 0:
              context.goNamed(ScreensNames.home);
              break;
            case 1:
              context.goNamed(ScreensNames.search);
              break;
            case 2:
              context.goNamed(ScreensNames.admin);
              break;
            case 3:
              context.goNamed(ScreensNames.profile);
              break;
            case 4:
              context.goNamed(ScreensNames.settings);
              break;
          }
        },
      ),
    );
  }

  List<Widget> _buildScreens() {
    return [
      const HomeScreen(),
      const SearchScreen(),
      AdminScreen(),
      const ProfileScreen(),
      const SettingsScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarItems(BuildContext context) {
    return [
      PersistentBottomNavBarItem(
        icon: const Padding(
          padding: EdgeInsets.only(top: 12.0),
          child: Icon(Icons.home_outlined),
        ),
        title: AppLocalizations.of(context)!.home,
        activeColorPrimary: Theme.of(context).colorScheme.primary,
        inactiveColorPrimary: Theme.of(context).colorScheme.inverseSurface,
      ),
      PersistentBottomNavBarItem(
        icon: const Padding(
          padding: EdgeInsets.only(top: 12.0),
          child: Icon(Icons.search),
        ),
        title: AppLocalizations.of(context)!.search,
        activeColorPrimary: Theme.of(context).colorScheme.primary,
        inactiveColorPrimary: Theme.of(context).colorScheme.inverseSurface,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          Icons.admin_panel_settings_outlined,
          color: Theme.of(context).colorScheme.surface,
        ),
        inactiveIcon: Icon(
          Icons.admin_panel_settings_outlined,
          color: Theme.of(context).colorScheme.inverseSurface,
        ),
        title: AppLocalizations.of(context)!.admin,
        activeColorPrimary: Theme.of(context).colorScheme.primary,
        inactiveColorPrimary: Theme.of(context).colorScheme.inverseSurface,
      ),
      PersistentBottomNavBarItem(
        icon: const Padding(
          padding: EdgeInsets.only(top: 12.0),
          child: Icon(Icons.person_outline),
        ),
        title: AppLocalizations.of(context)!.profile,
        activeColorPrimary: Theme.of(context).colorScheme.primary,
        inactiveColorPrimary: Theme.of(context).colorScheme.inverseSurface,
      ),
      PersistentBottomNavBarItem(
        icon: const Padding(
          padding: EdgeInsets.only(top: 12.0),
          child: Icon(Icons.settings_outlined),
        ),
        title: AppLocalizations.of(context)!.settings,
        activeColorPrimary: Theme.of(context).colorScheme.primary,
        inactiveColorPrimary: Theme.of(context).colorScheme.inverseSurface,
      ),
    ];
  }
}
