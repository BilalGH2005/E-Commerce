import 'package:e_commerce/auth/presentation/widgets/obscure_button.dart';
import 'package:e_commerce/core/constants/app_breakpoints.dart';
import 'package:e_commerce/core/utils/localization.dart';
import 'package:e_commerce/core/widgets/app_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/snackbar_util.dart';
import '../../../core/widgets/app_button.dart';
import '../../cubit/auth_cubit.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocConsumer<AuthCubit, AuthCubitState>(
        listenWhen: (_, state) =>
            state is AuthResetPasswordSuccess || state is AuthFailure,
        listener: (context, state) {
          if (state is AuthFailure) {
            SnackBarUtil.showError(
                localization(context).authError(state.errorCode));
          } else if (state is AuthResetPasswordSuccess) {
            SnackBarUtil.showSuccess(
                localization(context).passwordHasBeenResetSuccessfully);
          }
        },
        buildWhen: (_, state) =>
            state is AuthResetPasswordRequested ||
            state is AuthFailure ||
            state is AuthFormChanged,
        builder: (context, state) {
          final cubit = context.read<AuthCubit>();
          return Scaffold(
            body: SingleChildScrollView(
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: AppBreakpoints.kTabletWidth,
                      minHeight: MediaQuery.sizeOf(context).height),
                  child: Form(
                    key: cubit.resetPasswordFormKey,
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppField(
                            controller: cubit.passwordFieldController,
                            isObscure: cubit.isPasswordFieldObscure,
                            textInputAction: TextInputAction.next,
                            suffixIcon: ObscureButton(
                                isObscure: cubit.isPasswordFieldObscure,
                                onPressed: () => cubit.togglePasswordObscure()),
                            label: localization(context).password,
                            prefixIcon: const Icon(Icons.lock),
                            validator: (value) => AuthCubit.passwordValidator(
                              context: context,
                              value: value,
                            ),
                          ),
                          SizedBox(height: 30),
                          AppField(
                            controller: cubit.confirmPasswordFieldController,
                            isObscure: cubit.isConfirmPasswordObscure,
                            textInputAction: TextInputAction.done,
                            suffixIcon: ObscureButton(
                                isObscure: cubit.isConfirmPasswordObscure,
                                onPressed: () =>
                                    cubit.toggleConfirmPasswordFieldObscure()),
                            label: localization(context).confirmPassword,
                            prefixIcon: const Icon(Icons.lock),
                            validator: (value) =>
                                cubit.confirmPasswordValidator(
                              context: context,
                              value: value,
                            ),
                            onSubmitted: (_) async => await cubit.signUp(),
                          ),
                          SizedBox(height: 60),
                          AppButton(
                            onPressed: cubit.isLoading
                                ? null
                                : () async => await cubit.updateUserPassword(),
                            labelWidget: cubit.isLoading
                                ? CircularProgressIndicator()
                                : Text(localization(context).resetPassword,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
}
