import 'package:e_commerce/auth/cubit/auth_cubit.dart';
import 'package:e_commerce/auth/screens/reset_password_screen.dart';
import 'package:e_commerce/auth/screens/sign_up_screen.dart';
import 'package:e_commerce/auth/widgets/obscure_button.dart';
import 'package:e_commerce/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../widgets/auth_field.dart';
import '../widgets/oauth_widget.dart';
import '../widgets/reusable_button.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});
  static const String name = '/sign_in_screen';

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
                  height: 392,
                  child: BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      final AuthCubit cubit = context.read<AuthCubit>();
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Text(
                                'Welcome\nBack!',
                                textAlign: TextAlign.start,
                                style: Constants.kTitleTextStyle,
                              ),
                            ],
                          ),
                          AuthField(
                              controller: cubit.emailTextController,
                              label: 'Email',
                              keyboardType: TextInputType.emailAddress,
                              icon: const Icon(Icons.person),
                              validator: (value) =>
                                  AuthCubit.emailValidator(value)),
                          AuthField(
                              controller: cubit.passwordTextController,
                              isObscure: cubit.isPasswordObscure,
                              suffixIcon: ObscureButton(
                                  isObscure: cubit.isPasswordObscure,
                                  onPressed: () =>
                                      cubit.togglePasswordObscure()),
                              label: 'Password',
                              icon: const Icon(Icons.lock),
                              validator: (value) =>
                                  AuthCubit.passwordValidator(value)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () =>
                                    context.pushNamed(ResetPasswordScreen.name),
                                child: Text(
                                  'Forgot password?',
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 12,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                ),
                              ),
                            ],
                          ),
                          ReusableButton(
                            onPressed: () async =>
                                await cubit.formsAuthentication(
                                    context: context,
                                    formKey: formKey,
                                    screen: name),
                            label: 'Login',
                          )
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(height: 74),
                SizedBox(
                  width: 236,
                  height: 154,
                  child: OAuthButtons(
                    label: 'Create an account',
                    buttonText: 'Sign up',
                    onPressed: () => context.pushNamed(SignUpScreen.name),
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
