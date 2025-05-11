import 'dart:io';

import 'package:e_commerce/admin/cubit/admin_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ChosenImages extends StatelessWidget {
  final XFile? image;
  const ChosenImages({super.key, required this.image});

  @override
  Widget build(BuildContext context) => Stack(
        clipBehavior: Clip.none,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: kIsWeb
                ? FutureBuilder<Uint8List>(
                    future: image!.readAsBytes(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Image.memory(
                          snapshot.data!,
                          fit: BoxFit.cover,
                          width: 120,
                          height: 120,
                        );
                      }
                      return Container(
                        width: 120,
                        height: 120,
                        color: Theme.of(context).colorScheme.tertiaryFixedDim,
                      );
                    },
                  )
                : Image.file(
                    File(image!.path),
                    fit: BoxFit.cover,
                    width: 120,
                    height: 120,
                  ),
          ),
          Positioned(
            top: -12,
            right: -12,
            child: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.errorContainer,
                ),
                child: Icon(
                  Icons.close_outlined,
                  size: 16,
                  color: Theme.of(context).colorScheme.surfaceContainer,
                ),
              ),
              onPressed: () => context.read<AdminCubit>().removeImage(image!),
            ),
          ),
        ],
      );
}
