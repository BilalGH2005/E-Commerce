import 'package:e_commerce/core/constants/app_colors.dart';
import 'package:e_commerce/core/utils/shortcuts.dart';
import 'package:e_commerce/core/widgets/cached_image.dart';
import 'package:e_commerce/home/data/models/home_metadata_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_routes.dart';

class CollectionCard extends StatelessWidget {
  final Collection collection;

  const CollectionCard({super.key, required this.collection});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CachedImage(
          imageUrl: collection.imageUrl,
          width: 400,
          height: 400,
          borderRadius: 0,
        ),
        Positioned(
          bottom: 32,
          left: 32,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                collection.name,
                style: textTheme(
                  context,
                ).titleMedium!.copyWith(color: Colors.white),
              ),
              SizedBox(height: 8),
              InkWell(
                onTap: () {
                  context.pushNamed(
                    AppRoutes.collection.name,
                    pathParameters: {'collection_id': collection.id},
                  );
                },
                child: Row(
                  children: [
                    Text(
                      localization(context).collection,
                      style: textTheme(context).displaySmall!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward_outlined,
                      size: 16,
                      color: AppColors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
