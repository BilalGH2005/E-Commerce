import 'package:e_commerce/auth/cubit/auth_cubit.dart';
import 'package:e_commerce/auth/widgets/sign_in_form.dart';
import 'package:e_commerce/auth/widgets/sign_up_form.dart';
import 'package:e_commerce/core/constants/assets.dart';
import 'package:e_commerce/core/utils/duration_extension.dart';
import 'package:e_commerce/core/utils/responsive_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({super.key});

  final GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final isSignIn = context.watch<AuthCubit>().isSignIn;

    return Scaffold(
      body: ResponsiveBuilder(
        mobile: (context) => FormSwitcher(
          isSignIn: isSignIn,
          signInFormKey: signInFormKey,
          signUpFormKey: signUpFormKey,
        ),
        tablet: (context) {
          final width = MediaQuery.sizeOf(context).width;
          return Row(
            children: [
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(Assets.kGettingStarted),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth:
                      getDeviceType(width) == DeviceType.desktop ? 600 : 420,
                  minHeight: double.infinity,
                ),
                child: FormSwitcher(
                  isSignIn: isSignIn,
                  signInFormKey: signInFormKey,
                  signUpFormKey: signUpFormKey,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class FormSwitcher extends StatelessWidget {
  final bool isSignIn;
  final GlobalKey<FormState> signInFormKey;
  final GlobalKey<FormState> signUpFormKey;

  const FormSwitcher({
    super.key,
    required this.isSignIn,
    required this.signInFormKey,
    required this.signUpFormKey,
  });

  @override
  Widget build(BuildContext context) => AnimatedSwitcher(
        duration: 600.ms,
        transitionBuilder: (child, animation) {
          final slideAnimation = Tween<Offset>(
            begin: const Offset(0.0, 0.4),
            end: Offset.zero,
          ).animate(animation);
          return SlideTransition(
            position: slideAnimation,
            child: FadeTransition(opacity: animation, child: child),
          );
        },
        child: isSignIn
            ? signInForm(
                context: context,
                formKey: signInFormKey,
                key: const ValueKey('signIn'),
              )
            : signUpForm(
                context: context,
                formKey: signUpFormKey,
                key: const ValueKey('signUp'),
              ),
      );
}
