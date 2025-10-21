import 'package:e_commerce/auth/cubit/auth_cubit.dart';
import 'package:e_commerce/auth/presentation/widgets/oauth_widget.dart';
import 'package:e_commerce/auth/presentation/widgets/obscure_button.dart';
import 'package:e_commerce/core/constants/app_routes.dart';
import 'package:e_commerce/core/utils/shortcuts.dart';
import 'package:e_commerce/core/widgets/app_button.dart';
import 'package:e_commerce/core/widgets/app_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

Widget signInForm({required BuildContext context, Key? key}) {
  final cubit = context.read<AuthCubit>();
  return Container(
    key: key,
    child: SingleChildScrollView(
      child: Form(
        key: cubit.signInFormKey,
        child: Padding(
          padding: EdgeInsets.all(30),
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
                prefixIcon: const Icon(Icons.person),
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
                  onPressed: () => cubit.togglePasswordObscure(),
                ),
                label: localization(context).password,
                prefixIcon: const Icon(Icons.lock),
                validator: (value) =>
                    AuthCubit.passwordValidator(context: context, value: value),
                onSubmitted: (_) async => await cubit.signInWithPassword(),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => context.pushNamed(
                      AppRoutes.forgetPassword.name,
                      extra: cubit,
                    ),
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
                onPressed: cubit.isLoading
                    ? null
                    : () async => await cubit.signInWithPassword(),
                labelWidget: cubit.isLoading
                    ? CircularProgressIndicator()
                    : Text(
                        localization(context).login,
                        style: textTheme(context).bodyMedium,
                      ),
              ),
              const SizedBox(height: 74),
              OAuthWidget(
                label: localization(context).createAnAccount,
                buttonText: localization(context).signUp,
                onPressed: () async => cubit.toggleAuth(),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
