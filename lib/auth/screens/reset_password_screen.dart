import 'package:e_commerce/auth/cubit/auth_cubit.dart';
import 'package:e_commerce/auth/widgets/reusable_button.dart';
import 'package:e_commerce/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/auth_field.dart';

class ResetPasswordScreen extends StatelessWidget {
  static const String id = 'reset_password_screen';

  ResetPasswordScreen({super.key});

  final TextEditingController emailTextController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 48.0, horizontal: 29.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text(
                    'Forgot\npassword?',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 36,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              SizedBox(height: 32),
              SizedBox(
                width: 317,
                height: 210,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AuthField(
                      controller: emailTextController,
                      label: 'Enter your email address',
                      icon: const Icon(Icons.email),
                      validator: (value) => AuthCubit.emailValidator(value),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: '* ',
                            style: TextStyle(color: Colors.red, fontSize: 12),
                            children: const <TextSpan>[
                              TextSpan(
                                text:
                                    'We will send you a message to set or reset\nyour new password',
                                style: kGreyTextStyle,
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
                            screen: ResetPasswordScreen.id);
                      },
                      label: 'Submit',
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
