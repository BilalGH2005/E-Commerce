import 'package:e_commerce/home/widgets/products_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../cubit/home_cubit.dart';
import 'new_products_carousel.dart';

class Dashboard extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  const Dashboard({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: RefreshController(),
      onRefresh: () async => await context.read<HomeCubit>().fetchProducts(),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: NewProductsCarousel(),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 16),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            sliver: ProductsGrid(products: products),
          ),
        ],
      ),
    );
  }
}
