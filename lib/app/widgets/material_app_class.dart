import 'package:e_commerce/app/cubit/app_cubit.dart';
import 'package:e_commerce/core/routes/app_router.dart';
import 'package:e_commerce/core/themes/dark_theme.dart';
import 'package:e_commerce/core/themes/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../auth/cubit/auth_cubit.dart';

class MaterialAppClass extends StatelessWidget {
  const MaterialAppClass({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit(),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
      ],
      child: Builder(
        builder: (context) => MaterialApp.router(
          routerConfig: AppRouter().router,
          debugShowCheckedModeBanner: false,
          theme: LightTheme().lightTheme,
          darkTheme: DarkTheme().darkTheme,
          themeMode: context.watch<AppCubit>().isDarkTheme!
              ? ThemeMode.dark
              : ThemeMode.light,
        ),
      ),
    );
  }
}
