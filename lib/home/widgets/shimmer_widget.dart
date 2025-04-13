import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 164,
        mainAxisExtent: 239,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        childAspectRatio: 164 / 239,
      ),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          /*gradient: LinearGradient(colors: [
            Theme.of(context).colorScheme.surfaceContainer,
            Theme.of(context).colorScheme.tertiaryFixedDim
          ]),*/
          baseColor: Theme.of(context).colorScheme.surfaceContainer,
          highlightColor: Theme.of(context).colorScheme.tertiary,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        );
      },
    );
  }
}
