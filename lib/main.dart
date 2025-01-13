import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app/widgets/my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  String anonKey = dotenv.env['SUPABASE_ANON_KEY']!;
  String url = dotenv.env['SUPABASE_URL']!;
  Supabase.initialize(url: url, anonKey: anonKey);
  runApp(Phoenix(child: MyApp()));
}
