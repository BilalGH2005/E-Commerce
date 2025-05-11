import 'package:e_commerce/core/utils/localization.dart';
import 'package:e_commerce/core/widgets/app_error_widget.dart';
import 'package:e_commerce/home/cubit/home_cubit.dart';
import 'package:e_commerce/home/models/product.dart';
import 'package:e_commerce/home/widgets/home_appbar.dart';
import 'package:e_commerce/home/widgets/home_content.dart';
import 'package:e_commerce/home/widgets/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_async_value/async_value.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<HomeCubit>().fetchProducts();
    context.read<HomeCubit>().fetchCartItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const HomeAppBar(),
        body: BlocBuilder<HomeCubit, HomeState>(
          buildWhen: (_, state) => state is HomeStateChanged,
          builder: (context, state) {
            final cubit = context.read<HomeCubit>();
            return AsyncBuilder<List<Product>>(
              value: cubit.products,
              loading: (context) => const ShimmerWidget(),
              data: (context, products) => HomeContent(products: products),
              error: (context, error) => AppErrorWidget(
                // error: error.toString(),
                error: localization(context).somethingWentWrong,
                buttonLabel: localization(context).retry,
              ),
            );
          },
        ),
      );
}
