import 'package:e_commerce/app/cubit/app_cubit.dart';
import 'package:e_commerce/auth/screens/reset_password_screen.dart';
import 'package:e_commerce/auth/screens/sign_in_screen.dart';
import 'package:e_commerce/auth/screens/sign_up_screen.dart';
import 'package:e_commerce/auth/screens/terms_screen.dart';
import 'package:e_commerce/home/screens/home_screen.dart';
import 'package:e_commerce/onboarding/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/cubit/auth_cubit.dart';
import '../../../onboarding/screens/onboarding_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => AppCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => AuthCubit(),
        ),
      ],
      child: MaterialApp(
        navigatorKey: context.read<AppCubit>().navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData().copyWith(
            colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFFF83758))),
        initialRoute: SplashScreen.id,
        routes: {
          SplashScreen.id: (context) => SplashScreen(),
          OnBoardingScreen.id: (context) => OnBoardingScreen(),
          SignInScreen.id: (context) => SignInScreen(),
          SignUpScreen.id: (context) => SignUpScreen(),
          TermsScreen.id: (context) => TermsScreen(),
          ResetPasswordScreen.id: (context) => ResetPasswordScreen(),
          HomeScreen.id: (context) => HomeScreen(),
        },
      ),
    );
  }
}
