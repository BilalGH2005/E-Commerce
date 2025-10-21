import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/core/utils/shortcuts.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CachedImage extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? width;
  final double borderRadius;
  final BoxFit fit;

  const CachedImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.borderRadius = 8,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: BorderRadius.circular(borderRadius),
    child: SizedBox(
      width: width,
      height: height,
      child: CachedNetworkImage(
        fit: fit,
        imageUrl: imageUrl,
        placeholder: (context, url) => Center(
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(color: colorScheme(context).tertiary),
            ),
          ),
        ),
        errorWidget: (context, url, error) => Center(
          child: SizedBox(
            height: 180,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error),
                const SizedBox(height: 3),
                Text(
                  localization(context).somethingWentWrong,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10,
                    color: colorScheme(context).tertiaryFixed,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
