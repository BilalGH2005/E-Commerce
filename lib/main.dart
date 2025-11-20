import 'package:e_commerce/core/router/app_router.dart';
import 'package:e_commerce/core/themes/app_dark_theme.dart';
import 'package:e_commerce/core/themes/app_light_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:toastification/toastification.dart';

// ignore: depend_on_referenced_packages
import 'package:device_preview/device_preview.dart';
import '../../../core/controllers/app_cubit.dart';
import 'core/constants/assets.gen.dart';
import 'core/localization/app_localizations.dart';
import 'core/utils/bloc_observer.dart';
import 'core/utils/dependency_injection.dart';

// TODO: fix app router
// TODO: turn back from forgot password screen to auth screen
// TODO: Oauth is corrupted
// TODO: set theme to notification bar in splash
// TODO:filters bottom sheet overflow on desktop
// TODO: add single child scroll view to prevent render flex in getting started screen
// TODO:splash icon size is too big and not appearing on all devices
// TODO:complete reset password flow

Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  _launchNativeSplashScreen(widgetsBinding);
  _initBlocObserver();
  await _initDependencies();
  await _initEnv();
  await _initSupabase();
  _initializeStripe();
  // runApp(const MyApp());
  runApp(DevicePreview(builder: (context) => const MyApp()));
  _removeNativeSplashScreen();
}

void _launchNativeSplashScreen(WidgetsBinding widgetsBinding) {
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
}

void _initBlocObserver() => Bloc.observer = AppBlocObserver();

Future<void> _initializeStripe() async {
  final stripePublishableKey = dotenv.env['STRIPE_PUBLISHABLE_KEY']!;
  Stripe.publishableKey = stripePublishableKey;
  // await Stripe.instance.applySettings();
}

Future<void> _initDependencies() async => await setupDependencyInjection();

Future<void> _initEnv() async => await dotenv.load(fileName: Assets.dotenv);

Future<void> _initSupabase() async {
  final anonKey = dotenv.env['SUPABASE_ANON_KEY']!;
  final url = dotenv.env['SUPABASE_URL']!;
  await Supabase.initialize(url: url, anonKey: anonKey);
}

void _removeNativeSplashScreen() => FlutterNativeSplash.remove();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) => AppCubit(),
    child: BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        final cubit = context.read<AppCubit>();
        final locale = cubit.isArabic ? const Locale('ar') : const Locale('en');
        return ToastificationWrapper(
          child: MaterialApp.router(
            title: 'Stylish',
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            locale: locale,
            routerConfig: router,
            debugShowCheckedModeBanner: false,
            theme: AppLightTheme(locale).lightTheme,
            darkTheme: AppDarkTheme(locale).darkTheme,
            themeMode: cubit.isDarkTheme ? ThemeMode.dark : ThemeMode.light,
          ),
        );
      },
    ),
  );
}
