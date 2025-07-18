import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/localization.dart';
import '../../cubit/shop_cubit.dart';

class PriceRangeWidget extends StatelessWidget {
  const PriceRangeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ShopCubit>();
    final shopMetadata = cubit.shopMetadata.data!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          localization(context).priceRange,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        SizedBox(height: 5),
        RangeSlider(
          labels: RangeLabels(
            _formatPrice(
              cubit.draftFilters.priceRange?.start,
              shopMetadata.minPrice,
            ),
            _formatPrice(
              cubit.draftFilters.priceRange?.end,
              shopMetadata.maxPrice,
            ),
          ),
          min: shopMetadata.minPrice,
          max: shopMetadata.maxPrice,
          divisions: (shopMetadata.maxPrice - shopMetadata.minPrice).round(),
          values: cubit.draftFilters.priceRange ??
              RangeValues(shopMetadata.minPrice, shopMetadata.maxPrice),
          onChanged: (newRange) {
            final newFilters =
                cubit.draftFilters.copyWith(priceRange: newRange);
            cubit.updateFilter(newFilters);
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '\$${shopMetadata.minPrice.floor().toString()}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              '\$${shopMetadata.maxPrice.ceil().toString()}',
              style: Theme.of(context).textTheme.headlineMedium,
            )
          ],
        ),
      ],
    );
  }
}

String _formatPrice(double? value, double fallback) {
  return '\$${(value ?? fallback).toStringAsFixed(0)}';
}
