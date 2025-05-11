// ignore: depend_on_referenced_packages
import 'package:e_commerce/app/widgets/material_app_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/utils/bloc_observer.dart';

late final SharedPreferences sharedPreferences;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  await dotenv.load(fileName: "dotenv");
  String anonKey = dotenv.env['SUPABASE_ANON_KEY']!;
  String url = dotenv.env['SUPABASE_URL']!;
  Supabase.initialize(url: url, anonKey: anonKey);
  Bloc.observer = AppBlocObserver();
  runApp(/*DevicePreview(builder: (context) => */ const MaterialAppClass());
}
