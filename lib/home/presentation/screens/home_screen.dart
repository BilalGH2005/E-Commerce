import 'package:e_commerce/core/utils/localization.dart';
import 'package:e_commerce/core/widgets/app_error_widget.dart';
import 'package:e_commerce/home/cubit/home_cubit.dart';
import 'package:e_commerce/home/presentation/widgets/home_appbar.dart';
import 'package:e_commerce/home/presentation/widgets/home_content.dart';
import 'package:e_commerce/home/presentation/widgets/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_async_value/flutter_async_value.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const HomeAppBar(),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (_, __) {
            final cubit = context.read<HomeCubit>();
            return AsyncValueBuilder(
              value: cubit.products,
              loading: (context) => const ShimmerWidget(),
              data: (context, products) => HomeContent(products: products),
              error: (context, _) => AppErrorWidget(
                error: localization(context).somethingWentWrong,
                labelWidget: Text(localization(context).retry),
                onPressed: () async => await cubit.initializeHome(),
              ),
            );
          },
        ),
      );
}
