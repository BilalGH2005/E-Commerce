import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/cubit/app_cubit.dart';

class AuthField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData prefixIcon;
  final String? Function(String?) validator;
  final bool? isObscure;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final TextInputAction? textInputAction;
  final void Function(String)? onSubmitted;
  const AuthField({
    super.key,
    required this.controller,
    required this.label,
    required this.prefixIcon,
    required this.validator,
    this.keyboardType,
    this.suffixIcon,
    this.isObscure,
    this.textInputAction,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) => TextFormField(
        onTapOutside: (PointerDownEvent event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        onFieldSubmitted: onSubmitted,
        style: Theme.of(context)
            .textTheme
            .displaySmall!
            .copyWith(color: Theme.of(context).colorScheme.tertiaryFixed),
        controller: controller,
        textInputAction: textInputAction,
        obscureText: isObscure ?? false,
        keyboardType: keyboardType,
        validator: validator,
        decoration: InputDecoration(
          fillColor: Theme.of(context).colorScheme.surfaceContainer,
          prefixIcon: Icon(prefixIcon,
              color: Theme.of(context).colorScheme.tertiaryFixed),
          suffixIcon: suffixIcon,
          filled: true,
          label: Text(
            label,
            style: TextStyle(
              fontFamily: context.watch<AppCubit>().isArabic!
                  ? 'Tajawal'
                  : 'Montserrat',
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
          errorStyle: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(color: Theme.of(context).colorScheme.error),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.tertiaryFixedDim,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.error,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        ),
      );
}
