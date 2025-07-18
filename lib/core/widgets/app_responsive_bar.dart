import 'package:e_commerce/core/utils/localization.dart';
import 'package:e_commerce/core/utils/responsive_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../constants/app_icons.dart';

class AppResponsiveBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const AppResponsiveBar(this.navigationShell, {super.key});

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
    //     statusBarColor: Theme.of(context).colorScheme.surface,
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
          backgroundColor: Theme.of(context).colorScheme.surface,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Theme.of(context).colorScheme.inverseSurface,
          selectedLabelStyle: const TextStyle(fontSize: 12),
          unselectedLabelStyle: const TextStyle(fontSize: 12),
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppIcons.home,
                color: Theme.of(context).colorScheme.inverseSurface,
              ),
              activeIcon: SvgPicture.asset(
                AppIcons.home,
                color: Theme.of(context).colorScheme.primary,
              ),
              label: localization(context).home,
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppIcons.search,
                color: Theme.of(context).colorScheme.inverseSurface,
              ),
              activeIcon: SvgPicture.asset(
                AppIcons.search,
                color: Theme.of(context).colorScheme.primary,
              ),
              label: localization(context).search,
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(AppIcons.cart,
                  color: Theme.of(context).colorScheme.inverseSurface),
              activeIcon: SvgPicture.asset(
                AppIcons.cart,
                color: Theme.of(context).colorScheme.primary,
              ),
              label: localization(context).cart,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person_outline,
                color: Theme.of(context).colorScheme.inverseSurface,
              ),
              activeIcon: Icon(
                Icons.person_outline,
                color: Theme.of(context).colorScheme.primary,
              ),
              label: localization(context).profile,
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppIcons.settings,
                color: Theme.of(context).colorScheme.inverseSurface,
              ),
              activeIcon: SvgPicture.asset(
                AppIcons.settings,
                color: Theme.of(context).colorScheme.primary,
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
