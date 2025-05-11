import 'package:e_commerce/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final List<Color> colors;
  final void Function()? onPressed;
  final String label;
  final IconData icon;
  const CustomButton({
    super.key,
    required this.colors,
    required this.onPressed,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isRTL = Directionality.of(context) == TextDirection.rtl;
    return InkWell(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(isRTL ? 8 : 30),
        topLeft: Radius.circular(isRTL ? 8 : 30),
        bottomRight: Radius.circular(isRTL ? 30 : 8),
        topRight: Radius.circular(isRTL ? 30 : 8),
      ),
      onTap: onPressed,
      child: Stack(
        alignment: isRTL ? Alignment.centerRight : Alignment.centerLeft,
        children: [
          Container(
            padding:
                EdgeInsets.only(left: isRTL ? 8 : 48, right: isRTL ? 48 : 8),
            alignment: Alignment.center,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(isRTL ? 8 : 30),
                topLeft: Radius.circular(isRTL ? 8 : 30),
                bottomRight: Radius.circular(isRTL ? 30 : 8),
                topRight: Radius.circular(isRTL ? 30 : 8),
              ),
              gradient: LinearGradient(
                colors: colors,
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
            child: Text(
              label,
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  fontWeight: FontWeight.w500, color: AppColors.white),
            ),
          ),
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: colors,
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withAlpha(77),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
