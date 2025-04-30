import 'package:e_commerce/core/utils/async.dart';
import 'package:e_commerce/home/widgets/home_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/reusable_widgets/reusable_error_widget.dart';
import '../cubit/home_cubit.dart';
import '../widgets/dashboard.dart';
import '../widgets/shimmer_widget.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(),
      body: BlocBuilder<HomeCubit, HomeState>(
        buildWhen: (_, state) => state is HomeStateChanged,
        builder: (context, state) {
          final cubit = context.read<HomeCubit>();
          return AsyncBuilder(
            value: cubit.products,
            loading: (context) => const ShimmerWidget(),
            data: (context, products) => Dashboard(products: products),
            error: (context, error) => ReusableErrorWidget(
              error: error.toString(),
              /*error: AppLocalizations.of(context)!.somethingWentWrong,*/
              buttonLabel: AppLocalizations.of(context)!.retry,
            ),
          );
        },
      ),
    );
  }
}
