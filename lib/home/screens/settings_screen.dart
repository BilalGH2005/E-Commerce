import 'package:e_commerce/app/cubit/app_cubit.dart';
import 'package:e_commerce/core/themes/const_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../auth/cubit/auth_cubit.dart';
import '../../core/reusable_widgets/reusable_dropdown_button.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints:
              BoxConstraints(maxWidth: 768, minHeight: double.infinity),
          child: Padding(
            padding: const EdgeInsets.only(top: 32.0, left: 8, right: 8),
            child: BlocBuilder<AppCubit, AppState>(
              builder: (context, state) {
                final cubit = context.read<AppCubit>();
                return ListView(
                  children: [
                    ListTile(
                      trailing: Transform.scale(
                        scale: 0.7,
                        child: Switch(
                          thumbColor: WidgetStatePropertyAll(
                              Theme.of(context).colorScheme.inverseSurface),
                          value: cubit.isDarkTheme!,
                          onChanged: (newValue) async =>
                              await cubit.toggleTheme(newValue),
                        ),
                      ),
                      leading: Text(
                        AppLocalizations.of(context)!.switchAppTheme,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ),
                    ListTile(
                      leading: Text(
                        AppLocalizations.of(context)!.chooseAppLanguage,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: ReusableDropdownButton(
                        items: ['English', 'العربية'],
                        value: cubit.isArabic! ? 'العربية' : 'English',
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
                              await context.read<AuthCubit>().signOut();
                            },
                            child: Text(
                              AppLocalizations.of(context)!.signOut,
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(color: ConstColors.white),
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
}
