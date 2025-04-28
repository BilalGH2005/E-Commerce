import 'package:e_commerce/admin/cubit/admin_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'image_picker_sheet_button.dart';

class ImagesPickerSheet extends StatelessWidget {
  const ImagesPickerSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Row(
        children: [
          Expanded(
            child: ImagePickerSheetButton(
              onPressed: () async {
                Navigator.pop(context);
                await context.read<AdminCubit>().pickFromCamera();
              },
              icon: Icons.camera,
              text: 'Camera',
            ),
          ),
          VerticalDivider(
            color: Theme.of(context).colorScheme.tertiaryFixedDim,
            thickness: 1,
            indent: 10,
            endIndent: 10,
          ),
          Expanded(
            child: ImagePickerSheetButton(
              onPressed: () async {
                Navigator.pop(context);
                await context.read<AdminCubit>().pickFromGallery();
              },
              icon: Icons.image_outlined,
              text: 'Gallery',
            ),
          ),
        ],
      ),
    );
  }
}
