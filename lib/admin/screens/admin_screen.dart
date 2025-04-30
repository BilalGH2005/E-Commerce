import 'package:e_commerce/admin/widgets/choose_image_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/reusable_widgets/reusable_button.dart';
import '../../core/reusable_widgets/reusable_dropdown_button.dart';
import '../cubit/admin_cubit.dart';
import '../widgets/product_field.dart';

class AdminScreen extends StatelessWidget {
  AdminScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameTextController = TextEditingController(),
      descriptionTextController = TextEditingController(),
      priceTextController = TextEditingController(),
      imageUrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AdminCubit, AdminState>(
        builder: (context, state) {
          final cubit = context.read<AdminCubit>();
          final bool isLoading = cubit.adminStatus == 0;
          //TODO: fix keyboard disappear
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
                              AppLocalizations.of(context)!.addNewProduct,
                              textAlign: TextAlign.start,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        ProductField(
                          textInputAction: TextInputAction.next,
                          controller: nameTextController,
                          label: AppLocalizations.of(context)!.name,
                          validator: (value) => AdminCubit.nameValidator(value),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: ReusableDropdownButton(
                                items: ['Men', 'Women', 'Kids', 'Babies'],
                                value: cubit.selectedValue,
                                onChanged: (newValue) =>
                                    cubit.categoryValue(newValue),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: ProductField(
                                prefixIcon: const Icon(
                                  Icons.attach_money_outlined,
                                  size: 16,
                                ),
                                textInputAction: TextInputAction.next,
                                controller: priceTextController,
                                label: AppLocalizations.of(context)!.price,
                                keyboardType: TextInputType.number,
                                validator: (value) =>
                                    AdminCubit.priceValidator(value),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        ProductField(
                          controller: descriptionTextController,
                          label: AppLocalizations.of(context)!.description,
                          maxLines: 3,
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: 20),
                        ChooseImageWidget(
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
                        ReusableButton(
                          onPressed: isLoading
                              ? () async => await cubit.insertProduct(
                                  formKey: formKey,
                                  name: nameTextController.text,
                                  description: descriptionTextController.text,
                                  price: priceTextController.text,
                                  imageUrl: imageUrl.text)
                              : null,
                          label: isLoading
                              ? Text(AppLocalizations.of(context)!.add,
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
