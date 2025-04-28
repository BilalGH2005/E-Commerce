import 'package:e_commerce/auth/widgets/oauth_widget.dart';
import 'package:e_commerce/core/utils/screens_names.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../core/reusable_widgets/reusable_button.dart';
import '../cubit/auth_cubit.dart';
import '../widgets/auth_field.dart';
import '../widgets/obscure_button.dart';

Widget signUpForm(BuildContext context, GlobalKey<FormState> formKey) {
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
                            AppLocalizations.of(context)!.createAnAccountTitle,
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
                        textInputAction: TextInputAction.next,
                        suffixIcon: ObscureButton(
                            isObscure: cubit.isPasswordObscure,
                            onPressed: () => context
                                .read<AuthCubit>()
                                .togglePasswordObscure()),
                        label: AppLocalizations.of(context)!.password,
                        prefixIcon: Icons.lock,
                        validator: (value) =>
                            AuthCubit.passwordValidator(value),
                      ),
                      AuthField(
                        controller: cubit.confirmPasswordTextController,
                        isObscure: cubit.isConfirmPasswordObscure,
                        textInputAction: TextInputAction.done,
                        suffixIcon: ObscureButton(
                            isObscure: cubit.isConfirmPasswordObscure,
                            onPressed: () => context
                                .read<AuthCubit>()
                                .toggleConfirmPasswordObscure()),
                        label: AppLocalizations.of(context)!.confirmPassword,
                        prefixIcon: Icons.lock,
                        validator: (value) =>
                            AuthCubit.confirmPasswordValidator(
                                value: value,
                                passwordTextController:
                                    cubit.passwordTextController),
                        onSubmitted: (_) async => await cubit.signUp(
                          formKey: formKey,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Flexible(
                            child: RichText(
                              text: TextSpan(
                                text: AppLocalizations.of(context)!
                                    .termsAgreement,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiaryFixed),
                                children: <TextSpan>[
                                  TextSpan(
                                    text:
                                        AppLocalizations.of(context)!.ourTerms,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primaryFixed,
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
                          ),
                        ],
                      ),
                      ReusableButton(
                        onPressed: isLoading
                            ? () async => await cubit.signUp(formKey: formKey)
                            : null,
                        label: isLoading
                            ? Text(AppLocalizations.of(context)!.createAccount,
                                style: Theme.of(context).textTheme.bodyMedium)
                            : CircularProgressIndicator(
                                color: Theme.of(context)
                                    .colorScheme
                                    .inverseSurface),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: 260,
              height: 154,
              child: OAuthWidget(
                label: AppLocalizations.of(context)!.alreadyHaveAnAccount,
                buttonText: AppLocalizations.of(context)!.signIn,
                onPressed: () async =>
                    await context.pushNamed(ScreensNames.signIn),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
