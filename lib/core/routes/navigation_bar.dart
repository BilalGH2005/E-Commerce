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

class NavigationBars extends StatelessWidget {
  final Widget child;
  const NavigationBars({required this.child, super.key});

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          return constraints.maxWidth > 768
              ? SideBar(child: child)
              : BottomNavBar(child: child);
        },
      );
}

int _getSelectedIndex(BuildContext context) {
  final String location = GoRouterState.of(context).uri.toString();
  if (location == ScreensNames.home) return 0;
  if (location == ScreensNames.search) return 1;
  if (location == ScreensNames.admin) return 2;
  if (location == ScreensNames.profile) return 3;
  if (location == ScreensNames.settings) return 4;
  return 0;
}

void _onItemSelected(int index, BuildContext context) {
  switch (index) {
    case 0:
      context.goNamed(ScreensNames.home);
      break;
    case 1:
      context.goNamed(ScreensNames.search);
      break;
    case 2:
      context.goNamed(ScreensNames.admin);
      FocusScope.of(context).requestFocus();
      break;
    case 3:
      context.goNamed(ScreensNames.profile);
      break;
    case 4:
      context.goNamed(ScreensNames.settings);
      break;
  }
}

class BottomNavBar extends StatelessWidget {
  final Widget child;
  const BottomNavBar({required this.child, super.key});

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          body: child,
          bottomNavigationBar: PersistentTabView(
            context,
            controller: PersistentTabController(
                initialIndex: _getSelectedIndex(context)),
            screens: _buildScreens(),
            items: _navBarItems(context),
            navBarStyle: NavBarStyle.style15,
            backgroundColor: Theme.of(context).colorScheme.surface,
            navBarHeight: 60,
            onItemSelected: (index) => _onItemSelected(index, context),
          ),
        ),
      );

  List<Widget> _buildScreens() => [
        HomeScreen(),
        const SearchScreen(),
        AdminScreen(),
        const ProfileScreen(),
        const SettingsScreen(),
      ];

  List<PersistentBottomNavBarItem> _navBarItems(BuildContext context) => [
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

class SideBar extends StatelessWidget {
  final Widget child;
  const SideBar({required this.child, super.key});

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          body: Row(
            children: [
              NavigationRail(
                useIndicator: false,
                labelType: NavigationRailLabelType.all,
                unselectedIconTheme: Theme.of(context).iconTheme.copyWith(
                    color: Theme.of(context).colorScheme.inverseSurface),
                unselectedLabelTextStyle:
                    Theme.of(context).textTheme.displaySmall,
                selectedLabelTextStyle: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(color: Theme.of(context).colorScheme.primary),
                selectedIconTheme: Theme.of(context)
                    .iconTheme
                    .copyWith(color: Theme.of(context).colorScheme.primary),
                selectedIndex: _getSelectedIndex(context),
                onDestinationSelected: (index) =>
                    _onItemSelected(index, context),
                minWidth: 100,
                backgroundColor: Theme.of(context).colorScheme.surface,
                leading: const SizedBox(height: 24),
                destinations: [
                  NavigationRailDestination(
                    icon: const Icon(Icons.home_outlined),
                    label: Text(AppLocalizations.of(context)!.home),
                  ),
                  NavigationRailDestination(
                    icon: const Icon(Icons.search),
                    label: Text(AppLocalizations.of(context)!.search),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.admin_panel_settings_outlined),
                    label: Text(AppLocalizations.of(context)!.admin),
                  ),
                  NavigationRailDestination(
                    icon: const Icon(Icons.person_outline),
                    label: Text(AppLocalizations.of(context)!.profile),
                  ),
                  NavigationRailDestination(
                    icon: const Icon(Icons.settings_outlined),
                    label: Text(AppLocalizations.of(context)!.settings),
                  ),
                ],
              ),
              VerticalDivider(
                width: 1, color: Theme.of(context).colorScheme.tertiary,
                // thickness: 1,
              ),
              Expanded(child: child),
            ],
          ),
        ),
      );
}
