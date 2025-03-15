import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:e_commerce/core/routes/cubit/dashboard_cubit.dart';
import 'package:e_commerce/core/utils/constants/screens_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class BottomNavBar extends StatelessWidget {
  final Widget child;
  const BottomNavBar({required this.child, super.key});
  int _getSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    if (location == ScreensNames.home) return 0;
    if (location == ScreensNames.admin) return 1;
    if (location == ScreensNames.profile) return 2;
    if (location == ScreensNames.search) return 3;
    if (location == ScreensNames.settings) return 4;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashBoardCubit(),
      child: Scaffold(
        body: child,
        bottomNavigationBar: ConvexAppBar(
          curveSize: 0,
          style: TabStyle.fixedCircle,
          height: 76,
          activeColor: Theme.of(context).colorScheme.primary,
          color: Colors.black,
          backgroundColor: Colors.white,
          items: [
            TabItem(icon: Icons.home_outlined, title: 'Home'),
            TabItem(icon: Icons.person_outlined, title: 'Admin'),
            TabItem(icon: Icons.person, title: 'Profile'),
            TabItem(icon: Icons.search, title: 'Search'),
            TabItem(icon: Icons.settings_outlined, title: 'Settings'),
          ],
          initialActiveIndex: _getSelectedIndex(context),
          onTap: (index) {
            switch (index) {
              case 0:
                context.goNamed(ScreensNames.home);
                break;
              case 1:
                context.goNamed(ScreensNames.admin);
                break;
              case 2:
                context.goNamed(ScreensNames.profile);
                break;
              case 3:
                context.goNamed(ScreensNames.search);
                break;
              case 4:
                context.goNamed(ScreensNames.settings);
                break;
            }
          },
        ),
      ),
    );
  }
}
