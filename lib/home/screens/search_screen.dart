import 'package:e_commerce/home/widgets/search_field.dart';
import 'package:e_commerce/home/widgets/search_product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/reusable_widgets/reusable_error_widget.dart';
import '../../core/utils/async.dart';
import '../cubit/home_cubit.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: SearchField(),
            ),
            Expanded(
              child: BlocBuilder<HomeCubit, HomeState>(
                buildWhen: (_, state) => state is SearchStateChanged,
                builder: (context, state) {
                  final cubit = context.read<HomeCubit>();
                  return Center(
                    child: AsyncBuilder(
                      value: cubit.searchProductsList,
                      loading: (context) => CircularProgressIndicator(),
                      data: (context, products) => products.isNotEmpty
                          ? ListView.builder(
                              itemCount: products.length,
                              itemBuilder: (context, index) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child:
                                    SearchProductCard(product: products[index]),
                              ),
                            )
                          : Text(
                              'No matching products found',
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                      error: (context, error) => ReusableErrorWidget(
                        error: error.toString(),
                        buttonLabel: AppLocalizations.of(context)!.retry,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
