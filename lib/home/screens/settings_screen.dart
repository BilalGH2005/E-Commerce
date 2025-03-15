import 'package:e_commerce/app/cubit/app_cubit.dart';
import 'package:e_commerce/core/widgets/reusable_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../auth/cubit/auth_cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(6.0),
        child: ListView(
          children: [
            BlocBuilder<AppCubit, AppState>(
              builder: (context, state) {
                final cubit = context.read<AppCubit>();
                return ListTile(
                  leading: Checkbox(
                    value: cubit.isDarkTheme,
                    onChanged: (newValue) {
                      cubit.toggleTheme(newValue);
                    },
                  ),
                  title: Text('Change theme mode'),
                );
              },
            ),
            ReusableButton(
                onPressed: () {
                  context.read<AuthCubit>().signOut();
                },
                label: Text('Sign Out'))
          ],
        ),
      ),
    );
  }
}
