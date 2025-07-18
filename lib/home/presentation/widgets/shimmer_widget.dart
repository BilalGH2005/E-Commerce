import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 5,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 210,
            mainAxisExtent: 325,
            crossAxisSpacing: 12.0,
            mainAxisSpacing: 12.0,
            childAspectRatio: 210 / 325,
          ),
          itemBuilder: (context, index) => Shimmer.fromColors(
            baseColor: Theme.of(context).colorScheme.surfaceContainer,
            highlightColor: Theme.of(context).colorScheme.tertiary,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ),
      );
}
