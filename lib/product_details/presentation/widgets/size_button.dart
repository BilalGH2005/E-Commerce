import 'package:e_commerce/core/constants/app_colors.dart';
import 'package:e_commerce/core/models/json_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/shortcuts.dart';
import '../controllers/product_details_cubit.dart';

class SizeButton extends StatelessWidget {
  final bool isSelected;
  final JsonSize size;

  const SizeButton({super.key, required this.isSelected, required this.size});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProductDetailsCubit>();
    return ChoiceChip(
      side: BorderSide(width: 1.5, color: colorScheme(context).primary),
      color: WidgetStateColor.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return colorScheme(context).primary;
        } else {
          return colorScheme(context).surface;
        }
      }),
      labelStyle: textTheme(context).displaySmall!.copyWith(
        fontWeight: FontWeight.w600,
        color: isSelected ? AppColors.white : colorScheme(context).primary,
      ),
      showCheckmark: false,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      label: Text(size.name),
      selected: isSelected,
      onSelected: (_) {
        if (!isSelected) {
          final newOrderDetails = cubit.orderDetails.copyWith(sizeId: size.id);
          cubit.updateOrderDetails(newOrderDetails);
        }
      },
    );
  }
}
