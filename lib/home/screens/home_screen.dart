import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class HomeScreen extends StatelessWidget {
  static const String id = 'home_screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            child: Text('Restart'),
            onPressed: () {
              Phoenix.rebirth(context);
            }),
      ),
    );
  }
}
