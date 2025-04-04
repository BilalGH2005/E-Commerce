import 'package:e_commerce/core/utils/async.dart';
import 'package:e_commerce/home/widgets/products_grid.dart';
import 'package:e_commerce/home/widgets/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/reusable_widgets/reusable_error_widget.dart';
import '../cubit/home_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => HomeCubit()..fetchProducts(),
        lazy: false,
        child: Scaffold(
          //TODO: solve appbar color to be const (terms appbar too)
          appBar: AppBar(
            title: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/images/app_logo.svg',
                    height: 31,
                    width: 38,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'E-Commerce',
                    style: Theme.of(context).textTheme.titleLarge,
                  )
                ],
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 16.0, right: 16.0, left: 16.0),
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                final cubit = context.read<HomeCubit>();
                return AsyncBuilder(
                  value: cubit.products!,
                  loading: (context) {
                    return const ShimmerWidget();
                  },
                  data: (context, products) {
                    return ProductsGrid(products: products);
                  },
                  error: (context, error) {
                    return ReusableErrorWidget(
                        error: AppLocalizations.of(context)!.somethingWentWrong,
                        buttonLabel: AppLocalizations.of(context)!.retry);
                  },
                );
              },
            ),
          ),
        ),
      );
}
