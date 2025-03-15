import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final Icon prefixIcon;
  final String? Function(String?) validator;
  final bool? isObscure;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  const AuthField({
    super.key,
    required this.controller,
    required this.label,
    required this.prefixIcon,
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
      style: Theme.of(context).textTheme.labelSmall,
      // cursorErrorColor: Colors.red,
      controller: controller,
      obscureText: isObscure ?? false,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        fillColor: Theme.of(context).colorScheme.onSurface,
        // errorBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.all(Radius.circular(10)),
        //   //TODO: error border color and error message color
        //   borderSide: BorderSide(
        //     color: Colors.red,
        //   ),
        // ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: Color(0xFFA8A8A9),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: Color(0xFFA8A8A9),
          ),
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        filled: true,
        label: Text(
          label,
          style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w500,
              fontSize: 12),
        ),
      ),
      validator: validator);
}
