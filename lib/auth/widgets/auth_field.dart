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
      onTapOutside: (PointerDownEvent event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      controller: controller,
      obscureText: isObscure ?? false,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        fillColor: Color(0xFFF3F3F3),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: Color(0xFFA8A8A9),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: Color(0xFFA8A8A9),
          ),
        ),
        prefixIcon: icon,
        suffixIcon: suffixIcon,
        filled: true,
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
