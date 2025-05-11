import 'package:e_commerce/auth/cubit/auth_cubit.dart';
import 'package:e_commerce/core/constants/breakpoints.dart';
import 'package:e_commerce/core/utils/localization.dart';
import 'package:e_commerce/core/widgets/app_button.dart';
import 'package:e_commerce/core/widgets/app_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: Breakpoints.tabletWidth,
              ),
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            localization(context).forgotPasswordTitle,
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      SizedBox(
                        height: 210,
                        child: BlocBuilder<AuthCubit, AuthStateCubit>(
                          builder: (context, state) {
                            final cubit = context.read<AuthCubit>();
                            final isLoading = cubit.authStatus == 0;
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppField(
                                  controller: cubit.emailTextController,
                                  label: localization(context)
                                      .enterYourEmailAddress,
                                  prefixIcon: const Icon(Icons.email),
                                  validator: (value) =>
                                      AuthCubit.emailValidator(
                                          context: context, value: value),
                                  onSubmitted: (_) async =>
                                      await cubit.resetPassword(
                                          context: context, formKey: formKey),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text: '* ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .error,
                                            ),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: localization(context)
                                                .passwordResetMessage,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .tertiaryFixed),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                AppButton(
                                  onPressed: isLoading
                                      ? () async => await cubit.resetPassword(
                                          context: context, formKey: formKey)
                                      : null,
                                  label: isLoading
                                      ? Text(localization(context).submit,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium)
                                      : CircularProgressIndicator(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
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
            ),
          ),
        ),
      );
}
