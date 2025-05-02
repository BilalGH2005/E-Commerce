import 'package:e_commerce/admin/cubit/admin_cubit.dart';
import 'package:e_commerce/admin/widgets/choosing_image_widget.dart';
import 'package:e_commerce/core/utils/localization.dart';
import 'package:e_commerce/core/widgets/app_button.dart';
import 'package:e_commerce/core/widgets/app_dropdown_button.dart';
import 'package:e_commerce/core/widgets/app_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//TODO: fix keyboard disappear
class AdminScreen extends StatelessWidget {
  AdminScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AdminCubit>();
    return Scaffold(
      body: BlocBuilder<AdminCubit, AdminState>(
        builder: (context, state) {
          final bool isLoading = cubit.adminStatus == 0;
          return Center(
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(maxWidth: 768, minHeight: double.infinity),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              localization(context).addNewProduct,
                              textAlign: TextAlign.start,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        AppField(
                          textInputAction: TextInputAction.next,
                          controller: cubit.nameTextController,
                          label: localization(context).name,
                          validator: (value) => AdminCubit.nameValidator(
                              context: context, value: value),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: AppDropdownButton(
                                items: ['Men', 'Women', 'Kids', 'Babies'],
                                value: cubit.selectedValue,
                                onChanged: (newValue) =>
                                    cubit.categoryValue(newValue),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: AppField(
                                prefixIcon: const Icon(
                                  Icons.attach_money_outlined,
                                  size: 16,
                                ),
                                textInputAction: TextInputAction.next,
                                controller: cubit.priceTextController,
                                label: localization(context).price,
                                keyboardType: TextInputType.number,
                                validator: (value) => AdminCubit.priceValidator(
                                    context: context, value: value),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        AppField(
                          controller: cubit.descriptionTextController,
                          label: localization(context).description,
                          maxLines: 3,
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: 20),
                        ChoosingImageWidget(
                          onPressed: () async {
                            final isMobile = defaultTargetPlatform ==
                                    TargetPlatform.android ||
                                defaultTargetPlatform == TargetPlatform.iOS;
                            isMobile
                                ? await cubit.showImagePickerSheet(context)
                                : await cubit.pickFromGallery();
                          },
                        ),
                        const SizedBox(height: 45),
                        AppButton(
                          onPressed: isLoading
                              ? () async => await cubit.insertProduct(
                                  context: context, formKey: formKey)
                              : null,
                          label: isLoading
                              ? Text(localization(context).add,
                                  style: Theme.of(context).textTheme.bodyMedium)
                              : CircularProgressIndicator(
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
