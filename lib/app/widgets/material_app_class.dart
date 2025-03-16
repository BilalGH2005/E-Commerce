import 'package:e_commerce/app/cubit/app_cubit.dart';
import 'package:e_commerce/core/routes/app_router.dart';
import 'package:e_commerce/core/themes/dark_theme.dart';
import 'package:e_commerce/core/themes/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
          title: 'E-Commerce',
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          locale: context.watch<AppCubit>().isArabic!
              ? const Locale('ar')
              : const Locale('en'),
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
