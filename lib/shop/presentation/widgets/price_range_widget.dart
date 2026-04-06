import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/shortcuts.dart';
import '../controllers/shop_cubit.dart';

class PriceRangeWidget extends StatefulWidget {
  const PriceRangeWidget({super.key});

  @override
  State<PriceRangeWidget> createState() => _PriceRangeWidgetState();
}

class _PriceRangeWidgetState extends State<PriceRangeWidget> {
  late RangeValues _currentRange;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<ShopCubit>();
    final shopMetadata = cubit.shopMetadata.data!;

    _currentRange =
        cubit.draftFilters.priceRange ??
        RangeValues(shopMetadata.minPrice, shopMetadata.maxPrice);
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ShopCubit>();
    final shopMetadata = cubit.shopMetadata.data!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          localization(context).priceRange,
          style: textTheme(context).headlineMedium,
        ),
        SizedBox(height: 5),
        RangeSlider(
          labels: RangeLabels(
            _formatPrice(_currentRange.start, shopMetadata.minPrice),
            _formatPrice(_currentRange.end, shopMetadata.maxPrice),
          ),
          values: _currentRange,
          min: shopMetadata.minPrice,
          max: shopMetadata.maxPrice,
          divisions: (shopMetadata.maxPrice - shopMetadata.minPrice).round(),
          onChanged: (newRange) {
            setState(() {
              _currentRange = newRange;
            });
          },
          onChangeEnd: (finalRange) {
            final cubit = context.read<ShopCubit>();
            cubit.updateFilter(
              cubit.draftFilters.copyWith(priceRange: finalRange),
            );
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '\$${shopMetadata.minPrice.floor()}',
              style: textTheme(context).headlineMedium,
            ),
            Text(
              '\$${shopMetadata.maxPrice.ceil()}',
              style: textTheme(context).headlineMedium,
            ),
          ],
        ),
      ],
    );
  }
}

String _formatPrice(double? value, double fallback) {
  return '\$${(value ?? fallback).toStringAsFixed(0)}';
}
