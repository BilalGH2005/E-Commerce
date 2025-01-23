import 'package:e_commerce/auth/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  static const String name = '/home_screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () async => context.read<AuthCubit>().signOut(),
            child: const Text('This is Home Screen'),
          ),
        ),
      );
}
