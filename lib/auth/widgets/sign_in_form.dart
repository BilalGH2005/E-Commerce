import 'package:e_commerce/auth/cubit/auth_cubit.dart';
import 'package:e_commerce/auth/widgets/obscure_button.dart';
import 'package:e_commerce/core/utils/screens_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../core/reusable_widgets/reusable_button.dart';
import '../widgets/auth_field.dart';
import '../widgets/oauth_widget.dart';

Widget signInForm(BuildContext context, GlobalKey<FormState> formKey) {
  return SingleChildScrollView(
    child: Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(30
            // top: 48.0,
            // bottom: 29.0,
            // right: 29.0,
            // left: 29.0,
            ),
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
                            AppLocalizations.of(context)!.welcomeBack,
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                      AuthField(
                        controller: cubit.emailTextController,
                        label: AppLocalizations.of(context)!.email,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        prefixIcon: Icons.person,
                        validator: (value) => AuthCubit.emailValidator(value),
                      ),
                      AuthField(
                        controller: cubit.passwordTextController,
                        isObscure: cubit.isPasswordObscure,
                        textInputAction: TextInputAction.done,
                        suffixIcon: ObscureButton(
                          isObscure: cubit.isPasswordObscure,
                          onPressed: () => cubit.togglePasswordObscure(),
                        ),
                        label: AppLocalizations.of(context)!.password,
                        prefixIcon: Icons.lock,
                        validator: (value) =>
                            AuthCubit.passwordValidator(value),
                        onSubmitted: (_) async => await cubit.signIn(
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
                              AppLocalizations.of(context)!.forgotPassword,
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
                      ReusableButton(
                        onPressed: isLoading
                            ? () async => await cubit.signIn(formKey: formKey)
                            : null,
                        label: isLoading
                            ? Text(
                                AppLocalizations.of(context)!.login,
                                style: Theme.of(context).textTheme.bodyMedium,
                              )
                            : CircularProgressIndicator(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor),
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
                label: AppLocalizations.of(context)!.createAnAccount,
                buttonText: AppLocalizations.of(context)!.signUp,
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
}
