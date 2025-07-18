import 'package:e_commerce/auth/cubit/auth_cubit.dart';
import 'package:e_commerce/auth/presentation/widgets/sign_in_form.dart';
import 'package:e_commerce/auth/presentation/widgets/sign_up_form.dart';
import 'package:e_commerce/core/constants/app_breakpoints.dart';
import 'package:e_commerce/core/constants/app_images.dart';
import 'package:e_commerce/core/utils/duration_extension.dart';
import 'package:e_commerce/core/utils/localization.dart';
import 'package:e_commerce/core/utils/responsive_builder.dart';
import 'package:e_commerce/core/utils/snackbar_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocConsumer<AuthCubit, AuthCubitState>(
        listenWhen: (_, state) =>
            state is AuthFailure || state is AuthSuccessSignUp,
        listener: (context, state) {
          if (state is AuthFailure) {
            SnackBarUtil.showError(
                localization(context).authError(state.errorCode));
          } else if (state is AuthSuccessSignUp) {
            SnackBarUtil.showSuccess(
                localization(context).checkEmailForVerification);
          }
        },
        builder: (context, state) {
          final cubit = context.read<AuthCubit>();
          return Scaffold(
            body: ResponsiveBuilder(
              mobile: (context) => FormSwitcher(isSignIn: cubit.isSignIn),
              tablet: (context) {
                final width = MediaQuery.sizeOf(context).width;
                return Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(AppImages.kGettingStarted),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth:
                            width >= AppBreakpoints.kDesktopWidth ? 600 : 420,
                        minHeight: double.infinity,
                      ),
                      child: FormSwitcher(isSignIn: cubit.isSignIn),
                    ),
                  ],
                );
              },
            ),
          );
        },
      );
}

class FormSwitcher extends StatelessWidget {
  final bool isSignIn;

  const FormSwitcher({
    super.key,
    required this.isSignIn,
  });

  @override
  Widget build(BuildContext context) => AnimatedSwitcher(
        duration: 600.ms,
        transitionBuilder: (child, animation) {
          final slideAnimation = Tween<Offset>(
            begin: const Offset(0.0, 0.6),
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
                key: const ValueKey('signIn'),
              )
            : signUpForm(
                context: context,
                key: const ValueKey('signUp'),
              ),
      );
}
