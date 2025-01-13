import 'package:e_commerce/auth/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthField extends StatelessWidget {
  final TextEditingController controller;
  final bool isPassword;
  final String label;
  final String? Function(String?) validator;
  final Icon icon;

  const AuthField({
    Key? key,
    required this.controller,
    required this.label,
    required this.validator,
    required this.icon,
    this.isPassword = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthCubitState>(
      builder: (context, state) {
        final cubit = context.read<AuthCubit>();
        return TextFormField(
            controller: controller,
            obscureText: isPassword ? cubit.isObscure : false,
            keyboardType: isPassword ? null : TextInputType.emailAddress,
            decoration: InputDecoration(
              prefixIcon: icon,
              suffixIcon: isPassword
                  ? IconButton(
                      splashRadius: 20,
                      onPressed: () {
                        cubit.toggleObscure();
                      },
                      icon: const Icon(Icons.remove_red_eye_outlined),
                    )
                  : null,
              filled: true,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              label: Text(
                label,
                style: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            ),
            validator: validator);
      },
    );
  }
}
