import 'package:e_commerce/app/cubit/app_cubit.dart';
import 'package:e_commerce/core/routes/app_router.dart';
import 'package:e_commerce/core/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../auth/cubit/auth_cubit.dart';

class MaterialAppClass extends StatelessWidget {
  const MaterialAppClass({super.key});

  @override
  Widget build(BuildContext context) {
    Themes themes = Themes();
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
      child: MaterialApp.router(
        routerConfig: AppRouter().router,
        debugShowCheckedModeBanner: false,
        theme: themes.lightTheme,
        darkTheme: themes.darkTheme,
        themeMode: ThemeMode.light,
      ),
    );
  }
}
