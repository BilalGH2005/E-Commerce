import 'package:flutter/material.dart';

class ImagePickerSheetButton extends StatelessWidget {
  final void Function()? onPressed;
  final IconData icon;
  final String text;
  const ImagePickerSheetButton(
      {super.key,
      required this.onPressed,
      required this.icon,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon),
            SizedBox(height: 6),
            Text(text, style: Theme.of(context).textTheme.displaySmall),
          ],
        ),
      ),
    );
  }
}
