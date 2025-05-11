import 'package:e_commerce/core/utils/localization.dart';
import 'package:e_commerce/core/widgets/app_error_widget.dart';
import 'package:e_commerce/core/widgets/app_field.dart';
import 'package:e_commerce/home/cubit/home_cubit.dart';
import 'package:e_commerce/home/models/product.dart';
import 'package:e_commerce/home/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_async_value/async_value.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    context.read<HomeCubit>().initializeFuzzySearch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<HomeCubit, HomeState>(
        buildWhen: (_, state) => state is SearchStateChanged,
        builder: (context, state) {
          final cubit = context.read<HomeCubit>();
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: AppField(
                      controller: context.read<HomeCubit>().searchController,
                      hintText: localization(context).searchHere,
                      autoFocus: true,
                      onChanged: (newValue) => cubit.searchProducts(newValue),
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          cubit.searchController.clear();
                          cubit.searchProducts('');
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: AsyncBuilder<List<Product>>(
                        value: cubit.searchProductsList,
                        loading: (context) => const CircularProgressIndicator(),
                        data: (context, products) => products.isNotEmpty
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0),
                                child: GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount:
                                        HomeCubit.searchScreenColumns(
                                            MediaQuery.sizeOf(context).width),
                                    mainAxisExtent: 100,
                                    mainAxisSpacing: 12,
                                  ),
                                  itemCount: products.length,
                                  itemBuilder: (context, index) =>
                                      ProductCardBuilder(
                                    product: products[index],
                                    type: ProductCardType.search,
                                  ),
                                ),
                              )
                            : Text(
                                localization(context).noProductsFound,
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                        error: (context, error) => AppErrorWidget(
                          // error: error.toString(),
                          error: localization(context).somethingWentWrong,
                          buttonLabel: localization(context).retry,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
}
