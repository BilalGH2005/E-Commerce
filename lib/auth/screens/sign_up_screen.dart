import 'package:e_commerce/auth/screens/sign_in_screen.dart';
import 'package:e_commerce/auth/screens/terms_screen.dart';
import 'package:e_commerce/core/utils/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/snackbar_util.dart';
import '../cubit/auth_cubit.dart';
import '../widgets/auth_field.dart';
import '../widgets/oauth_button.dart';
import '../widgets/reusable_button.dart';

class SignUpScreen extends StatelessWidget {
  static const String id = 'sign_up_screen';
  SignUpScreen({super.key});
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailTextController = TextEditingController(),
      passwordTextController = TextEditingController(),
      confirmPasswordTextController = TextEditingController();

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
                  height: 488,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Text(
                            'Create an\naccount',
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
                        validator: (value) => AuthCubit.emailValidator(value),
                      ),
                      AuthField(
                        key: ValueKey('password'),
                        controller: passwordTextController,
                        isPassword: true,
                        label: 'Password',
                        icon: const Icon(Icons.lock),
                        validator: (value) =>
                            AuthCubit.passwordValidator(value),
                      ),
                      AuthField(
                        controller: confirmPasswordTextController,
                        isPassword: true,
                        label: 'Confirm Password',
                        icon: const Icon(Icons.lock),
                        validator: (value) {
                          if (value != passwordTextController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              text:
                                  'By clicking the Create Account button, you\nagree to ',
                              style: kGreyTextStyle,
                              children: <TextSpan>[
                                //TODO: imp(1) - show the ripple effect when pressing the button
                                TextSpan(
                                  text: 'our terms',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 12,
                                    color: Color(0xFFFF4B26),
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pushNamed(
                                          context, TermsScreen.id);
                                    },
                                ),
                              ],
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
                              screen: SignUpScreen.id);
                        },
                        label: 'Create Account',
                      )
                    ],
                  ),
                ),
                SizedBox(height: 40),
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
                            'I Already Have an Account',
                            style: TextStyle(
                                fontFamily: 'Montserrat', color: kNiceGrey),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, SignInScreen.id);
                            },
                            child: Text(
                              'Sign in',
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
