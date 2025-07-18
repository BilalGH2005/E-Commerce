import 'package:e_commerce/core/utils/duration_extension.dart';
import 'package:e_commerce/shop/cubit/shop_cubit.dart';
import 'package:e_commerce/shop/data/models/shop_metadata_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/hex_color.dart';

class ColorButton extends StatelessWidget {
  final SimpleColor color;

  const ColorButton(this.color, {super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ShopCubit>();
    final isSelected = cubit.draftFilters.colorId == color.id;
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      child: AnimatedContainer(
        duration: 300.ms,
        padding: isSelected ? const EdgeInsets.all(4) : EdgeInsets.zero,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: HexColor(color.hexCode),
        ),
        child: AnimatedContainer(
          duration: 300.ms,
          padding: isSelected ? const EdgeInsets.all(3) : EdgeInsets.zero,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSelected
                ? Theme.of(context).colorScheme.surface
                : Colors.transparent,
          ),
          child: AnimatedContainer(
            duration: 300.ms,
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: HexColor(color.hexCode),
            ),
          ),
        ),
      ),
      onTap: () {
        final newColorId = isSelected ? null : color.id;
        final newFilters = cubit.draftFilters.copyWith(colorId: newColorId);
        cubit.updateFilter(newFilters);
      },
    );
  }
}
