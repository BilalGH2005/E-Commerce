import 'package:e_commerce/auth/cubit/auth_cubit.dart';
import 'package:e_commerce/core/utils/screens_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/reusable_widgets/reusable_button.dart';
import '../widgets/auth_field.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints:
                const BoxConstraints(maxWidth: 500, minHeight: double.infinity),
            child: Form(
              key: formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 48.0, horizontal: 29.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.forgotPasswordTitle,
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      height: 210,
                      child: BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, state) {
                          final AuthCubit cubit = context.read<AuthCubit>();
                          final bool isLoading = cubit.authStatus == 0;
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AuthField(
                                controller: cubit.emailTextController,
                                label: AppLocalizations.of(context)!
                                    .enterYourEmailAddress,
                                prefixIcon: Icons.email,
                                validator: (value) =>
                                    AuthCubit.emailValidator(value),
                                onSubmitted: (_) async =>
                                    await cubit.authentication(
                                        formKey: formKey,
                                        screen: ScreensNames.resetPassword),
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
                                          text: AppLocalizations.of(context)!
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
                              ReusableButton(
                                onPressed: isLoading
                                    ? () async => await cubit.authentication(
                                        formKey: formKey,
                                        screen: ScreensNames.resetPassword)
                                    : null,
                                label: isLoading
                                    ? Text(AppLocalizations.of(context)!.submit,
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
}
//
// class BaseAuthScreen extends StatelessWidget {
//   final Widget child;
//   final GlobalKey<FormState> formKey;
//   final EdgeInsetsGeometry padding;
//
//   const BaseAuthScreen({
//     super.key,
//     required this.child,
//     required this.formKey,
//     required this.padding,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Center(
//           child: ConstrainedBox(
//             constraints:
//                 const BoxConstraints(maxWidth: 500, minHeight: double.infinity),
//             child: Form(
//               key: formKey,
//               child: Padding(
//                 padding: padding,
//                 child: child,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
