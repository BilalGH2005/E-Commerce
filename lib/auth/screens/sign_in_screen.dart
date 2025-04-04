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

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        //TODO: make all the screens that has constrains to show the scrollbar on the right
        child: ConstrainedBox(
          constraints:
              BoxConstraints(maxWidth: 500, minHeight: double.infinity),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.only(
                    //TODO: make top padding dynamic depend on platform using: final platform = Theme.of(context).platform
                    top: 48.0,
                    bottom: 29.0,
                    right: 29.0,
                    left: 29.0),
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
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ],
                              ),
                              AuthField(
                                controller: cubit.emailTextController,
                                label: AppLocalizations.of(context)!.email,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                prefixIcon: Icons.person,
                                validator: (value) =>
                                    AuthCubit.emailValidator(value),
                              ),
                              AuthField(
                                controller: cubit.passwordTextController,
                                isObscure: cubit.isPasswordObscure,
                                textInputAction: TextInputAction.done,
                                suffixIcon: ObscureButton(
                                  isObscure: cubit.isPasswordObscure,
                                  onPressed: () =>
                                      cubit.togglePasswordObscure(),
                                ),
                                label: AppLocalizations.of(context)!.password,
                                prefixIcon: Icons.lock,
                                validator: (value) =>
                                    AuthCubit.passwordValidator(value),
                                onSubmitted: (_) async =>
                                    await cubit.authentication(
                                        formKey: formKey,
                                        screen: ScreensNames.signIn),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () => context
                                        .pushNamed(ScreensNames.resetPassword),
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .forgotPassword,
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
                                    ? () async => await cubit.authentication(
                                        formKey: formKey,
                                        screen: ScreensNames.signIn)
                                    : null,
                                label: isLoading
                                    ? Text(AppLocalizations.of(context)!.login,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium)
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
                        label: AppLocalizations.of(context)!.createAnAccount,
                        buttonText: AppLocalizations.of(context)!.signUp,
                        onPressed: () => context.pushNamed(ScreensNames.signUp),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
