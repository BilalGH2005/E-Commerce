import 'package:e_commerce/admin/screens/admin_screen.dart';
import 'package:e_commerce/app/cubit/app_cubit.dart';
import 'package:e_commerce/core/utils/localization.dart';
import 'package:e_commerce/core/utils/responsive_builder.dart';
import 'package:e_commerce/home/screens/home_screen.dart';
import 'package:e_commerce/home/screens/profile_screen.dart';
import 'package:e_commerce/home/screens/search_screen.dart';
import 'package:e_commerce/home/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class ResponsiveBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const ResponsiveBar(this.navigationShell, {super.key});

  @override
  Widget build(BuildContext context) => ResponsiveBuilder(
        mobile: (context) => BottomNavBar(navigationShell),
        tablet: (context) => SideBar(navigationShell),
      );
}

void onTap(index, StatefulNavigationShell navigationShell) => navigationShell
    .goBranch(index, initialLocation: index == navigationShell.currentIndex);

class BottomNavBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const BottomNavBar(this.navigationShell, {super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Theme.of(context).colorScheme.surface,
      statusBarIconBrightness: context.read<AppCubit>().isDarkTheme
          ? Brightness.light
          : Brightness.dark,
    ));

    return SafeArea(
      child: Scaffold(
        body: navigationShell,
        bottomNavigationBar: PersistentTabView(
          context,
          controller: PersistentTabController(
              initialIndex: navigationShell.currentIndex),
          screens: _buildScreens(),
          items: _navBarItems(context),
          navBarStyle: NavBarStyle.style15,
          backgroundColor: Theme.of(context).colorScheme.surface,
          navBarHeight: 60,
          onItemSelected: (index) => onTap(index, navigationShell),
        ),
      ),
    );
  }

  List<Widget> _buildScreens() => [
        const HomeScreen(),
        const SearchScreen(),
        AdminScreen(),
        ProfileScreen(),
        const SettingsScreen(),
      ];

  List<PersistentBottomNavBarItem> _navBarItems(BuildContext context) => [
        PersistentBottomNavBarItem(
          icon: const Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: Icon(Icons.home_outlined),
          ),
          title: localization(context).home,
          activeColorPrimary: Theme.of(context).colorScheme.primary,
          inactiveColorPrimary: Theme.of(context).colorScheme.inverseSurface,
        ),
        PersistentBottomNavBarItem(
          icon: const Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: Icon(Icons.search),
          ),
          title: localization(context).search,
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
          title: localization(context).admin,
          activeColorPrimary: Theme.of(context).colorScheme.primary,
          inactiveColorPrimary: Theme.of(context).colorScheme.inverseSurface,
        ),
        PersistentBottomNavBarItem(
          icon: const Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: Icon(Icons.person_outline),
          ),
          title: localization(context).profile,
          activeColorPrimary: Theme.of(context).colorScheme.primary,
          inactiveColorPrimary: Theme.of(context).colorScheme.inverseSurface,
        ),
        PersistentBottomNavBarItem(
          icon: const Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: Icon(Icons.settings_outlined),
          ),
          title: localization(context).settings,
          activeColorPrimary: Theme.of(context).colorScheme.primary,
          inactiveColorPrimary: Theme.of(context).colorScheme.inverseSurface,
        ),
      ];
}

class SideBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const SideBar(this.navigationShell, {super.key});

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
                selectedIndex: navigationShell.currentIndex,
                onDestinationSelected: (index) => onTap(index, navigationShell),
                minWidth: 100,
                backgroundColor: Theme.of(context).colorScheme.surface,
                leading: const SizedBox(height: 24),
                destinations: [
                  NavigationRailDestination(
                    icon: const Icon(Icons.home_outlined),
                    label: Text(localization(context).home),
                  ),
                  NavigationRailDestination(
                    icon: const Icon(Icons.search),
                    label: Text(localization(context).search),
                  ),
                  NavigationRailDestination(
                    icon: const Icon(Icons.admin_panel_settings_outlined),
                    label: Text(localization(context).admin),
                  ),
                  NavigationRailDestination(
                    icon: const Icon(Icons.person_outline),
                    label: Text(localization(context).profile),
                  ),
                  NavigationRailDestination(
                    icon: const Icon(Icons.settings_outlined),
                    label: Text(localization(context).settings),
                  ),
                ],
              ),
              VerticalDivider(
                width: 1, color: Theme.of(context).colorScheme.tertiary,
                // thickness: 1,
              ),
              Expanded(child: navigationShell),
            ],
          ),
        ),
      );
}
