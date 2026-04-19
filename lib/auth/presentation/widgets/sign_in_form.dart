import 'package:e_commerce/auth/presentation/controllers/auth_cubit.dart';
import 'package:e_commerce/auth/presentation/widgets/oauth_widget.dart';
import 'package:e_commerce/auth/presentation/widgets/obscure_button.dart';
import 'package:e_commerce/core/utils/shortcuts.dart';
import 'package:e_commerce/core/widgets/app_button.dart';
import 'package:e_commerce/core/widgets/app_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/assets.gen.dart';

Widget signInForm({required BuildContext context, Key? key}) {
  final cubit = context.read<AuthCubit>();
  return Container(
    key: key,
    child: SingleChildScrollView(
      child: Form(
        key: cubit.signInFormKey,
        child: Padding(
          padding: EdgeInsets.all(30),
          child: SizedBox(
            height: 680,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      localization(context).welcomeBack,
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
                  textInputAction: TextInputAction.done,
                  suffixIcon: ObscureButton(
                    isObscure: cubit.isPasswordFieldObscure,
                    onPressed: () {
                      cubit.togglePasswordObscure();
                    },
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
                  validator: (value) => AuthCubit.passwordValidator(
                    context: context,
                    value: value,
                  ),
                  onSubmitted: (_) => cubit.signInWithPassword(),
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () =>
                          cubit.navigateToForgotPasswordScreen(context),
                      child: Text(
                        localization(context).forgotPassword,
                        style: textTheme(context).bodySmall!.copyWith(
                          color: colorScheme(context).primary,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                AppButton(
                  onPressed: () => cubit.signInWithPassword(),
                  isLoading: cubit.isLoading,
                  label: localization(context).login,
                ),
                Spacer(),
                OAuthWidget(
                  label: localization(context).createAnAccount,
                  buttonText: localization(context).signUp,
                  onPressed: () => cubit.toggleAuth(),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
