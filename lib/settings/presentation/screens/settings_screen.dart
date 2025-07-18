import 'package:e_commerce/core/constants/app_breakpoints.dart';
import 'package:e_commerce/core/constants/app_colors.dart';
import 'package:e_commerce/core/utils/localization.dart';
import 'package:e_commerce/core/widgets/app_dropdown_button.dart';
import 'package:e_commerce/settings/cubit/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_routes.dart';
import '../../../core/cubit/app_cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
                maxWidth: AppBreakpoints.kTabletWidth,
                minHeight: double.infinity),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: BlocBuilder<AppCubit, AppState>(
                builder: (context, state) {
                  final cubit = context.read<AppCubit>();
                  return ListView(
                    children: [
                      SwitchListTile(
                        value: cubit.isDarkTheme,
                        onChanged: (newValue) async =>
                            await cubit.toggleTheme(newValue),
                        title: Text(
                          localization(context).switchAppTheme,
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        dense: true,
                        // Reduces vertical padding
                        controlAffinity: ListTileControlAffinity
                            .trailing, // Ensures switch stays on right
                      ),
                      ListTile(
                        leading: Text(
                          localization(context).chooseAppLanguage,
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: AppDropdownButton(
                          items: ['English', 'العربية'],
                          value: cubit.isArabic ? 'العربية' : 'English',
                          onChanged: (newValue) async =>
                              await cubit.localeValue(newValue),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.error,
                                  fixedSize: const Size(150, 30),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8))),
                              onPressed: () async {
                                await context.read<SettingsCubit>().signOut();
                                context.goNamed(AppRoutes.auth.name);
                              },
                              child: context.read<SettingsCubit>().isLoading
                                  ? CircularProgressIndicator()
                                  : Text(
                                      localization(context).signOut,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall!
                                          .copyWith(color: AppColors.white),
                                    ),
                            ),
                          ),
                        ],
                      )
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      );
}
