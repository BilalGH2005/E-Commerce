import 'package:e_commerce/admin/cubit/admin_cubit.dart';
import 'package:e_commerce/admin/widgets/chosen_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChooseImageWidget extends StatelessWidget {
  final void Function()? onPressed;
  const ChooseImageWidget({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final selectedImages = context.watch<AdminCubit>().selectedImages;
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.only(left: 8, right: 12),
        width: double.infinity,
        height: 132,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
        child: selectedImages.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.camera_alt_outlined,
                      size: 60,
                    ),
                    Text(
                      'Choose an image...',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                ),
              )
            : SizedBox(
                height: 120,
                child: AnimatedSize(
                  duration: const Duration(milliseconds: 100),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ...selectedImages.map(
                          (image) {
                            return AnimatedSwitcher(
                              duration: const Duration(milliseconds: 100),
                              child: Padding(
                                key: ValueKey(image!.path),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: ChosenImages(
                                  image: image,
                                ),
                              ),
                            );
                          },
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
