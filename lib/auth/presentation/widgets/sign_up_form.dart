import 'package:e_commerce/auth/presentation/controllers/auth_cubit.dart';
import 'package:e_commerce/auth/presentation/widgets/oauth_widget.dart';
import 'package:e_commerce/auth/presentation/widgets/obscure_button.dart';
import 'package:e_commerce/core/utils/shortcuts.dart';
import 'package:e_commerce/core/widgets/app_button.dart';
import 'package:e_commerce/core/widgets/app_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/constants/assets.gen.dart';

Widget signUpForm({required BuildContext context, Key? key}) {
  final cubit = context.read<AuthCubit>();
  final locale = Localizations.localeOf(context).languageCode;
  final checkboxError = cubit.showPoliciesError && !cubit.isPoliciesAccepted;
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
                controller: cubit.nameFieldController,
                label: localization(context).name,
                textInputAction: TextInputAction.next,
                prefixIcon: SvgPicture.asset(
                  Assets.icons.person,
                  fit: BoxFit.scaleDown,
                  colorFilter: ColorFilter.mode(
                    colorScheme(context).tertiaryFixed,
                    BlendMode.srcIn,
                  ),
                ),
                validator: (value) =>
                    AuthCubit.userNameValidator(context: context, value: value),
              ),
              SizedBox(height: 20),
              AppField(
                controller: cubit.emailFieldController,
                label: localization(context).email,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                prefixIcon: SvgPicture.asset(
                  Assets.icons.person,
                  fit: BoxFit.scaleDown,
                  colorFilter: ColorFilter.mode(
                    colorScheme(context).tertiaryFixed,
                    BlendMode.srcIn,
                  ),
                ),
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
                prefixIcon: SvgPicture.asset(
                  Assets.icons.lock,
                  fit: BoxFit.scaleDown,
                  colorFilter: ColorFilter.mode(
                    colorScheme(context).tertiaryFixed,
                    BlendMode.srcIn,
                  ),
                ),
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
                prefixIcon: SvgPicture.asset(
                  Assets.icons.lock,
                  fit: BoxFit.scaleDown,
                  colorFilter: ColorFilter.mode(
                    colorScheme(context).tertiaryFixed,
                    BlendMode.srcIn,
                  ),
                ),
                validator: (value) => cubit.confirmPasswordValidator(
                  context: context,
                  value: value,
                ),
                onSubmitted: (_) async => await cubit.signUp(),
              ),
              SizedBox(height: 35),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Checkbox(
                    value: cubit.isPoliciesAccepted,
                    onChanged: (value) => cubit.togglePoliciesAccepted(),
                    side: BorderSide(
                      color: checkboxError
                          ? colorScheme(context).error
                          : colorScheme(context).tertiaryFixed,
                    ),
                    fillColor: WidgetStateProperty.resolveWith((states) {
                      if (states.contains(WidgetState.selected)) {
                        return colorScheme(context).primary;
                      }
                      if (checkboxError) {
                        return colorScheme(context).error.withAlpha(35);
                      }
                      return Colors.transparent;
                    }),
                  ),
                  RichText(
                    text: TextSpan(
                      text: localization(context).privacyAgreementPrefix,
                      style: textTheme(context).bodySmall!.copyWith(
                        color: checkboxError
                            ? colorScheme(context).error
                            : colorScheme(context).tertiaryFixed,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: localization(context).privacyPolicy,
                          style: textTheme(context).bodySmall!.copyWith(
                            color: colorScheme(context).primaryFixed,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              cubit.launchPrivacy(context, locale);
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 35),
              AppButton(
                onPressed: () async => await cubit.signUp(),
                isLoading: cubit.isLoading,
                label: localization(context).createAccount,
              ),
              SizedBox(height: 35),
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
