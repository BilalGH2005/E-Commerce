import 'package:e_commerce/auth/cubit/auth_cubit.dart';
import 'package:e_commerce/auth/screens/reset_password_screen.dart';
import 'package:e_commerce/auth/screens/sign_up_screen.dart';
import 'package:e_commerce/core/utils/constants.dart';
import 'package:e_commerce/core/utils/snackbar_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/auth_field.dart';
import '../widgets/oauth_button.dart';
import '../widgets/reusable_button.dart';

class SignInScreen extends StatefulWidget {
  static const String id = 'sign_in_screen';
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  void initState() {
    //TODO: imp(3) - replace the initState with the cubit initial state (HMEDY)
    context.read<AuthCubit>().handleIncomingLinks(context);
    super.initState();
  }

  final formKey = GlobalKey<FormState>();

  final TextEditingController emailTextController = TextEditingController(),
      passwordTextController = TextEditingController();

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
                  width: 320,
                  height: 392,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Text(
                            'Welcome\nBack!',
                            textAlign: TextAlign.start,
                            style: kTitleTextStyle,
                          ),
                        ],
                      ),
                      AuthField(
                          key: ValueKey('email'),
                          controller: emailTextController,
                          label: 'Username or Email',
                          icon: const Icon(Icons.person),
                          validator: (value) =>
                              AuthCubit.emailValidator(value)),
                      AuthField(
                          key: ValueKey('password'),
                          controller: passwordTextController,
                          isPassword: true,
                          label: 'Password',
                          icon: const Icon(Icons.lock),
                          validator: (value) =>
                              AuthCubit.passwordValidator(value)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, ResetPasswordScreen.id);
                            },
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 12,
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                          ),
                        ],
                      ),
                      ReusableButton(
                        onPressed: () async {
                          await context.read<AuthCubit>().submitAuthentication(
                              context: context,
                              formKey: formKey,
                              emailTextController: emailTextController,
                              passwordTextController: passwordTextController,
                              screen: SignInScreen.id);
                        },
                        label: 'Login',
                      )
                    ],
                  ),
                ),
                SizedBox(height: 74),
                SizedBox(
                  width: 236,
                  height: 154,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '- OR Continue with -',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: kNiceGrey,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          OAuthButton(
                            iconPath: 'assets/images/google_icon.svg',
                            onPressed: () async {
                              await context.read<AuthCubit>().googleOAuth();
                            },
                          ),
                          OAuthButton(
                            iconPath: 'assets/images/apple_icon.svg',
                            onPressed: () {
                              SnackBarUtil.showErrorSnackBar(context,
                                  'Apple accounts will be supported soon.');
                            },
                          ),
                          OAuthButton(
                            iconPath: 'assets/images/facebook_icon.svg',
                            onPressed: () {
                              SnackBarUtil.showErrorSnackBar(context,
                                  'Facebook accounts will be supported soon.');
                            },
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Create an Account',
                            style: TextStyle(
                                fontFamily: 'Montserrat', color: kNiceGrey),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, SignUpScreen.id);
                            },
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                          ),
                        ],
                      ),
                    ],
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
