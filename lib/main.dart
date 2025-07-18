import 'package:e_commerce/core/router/app_router.dart';
import 'package:e_commerce/core/themes/app_dark_theme.dart';
import 'package:e_commerce/core/themes/app_light_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:toastification/toastification.dart';

import '../../../core/cubit/app_cubit.dart';
import 'core/utils/bloc_observer.dart';
import 'core/utils/dependency_injection.dart';

Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  _launchNativeSplashScreen(widgetsBinding);
  _initBlocObserver();
  await _initDependencies();
  await _initEnv();
  await _initSupabase();
  runApp(const MyApp());
  // runApp(DevicePreview(builder: (context) => const MyApp()));
  _removeNativeSplashScreen();
}

void _launchNativeSplashScreen(WidgetsBinding widgetsBinding) {
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
}

void _initBlocObserver() => Bloc.observer = AppBlocObserver();

Future<void> _initDependencies() async => await setupDependencyInjection();

Future<void> _initEnv() async => await dotenv.load(fileName: "dotenv");

Future<void> _initSupabase() async {
  final anonKey = dotenv.env['SUPABASE_ANON_KEY']!;
  final url = dotenv.env['SUPABASE_URL']!;
  await Supabase.initialize(url: url, anonKey: anonKey);
}

void _removeNativeSplashScreen() {
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => AppCubit(),
        child: BlocBuilder<AppCubit, AppState>(
          builder: (context, state) {
            final cubit = context.read<AppCubit>();
            final locale =
                cubit.isArabic ? const Locale('ar') : const Locale('en');
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
