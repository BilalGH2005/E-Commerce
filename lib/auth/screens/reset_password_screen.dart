import 'package:e_commerce/auth/cubit/auth_cubit.dart';
import 'package:e_commerce/core/utils/constants/screens_names.dart';
import 'package:e_commerce/core/widgets/reusable_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/auth_field.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
                children: [
                  Text(
                    'Forgot\npassword?',
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ],
              ),
              SizedBox(height: 32),
              SizedBox(
                width: 317,
                height: 210,
                child: BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    final AuthCubit cubit = context.read<AuthCubit>();
                    final bool isLoading = cubit.authStatus == 0;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AuthField(
                          controller: cubit.emailTextController,
                          label: 'Enter your email address',
                          prefixIcon: const Icon(Icons.email),
                          validator: (value) => AuthCubit.emailValidator(value),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: '* ',
                                style:
                                    TextStyle(color: Colors.red, fontSize: 12),
                                children: <TextSpan>[
                                  TextSpan(
                                    text:
                                        'We will send you a message to set or reset\nyour new password',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
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
                                  screen: ScreensNames.resetPassword)
                              : null,
                          label: isLoading
                              ? Text('Submit',
                                  style: Theme.of(context).textTheme.bodyMedium)
                              : CircularProgressIndicator(
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                        ),
                      ],
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
