import 'package:e_commerce/auth/cubit/auth_cubit.dart';
import 'package:e_commerce/core/constants/app_breakpoints.dart';
import 'package:e_commerce/core/utils/shortcuts.dart';
import 'package:e_commerce/core/utils/snackbar_util.dart';
import 'package:e_commerce/core/widgets/app_button.dart';
import 'package:e_commerce/core/widgets/app_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocConsumer<AuthCubit, AuthCubitState>(
    listenWhen: (_, state) => state is AuthResetPasswordRequested,
    listener: (context, state) {
      if (state is AuthResetPasswordRequested) {
        SnackBarUtil.showSuccess(localization(context).resetPasswordEmailSent);
      }
    },
    builder: (_, _) {
      final cubit = context.read<AuthCubit>();
      return Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: AppBreakpoints.kTabletWidth,
              ),
              child: Form(
                key: cubit.forgetPasswordFormKey,
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              localization(context).forgotPasswordTitle,
                              textAlign: TextAlign.start,
                              style: textTheme(context).bodyLarge,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      SizedBox(
                        height: 210,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppField(
                              controller: cubit.emailFieldController,
                              label: localization(
                                context,
                              ).enterYourEmailAddress,
                              textInputAction: TextInputAction.done,
                              prefixIcon: const Icon(Icons.email),
                              validator: (value) => AuthCubit.emailValidator(
                                context: context,
                                value: value,
                              ),
                              onSubmitted: (_) async =>
                                  await cubit.resetPasswordForEmail(),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: RichText(
                                    text: TextSpan(
                                      text: '* ',
                                      style: textTheme(context).bodySmall!
                                          .copyWith(
                                            color: colorScheme(context).error,
                                          ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: localization(
                                            context,
                                          ).passwordResetMessage,
                                          style: textTheme(context).bodySmall!
                                              .copyWith(
                                                color: colorScheme(
                                                  context,
                                                ).tertiaryFixed,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            AppButton(
                              onPressed: cubit.isLoading
                                  ? null
                                  : () async =>
                                        await cubit.resetPasswordForEmail(),
                              labelWidget: cubit.isLoading
                                  ? CircularProgressIndicator()
                                  : Text(
                                      localization(context).submit,
                                      style: textTheme(context).bodyMedium,
                                    ),
                            ),
                          ],
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
    },
  );
}
