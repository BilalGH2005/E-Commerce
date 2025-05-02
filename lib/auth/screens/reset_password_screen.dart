import 'package:e_commerce/auth/cubit/auth_cubit.dart';
import 'package:e_commerce/auth/widgets/auth_field.dart';
import 'package:e_commerce/core/utils/localization.dart';
import 'package:e_commerce/core/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 768, /*minHeight: double.infinity*/
            ),
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
                      child: BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, state) {
                          final AuthCubit cubit = context.read<AuthCubit>();
                          final bool isLoading = cubit.authStatus == 0;
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AuthField(
                                controller: cubit.emailTextController,
                                label:
                                    localization(context).enterYourEmailAddress,
                                prefixIcon: Icons.email,
                                validator: (value) => AuthCubit.emailValidator(
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
