import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_routes.dart';
import '../../../core/controllers/app_cubit.dart';
import '../cubit/login_callback_cubit.dart';

class LoginCallbackScreen extends StatelessWidget {
  const LoginCallbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCallbackCubit, LoginCallbackState>(
      listenWhen: (_, state) => state is LoginSuccessState,
      listener: (context, state) {
        if (state is LoginSuccessState) {
          if (!context.read<AppCubit>().seenGettingStarted) {
            context.goNamed(AppRoutes.gettingStarted.name);
          } else {
            context.goNamed(AppRoutes.home.name);
          }
        }
      },
      child: Scaffold(body: Center(child: CircularProgressIndicator())),
    );
  }
}
