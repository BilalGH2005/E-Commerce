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
    return BlocProvider(
      create: (context) => AdminCubit(),
      child: Scaffold(
        body: BlocBuilder<AdminCubit, AdminState>(
          builder: (context, state) {
            final cubit = context.read<AdminCubit>();
            final bool isLoading = cubit.adminStatus == 0;
            //TODO: fix keyboard disappear
            return Center(
              child: ConstrainedBox(
                constraints:
                    BoxConstraints(maxWidth: 500, minHeight: double.infinity),
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
                          SizedBox(height: 20),
                          SizedBox(
                            height: 300,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(children: [
                                  Expanded(
                                    child: ProductField(
                                      textInputAction: TextInputAction.next,
                                      controller: nameTextController,
                                      label: AppLocalizations.of(context)!.name,
                                      validator: (value) =>
                                          AdminCubit.nameValidator(value),
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
                                      label:
                                          AppLocalizations.of(context)!.price,
                                      keyboardType: TextInputType.number,
                                      validator: (value) =>
                                          AdminCubit.priceValidator(value),
                                    ),
                                  ),
                                ]),
                                ProductField(
                                  controller: descriptionTextController,
                                  label:
                                      AppLocalizations.of(context)!.description,
                                  maxLines: 3,
                                  textInputAction: TextInputAction.next,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: ReusableDropdownButton(
                                        items: [
                                          'Men',
                                          'Women',
                                          'Kids',
                                          'Babies'
                                        ],
                                        value: cubit.selectedValue,
                                        onChanged: (newValue) =>
                                            cubit.categoryValue(newValue),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Expanded(
                                      flex: 3,
                                      child: ProductField(
                                        controller: imageUrl,
                                        label: AppLocalizations.of(context)!
                                            .imageUrl,
                                        validator: (value) =>
                                            AdminCubit.imageUrlValidator(value),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 45),
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
                                    style:
                                        Theme.of(context).textTheme.bodyMedium)
                                : CircularProgressIndicator(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
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
      ),
    );
  }
}
