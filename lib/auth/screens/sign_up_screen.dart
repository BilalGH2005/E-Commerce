import 'package:e_commerce/auth/widgets/oauth_widget.dart';
import 'package:e_commerce/core/utils/constants/screens_names.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/widgets/reusable_button.dart';
import '../cubit/auth_cubit.dart';
import '../widgets/auth_field.dart';
import '../widgets/obscure_button.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.only(
                top: 48.0, bottom: 29.0, right: 29.0, left: 29.0),
            child: Column(
              children: [
                SizedBox(
                  height: 488,
                  child: BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      final AuthCubit cubit = context.read<AuthCubit>();
                      final bool isLoading = cubit.authStatus == 0;
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Create an\naccount',
                                textAlign: TextAlign.start,
                                style:
                                    Theme.of(context).textTheme.headlineLarge,
                              ),
                            ],
                          ),
                          AuthField(
                            controller: cubit.emailTextController,
                            label: 'Email',
                            keyboardType: TextInputType.emailAddress,
                            prefixIcon: const Icon(Icons.person),
                            validator: (value) =>
                                AuthCubit.emailValidator(value),
                          ),
                          AuthField(
                            controller: cubit.passwordTextController,
                            isObscure: cubit.isPasswordObscure,
                            suffixIcon: ObscureButton(
                                isObscure: cubit.isPasswordObscure,
                                onPressed: () => context
                                    .read<AuthCubit>()
                                    .togglePasswordObscure('password')),
                            label: 'Password',
                            prefixIcon: const Icon(Icons.lock),
                            validator: (value) =>
                                AuthCubit.passwordValidator(value),
                          ),
                          AuthField(
                            controller: cubit.confirmPasswordTextController,
                            isObscure: cubit.isConfirmPasswordObscure,
                            suffixIcon: ObscureButton(
                                isObscure: cubit.isConfirmPasswordObscure,
                                onPressed: () => context
                                    .read<AuthCubit>()
                                    .togglePasswordObscure('confirmPassword')),
                            label: 'Confirm password',
                            prefixIcon: const Icon(Icons.lock),
                            validator: (value) =>
                                AuthCubit.confirmPasswordValidator(
                                    value: value,
                                    passwordTextController:
                                        cubit.passwordTextController),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  text:
                                      'By clicking the Create Account button, you\nagree to ',
                                  style: Theme.of(context).textTheme.bodySmall,
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'our terms',
                                      style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 12,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                        decoration: TextDecoration.underline,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          context.pushNamed(ScreensNames.terms);
                                        },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          ReusableButton(
                            onPressed: isLoading
                                ? () async => await cubit.authentication(
                                    formKey: formKey,
                                    screen: ScreensNames.signUp)
                                : null,
                            label: isLoading
                                ? Text('Create Account',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium)
                                : CircularProgressIndicator(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(height: 40),
                SizedBox(
                  width: 260,
                  height: 154,
                  child: OAuthWidget(
                    label: 'I already have an account',
                    buttonText: 'Sign in',
                    onPressed: () => context.pushNamed(ScreensNames.signIn),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
