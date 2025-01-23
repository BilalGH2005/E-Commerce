import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final Icon icon;

  final String? Function(String?) validator;
  final bool? isObscure;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  const AuthField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    required this.validator,
    this.keyboardType,
    this.suffixIcon,
    this.isObscure,
  });

  @override
  Widget build(BuildContext context) => TextFormField(
      controller: controller,
      obscureText: isObscure ?? false,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefixIcon: icon,
        suffixIcon: suffixIcon,
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
}
