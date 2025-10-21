// ignore_for_file: deprecated_member_use

import 'package:e_commerce/core/utils/responsive_builder.dart';
import 'package:e_commerce/core/utils/shortcuts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../constants/assets.gen.dart';

class AppResponsiveBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const AppResponsiveBar(this.navigationShell, {super.key});

  @override
  Widget build(BuildContext context) => ResponsiveBuilder(
    mobile: (context) => BottomNavBar(navigationShell),
    tablet: (context) => SideBar(navigationShell),
  );
}

void onTap(int index, StatefulNavigationShell navigationShell) =>
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );

class BottomNavBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const BottomNavBar(this.navigationShell, {super.key});

  void _onTap(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(
    //   SystemUiOverlayStyle(
    //     statusBarColor: colorScheme(context).surface,
    //     statusBarIconBrightness: context.read<AppCubit>().isDarkTheme
    //         ? Brightness.light
    //         : Brightness.dark,
    //   ),
    // );

    return SafeArea(
      child: Scaffold(
        body: navigationShell,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: navigationShell.currentIndex,
          onTap: _onTap,
          type: BottomNavigationBarType.fixed,
          backgroundColor: colorScheme(context).surface,
          selectedItemColor: colorScheme(context).primary,
          unselectedItemColor: colorScheme(context).inverseSurface,
          selectedLabelStyle: const TextStyle(fontSize: 12),
          unselectedLabelStyle: const TextStyle(fontSize: 12),
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                Assets.icons.home,
                color: colorScheme(context).inverseSurface,
              ),
              activeIcon: SvgPicture.asset(
                Assets.icons.home,
                color: colorScheme(context).primary,
              ),
              label: localization(context).home,
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                Assets.icons.search,
                color: colorScheme(context).inverseSurface,
              ),
              activeIcon: SvgPicture.asset(
                Assets.icons.search,
                color: colorScheme(context).primary,
              ),
              label: localization(context).search,
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                Assets.icons.cart,
                color: colorScheme(context).inverseSurface,
              ),
              activeIcon: SvgPicture.asset(
                Assets.icons.cart,
                color: colorScheme(context).primary,
              ),
              label: localization(context).cart,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person_outline,
                color: colorScheme(context).inverseSurface,
              ),
              activeIcon: Icon(
                Icons.person_outline,
                color: colorScheme(context).primary,
              ),
              label: localization(context).profile,
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                Assets.icons.settings,
                color: colorScheme(context).inverseSurface,
              ),
              activeIcon: SvgPicture.asset(
                Assets.icons.settings,
                color: colorScheme(context).primary,
              ),
              label: localization(context).settings,
            ),
          ],
        ),
      ),
    );
  }
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
            unselectedIconTheme: Theme.of(
              context,
            ).iconTheme.copyWith(color: colorScheme(context).inverseSurface),
            unselectedLabelTextStyle: textTheme(context).displaySmall,
            selectedLabelTextStyle: textTheme(
              context,
            ).displaySmall!.copyWith(color: colorScheme(context).primary),
            selectedIconTheme: Theme.of(
              context,
            ).iconTheme.copyWith(color: colorScheme(context).primary),
            selectedIndex: navigationShell.currentIndex,
            onDestinationSelected: (index) => onTap(index, navigationShell),
            minWidth: 100,
            backgroundColor: colorScheme(context).surface,
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
            width: 1,
            color: colorScheme(context).tertiary,
            // thickness: 1,
          ),
          Expanded(child: navigationShell),
        ],
      ),
    ),
  );
}
