import 'package:e_commerce/home/cubit/home_cubit.dart';
import 'package:e_commerce/home/presentation/widgets/home_data_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_async_value/flutter_async_value.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/shortcuts.dart';
import '../../../core/widgets/app_error_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            final cubit = context.read<HomeCubit>();
            return AsyncValueBuilder(
              value: cubit.homeMetadataModel,
              loading: (_) => Center(child: CircularProgressIndicator()),
              data: (_, homeMetaDataModel) {
                return HomeDataView(homeMetaDataModel: homeMetaDataModel);
              },
              error: (_, _) => AppErrorWidget(
                error: localization(context).somethingWentWrong,
                labelWidget: Text(
                  localization(context).retry,
                  style: textTheme(
                    context,
                  ).bodyMedium!.copyWith(color: colorScheme(context).surface),
                ),
                onPressed: () async {
                  await cubit.getHomeMetadata();
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
