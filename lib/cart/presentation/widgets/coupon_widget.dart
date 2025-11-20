import 'package:e_commerce/core/utils/duration_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/assets.gen.dart';
import '../../../core/utils/shortcuts.dart';
import '../../../core/widgets/app_field.dart';
import '../controllers/cart_cubit.dart';

class CouponWidget extends StatelessWidget {
  const CouponWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CartCubit>();
    return AnimatedSwitcher(
      duration: 1.s,
      transitionBuilder: (child, animation) {
        final slideAnimation = Tween<Offset>(
          begin: const Offset(0.3, 0.0),
          end: Offset.zero,
        ).animate(animation);
        return SlideTransition(
          position: slideAnimation,
          child: FadeTransition(opacity: animation, child: child),
        );
      },
      child: cubit.couponDiscount != 0
          ? Row(
              children: [
                Chip(
                  key: ValueKey('coupon'),
                  color: WidgetStatePropertyAll(colorScheme(context).surface),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.all(Radius.circular(4)),
                  ),
                  label: Text(
                    '${cubit.couponFieldController.text} - ${cubit.couponDiscount.toStringAsFixed(2)}\$ ${localization(context).off}',
                    style: textTheme(
                      context,
                    ).displayMedium!.copyWith(fontWeight: FontWeight.w600),
                  ),
                  deleteIcon: Icon(Icons.close, size: 18),
                  onDeleted: () {
                    cubit.changeCoupon(0.00);
                  },
                  backgroundColor: Colors.green.shade100,
                  labelPadding: EdgeInsets.symmetric(horizontal: 8),
                ),
              ],
            )
          : Form(
              key: cubit.formKey,
              child: AppField(
                key: ValueKey('appField'),
                validator: (value) => CartCubit.couponFieldValidator(
                  context: context,
                  value: value,
                ),
                controller: cubit.couponFieldController,
                prefixIcon: SizedBox(
                  width: 48,
                  height: 48,
                  child: SvgPicture.asset(
                    Assets.icons.coupon,
                    width: 18,
                    height: 18,
                    fit: BoxFit.scaleDown,
                    colorFilter: ColorFilter.mode(
                      colorScheme(context).inverseSurface,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                suffixIcon: cubit.isCouponLoading
                    ? Transform.scale(
                        scale: 0.3,
                        child: CircularProgressIndicator(
                          color: colorScheme(context).inverseSurface,
                        ),
                      )
                    : TextButton(
                        onPressed: () {
                          cubit.getCouponDiscount();
                        },
                        child: Text(
                          localization(context).apply,
                          style: textTheme(
                            context,
                          ).displaySmall!.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                hintText: localization(context).couponCode,
              ),
            ),
    );
  }
}
