import 'package:e_commerce/core/utils/localization.dart';
import 'package:e_commerce/shop/presentation/widgets/shop_data_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_async_value/flutter_async_value.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/snackbar_util.dart';
import '../../../core/widgets/app_error_widget.dart';
import '../../cubit/shop_cubit.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ShopCubit, ShopState>(
        listenWhen: (_, state) => state is ShopLoadingMoreFailed,
        listener: (context, state) {
          SnackBarUtil.showError(localization(context).somethingWentWrong);
        },
        buildWhen: (_, state) => state is ShopStateChanged,
        builder: (context, state) {
          final cubit = context.read<ShopCubit>();
          return AsyncValueBuilder(
            value: cubit.shopMetadata,
            loading: (_) => Center(child: CircularProgressIndicator()),
            data: (_, data) => ShopDataView(),
            error: (_, __) => AppErrorWidget(
              error: localization(context).somethingWentWrong,
              labelWidget: Text(
                localization(context).retry,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Theme.of(context).colorScheme.surface),
              ),
              onPressed: () async {
                await cubit.getShopMetadata();
              },
            ),
          );
        },
      ),
    );
  }
}
