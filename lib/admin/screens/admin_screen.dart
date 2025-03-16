import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/widgets/reusable_button.dart';
import '../cubit/admin_cubit.dart';
import '../widgets/custom_drop_down_button.dart';
import '../widgets/product_field.dart';

class AdminScreen extends StatelessWidget {
  AdminScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController(),
      description = TextEditingController(),
      price = TextEditingController(),
      imageUrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => AdminCubit(),
      child: Scaffold(
        body: BlocBuilder<AdminCubit, AdminState>(
          builder: (context, state) {
            final cubit = context.read<AdminCubit>();
            final bool isLoading = cubit.adminStatus == 0;
            return SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(height: size.height * 0.01),
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
                      SizedBox(height: size.height * 0.03),
                      SizedBox(
                        height: size.height * 0.45,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(children: [
                              SizedBox(
                                width: size.width * 0.45,
                                child: ProductField(
                                  controller: name,
                                  label: AppLocalizations.of(context)!.name,
                                  validator: (value) =>
                                      AdminCubit.nameValidator(value),
                                ),
                              ),
                              Spacer(),
                              SizedBox(
                                width: size.width * 0.45,
                                child: ProductField(
                                  prefixIcon: Icon(
                                    Icons.attach_money_outlined,
                                    size: 16,
                                  ),
                                  controller: price,
                                  label: AppLocalizations.of(context)!.price,
                                  keyboardType: TextInputType.number,
                                  validator: (value) =>
                                      AdminCubit.priceValidator(value),
                                ),
                              ),
                            ]),
                            ProductField(
                              controller: description,
                              label: AppLocalizations.of(context)!.description,
                              maxLines: 3,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CustomDropDownButton(),
                                Spacer(),
                                SizedBox(
                                  width: size.width * 0.55,
                                  child: ProductField(
                                    controller: imageUrl,
                                    label:
                                        AppLocalizations.of(context)!.imageUrl,
                                    validator: (value) =>
                                        AdminCubit.imageUrlValidator(value),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: size.height * 0.08),
                      ReusableButton(
                        onPressed: isLoading
                            ? () async => await cubit.insertProduct(
                                formKey: formKey,
                                name: name.text,
                                description: description.text,
                                price: price.text,
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
            );
          },
        ),
      ),
    );
  }
}
