import 'package:e_commerce/core/constants/app_breakpoints.dart';
import 'package:e_commerce/core/utils/shortcuts.dart';
import 'package:e_commerce/core/widgets/app_dropdown_button.dart';
import 'package:e_commerce/settings/cubit/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_routes.dart';
import '../../../core/constants/assets.gen.dart';
import '../../../core/cubit/app_cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: AppBreakpoints.kTabletWidth,
          minHeight: double.infinity,
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: BlocBuilder<AppCubit, AppState>(
            builder: (context, state) {
              final cubit = context.read<AppCubit>();
              return ListView(
                children: [
                  ListTile(
                    leading: SvgPicture.asset(
                      Assets.icons.theme,
                      colorFilter: ColorFilter.mode(
                        colorScheme(context).inverseSurface,
                        BlendMode.srcIn,
                      ),
                    ),
                    title: Text(
                      localization(context).switchAppTheme,
                      style: textTheme(context).displayMedium,
                    ),
                    dense: true,
                    trailing: Transform.scale(
                      scale: 0.8,
                      child: Switch(
                        value: cubit.isDarkTheme,
                        onChanged: (newValue) async =>
                            await cubit.toggleTheme(newValue),
                      ),
                    ),
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      Assets.icons.globe,
                      colorFilter: ColorFilter.mode(
                        colorScheme(context).inverseSurface,
                        BlendMode.srcIn,
                      ),
                    ),
                    title: Text(
                      localization(context).chooseAppLanguage,
                      style: textTheme(context).displayMedium,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: AppDropdownButton(
                      items: ['English', 'العربية'],
                      value: cubit.isArabic ? 'العربية' : 'English',
                      onChanged: (newValue) async =>
                          await cubit.localeValue(newValue),
                    ),
                  ),
                  ListTile(
                    onTap: () async {
                      await context.read<SettingsCubit>().signOut();
                      context.goNamed(AppRoutes.auth.name);
                    },
                    leading: SvgPicture.asset(
                      Assets.icons.signOut,
                      colorFilter: ColorFilter.mode(
                        colorScheme(context).inverseSurface,
                        BlendMode.srcIn,
                      ),
                    ),
                    title: Text(
                      localization(context).signOut,
                      style: textTheme(context).displayMedium,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    ),
  );
}
