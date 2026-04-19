import 'package:e_commerce/core/router/app_router.dart';
import 'package:e_commerce/core/themes/app_dark_theme.dart';
import 'package:e_commerce/core/themes/app_light_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:supabase_flutter/supabase_flutter.dart' show Supabase;
import 'package:toastification/toastification.dart';
import '../../../core/controllers/app_cubit.dart';
import 'auth/data/repos/auth_repo.dart';
import 'auth/presentation/controllers/auth_cubit.dart';
import 'core/constants/assets.gen.dart';
import 'core/localization/app_localizations.dart';
import 'core/utils/bloc_observer.dart';
import 'core/utils/dependency_injection.dart';

// ignore: unused_import, depend_on_referenced_packages
import 'package:device_preview/device_preview.dart';

// TODO: minimize app size
Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  _launchNativeSplashScreen(widgetsBinding);
  _initBlocObserver();
  await _initDependencies();
  await _initEnv();
  await _initSupabase();
  _initializeStripe();
  runApp(MyApp());
  // runApp(DevicePreview(builder: (context) => MyApp()));
  _removeNativeSplashScreen();
}

void _launchNativeSplashScreen(WidgetsBinding widgetsBinding) =>
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

void _initBlocObserver() => Bloc.observer = AppBlocObserver();

Future<void> _initializeStripe() async {
  final stripePublishableKey = dotenv.env['STRIPE_PUBLISHABLE_KEY']!;
  Stripe.publishableKey = stripePublishableKey;
}

Future<void> _initDependencies() async => await setupDependencyInjection();

Future<void> _initEnv() async => await dotenv.load(fileName: Assets.dotenv);

Future<void> _initSupabase() async {
  final anonKey = dotenv.env['SUPABASE_ANON_KEY']!;
  final url = dotenv.env['SUPABASE_URL']!;
  await Supabase.initialize(url: url, anonKey: anonKey);
}

void _removeNativeSplashScreen() => FlutterNativeSplash.remove();

Locale _themeLocaleFor(Locale? selectedLocale) {
  final locale = selectedLocale ?? WidgetsBinding.instance.platformDispatcher.locale;
  return locale.languageCode == 'ar' ? const Locale('ar') : const Locale('en');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppCubit()),
        BlocProvider(
          create: (context) => AuthCubit(serviceLocator<AuthRepo>()),
        ),
      ],
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return BlocBuilder<AppCubit, AppState>(
            builder: (context, state) {
              final cubit = context.read<AppCubit>();
              final selectedLocale = cubit.locale;
              final themeLocale = _themeLocaleFor(selectedLocale);
              return ToastificationWrapper(
                child: MaterialApp.router(
                  title: 'Stylish',
                  localizationsDelegates:
                      AppLocalizations.localizationsDelegates,
                  supportedLocales: AppLocalizations.supportedLocales,
                  locale: selectedLocale,
                  routerConfig: router,
                  debugShowCheckedModeBanner: false,
                  theme: AppLightTheme(themeLocale).lightTheme,
                  darkTheme: AppDarkTheme(themeLocale).darkTheme,
                  themeMode: cubit.themeMode,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
