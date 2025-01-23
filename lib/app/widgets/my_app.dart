import 'package:e_commerce/app/cubit/app_cubit.dart';
import 'package:e_commerce/core/router/app_router.dart';
import 'package:e_commerce/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../auth/cubit/auth_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AppCubit(),
            lazy: false,
          ),
          BlocProvider(
            create: (context) => AuthCubit(),
            lazy: false,
          ),
        ],
        child: MaterialApp.router(
          routerConfig: AppRouter().router,
          debugShowCheckedModeBanner: false,
          theme: ThemeData().copyWith(
              colorScheme:
                  ColorScheme.fromSeed(seedColor: Constants.kPrimaryColor)),
          darkTheme: ThemeData.dark().copyWith(
              colorScheme:
                  ColorScheme.fromSeed(seedColor: Constants.kPrimaryColor)),
          themeMode: ThemeMode.light,
        ),
      );
}
