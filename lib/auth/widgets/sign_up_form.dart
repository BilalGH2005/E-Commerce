import 'package:e_commerce/auth/cubit/auth_cubit.dart';
import 'package:e_commerce/auth/widgets/oauth_widget.dart';
import 'package:e_commerce/auth/widgets/obscure_button.dart';
import 'package:e_commerce/core/constants/screens_names.dart';
import 'package:e_commerce/core/utils/localization.dart';
import 'package:e_commerce/core/widgets/app_button.dart';
import 'package:e_commerce/core/widgets/app_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

Widget signUpForm(
        {required BuildContext context,
        required GlobalKey<FormState> formKey,
        Key? key}) =>
    Container(
      key: key,
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                SizedBox(
                  height: 488,
                  child: BlocBuilder<AuthCubit, AuthStateCubit>(
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
                                localization(context).createAnAccountTitle,
                                textAlign: TextAlign.start,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ],
                          ),
                          AppField(
                            controller: cubit.emailTextController,
                            label: localization(context).email,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            prefixIcon: const Icon(Icons.person),
                            validator: (value) => AuthCubit.emailValidator(
                                context: context, value: value),
                          ),
                          AppField(
                            controller: cubit.passwordTextController,
                            isObscure: cubit.isPasswordObscure,
                            textInputAction: TextInputAction.next,
                            suffixIcon: ObscureButton(
                                isObscure: cubit.isPasswordObscure,
                                onPressed: () => context
                                    .read<AuthCubit>()
                                    .togglePasswordObscure()),
                            label: localization(context).password,
                            prefixIcon: const Icon(Icons.lock),
                            validator: (value) => AuthCubit.passwordValidator(
                                context: context, value: value),
                          ),
                          AppField(
                            controller: cubit.confirmPasswordTextController,
                            isObscure: cubit.isConfirmPasswordObscure,
                            textInputAction: TextInputAction.done,
                            suffixIcon: ObscureButton(
                                isObscure: cubit.isConfirmPasswordObscure,
                                onPressed: () => context
                                    .read<AuthCubit>()
                                    .toggleConfirmPasswordObscure()),
                            label: localization(context).confirmPassword,
                            prefixIcon: const Icon(Icons.lock),
                            validator: (value) =>
                                AuthCubit.confirmPasswordValidator(
                                    context: context,
                                    value: value,
                                    passwordTextController:
                                        cubit.passwordTextController),
                            onSubmitted: (_) async => await cubit.signUp(
                              context: context,
                              formKey: formKey,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Flexible(
                                child: RichText(
                                  text: TextSpan(
                                    text: localization(context).termsAgreement,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .tertiaryFixed),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: localization(context).ourTerms,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primaryFixed,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            context
                                                .pushNamed(ScreensNames.terms);
                                          },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          AppButton(
                            onPressed: isLoading
                                ? () async => await cubit.signUp(
                                    context: context, formKey: formKey)
                                : null,
                            label: isLoading
                                ? Text(localization(context).createAccount,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium)
                                : CircularProgressIndicator(
                                    color:
                                        Theme.of(context).colorScheme.primary),
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
                    label: localization(context).alreadyHaveAnAccount,
                    buttonText: localization(context).signIn,
                    onPressed: () async =>
                        context.read<AuthCubit>().toggleAuth(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
