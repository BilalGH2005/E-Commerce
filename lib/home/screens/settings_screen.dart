import 'package:e_commerce/app/cubit/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 24.0, left: 8, right: 8),
        child: BlocBuilder<AppCubit, AppState>(
          builder: (context, state) {
            final cubit = context.read<AppCubit>();
            return ListView(
              children: [
                ListTile(
                  leading: Checkbox(
                    checkColor: Theme.of(context).colorScheme.inverseSurface,
                    value: cubit.isDarkTheme,
                    onChanged: (newValue) {
                      cubit.toggleTheme(newValue);
                    },
                  ),
                  title: Text(
                    AppLocalizations.of(context)!.switchToDarkMode,
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: Theme.of(context).colorScheme.inverseSurface),
                  ),
                ),
                ListTile(
                  leading: Checkbox(
                    checkColor: Colors.white,
                    value: cubit.isArabic,
                    onChanged: (newValue) {
                      cubit.toggleLocale(newValue);
                    },
                  ),
                  title: Text(
                    AppLocalizations.of(context)!.switchToEnglish,
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: Theme.of(context).colorScheme.inverseSurface),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
