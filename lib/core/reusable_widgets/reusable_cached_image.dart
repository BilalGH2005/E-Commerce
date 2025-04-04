import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ReusableCachedImage extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;
  const ReusableCachedImage({
    super.key,
    required this.imageUrl,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: width,
        height: height,
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: imageUrl,
          placeholder: (context, url) =>
              const Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => Center(
            child: SizedBox(
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error),
                  SizedBox(height: 3),
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
}
