import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final void Function()? onPressed;

  const CustomIconButton(
      {super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: ClipOval(
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: const [
              BoxShadow(
                offset: Offset(-6, -6),
                color: Color(0x88DEDBDB),
                blurRadius: 4.0,
              ),
              BoxShadow(
                offset: Offset(6, 6),
                color: Color(0x88C4C4C4),
                blurRadius: 4.0,
              ),
            ],
          ),
          child: Icon(icon),
        ),
      ),
    );
  }
}
