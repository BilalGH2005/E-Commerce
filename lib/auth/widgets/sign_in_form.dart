import 'package:e_commerce/auth/cubit/auth_cubit.dart';
import 'package:e_commerce/auth/widgets/auth_field.dart';
import 'package:e_commerce/auth/widgets/oauth_widget.dart';
import 'package:e_commerce/auth/widgets/obscure_button.dart';
import 'package:e_commerce/core/constants/screens_names.dart';
import 'package:e_commerce/core/utils/localization.dart';
import 'package:e_commerce/core/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

Widget signInForm(BuildContext context, GlobalKey<FormState> formKey) =>
    SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              SizedBox(
                height: 392,
                child: BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    final cubit = context.read<AuthCubit>();
                    final bool isLoading = cubit.authStatus == 0;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              localization(context).welcomeBack,
                              textAlign: TextAlign.start,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                        AuthField(
                          controller: cubit.emailTextController,
                          label: localization(context).email,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          prefixIcon: Icons.person,
                          validator: (value) => AuthCubit.emailValidator(
                              context: context, value: value),
                        ),
                        AuthField(
                          controller: cubit.passwordTextController,
                          isObscure: cubit.isPasswordObscure,
                          textInputAction: TextInputAction.done,
                          suffixIcon: ObscureButton(
                            isObscure: cubit.isPasswordObscure,
                            onPressed: () => cubit.togglePasswordObscure(),
                          ),
                          label: localization(context).password,
                          prefixIcon: Icons.lock,
                          validator: (value) => AuthCubit.passwordValidator(
                              context: context, value: value),
                          onSubmitted: (_) async => await cubit.signIn(
                            context: context,
                            formKey: formKey,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () =>
                                  context.pushNamed(ScreensNames.resetPassword),
                              child: Text(
                                localization(context).forgotPassword,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                              ),
                            ),
                          ],
                        ),
                        AppButton(
                          onPressed: isLoading
                              ? () async => await cubit.signIn(
                                  context: context, formKey: formKey)
                              : null,
                          label: isLoading
                              ? Text(
                                  localization(context).login,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                )
                              : CircularProgressIndicator(
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 74),
              SizedBox(
                width: 236,
                height: 154,
                child: OAuthWidget(
                  label: localization(context).createAnAccount,
                  buttonText: localization(context).signUp,
                  onPressed: () async {
                    await context.pushNamed(ScreensNames.signUp);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
