import 'package:e_commerce/auth/cubit/auth_cubit.dart';
import 'package:e_commerce/auth/presentation/widgets/oauth_widget.dart';
import 'package:e_commerce/auth/presentation/widgets/obscure_button.dart';
import 'package:e_commerce/core/utils/shortcuts.dart';
import 'package:e_commerce/core/widgets/app_button.dart';
import 'package:e_commerce/core/widgets/app_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_routes.dart';

Widget signUpForm({required BuildContext context, Key? key}) {
  final cubit = context.read<AuthCubit>();
  return Container(
    key: key,
    child: SingleChildScrollView(
      child: Form(
        key: cubit.signUpFormKey,
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    localization(context).createAnAccountTitle,
                    textAlign: TextAlign.start,
                    style: textTheme(context).bodyLarge,
                  ),
                ],
              ),
              SizedBox(height: 25),
              AppField(
                controller: cubit.emailFieldController,
                label: localization(context).email,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                prefixIcon: const Icon(Icons.person),
                validator: (value) =>
                    AuthCubit.emailValidator(context: context, value: value),
              ),
              SizedBox(height: 20),
              AppField(
                controller: cubit.passwordFieldController,
                isObscure: cubit.isPasswordFieldObscure,
                textInputAction: TextInputAction.next,
                suffixIcon: ObscureButton(
                  isObscure: cubit.isPasswordFieldObscure,
                  onPressed: () => cubit.togglePasswordObscure(),
                ),
                label: localization(context).password,
                prefixIcon: const Icon(Icons.lock),
                validator: (value) =>
                    AuthCubit.passwordValidator(context: context, value: value),
              ),
              SizedBox(height: 20),
              AppField(
                controller: cubit.confirmPasswordFieldController,
                isObscure: cubit.isConfirmPasswordObscure,
                textInputAction: TextInputAction.done,
                suffixIcon: ObscureButton(
                  isObscure: cubit.isConfirmPasswordObscure,
                  onPressed: () => cubit.toggleConfirmPasswordFieldObscure(),
                ),
                label: localization(context).confirmPassword,
                prefixIcon: const Icon(Icons.lock),
                validator: (value) => cubit.confirmPasswordValidator(
                  context: context,
                  value: value,
                ),
                onSubmitted: (_) async => await cubit.signUp(),
              ),
              SizedBox(height: 35),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: RichText(
                      text: TextSpan(
                        text: localization(context).termsAgreement,
                        style: textTheme(context).bodySmall!.copyWith(
                          color: colorScheme(context).tertiaryFixed,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: localization(context).ourTerms,
                            style: textTheme(context).bodySmall!.copyWith(
                              color: colorScheme(context).primaryFixed,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.pushNamed(AppRoutes.terms.name);
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 35),
              AppButton(
                onPressed: cubit.isLoading
                    ? null
                    : () async => await cubit.signUp(),
                labelWidget: cubit.isLoading
                    ? CircularProgressIndicator()
                    : Text(
                        localization(context).createAccount,
                        style: textTheme(context).bodyMedium,
                      ),
              ),
              const SizedBox(height: 40),
              OAuthWidget(
                label: localization(context).alreadyHaveAnAccount,
                buttonText: localization(context).signIn,
                onPressed: () async => cubit.toggleAuth(),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
