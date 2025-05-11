import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CachedImage extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? width;
  const CachedImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(
          width: width,
          height: height,
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: imageUrl,
            placeholder: (context, url) => Center(
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  width: width,
                  height: height,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            errorWidget: (context, url, error) => Center(
              child: SizedBox(
                height: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error),
                    const SizedBox(height: 3),
                    Text(
                      "there's something might be wrong",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 10,
                          color: Theme.of(context).colorScheme.tertiaryFixed),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
