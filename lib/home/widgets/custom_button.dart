import 'package:flutter/material.dart';

import '../../core/themes/const_colors.dart';

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
                  fontWeight: FontWeight.w500, color: ConstColors.kWhite),
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
                  color: ConstColors.kBlack.withAlpha(77),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
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
