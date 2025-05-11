import 'package:e_commerce/core/constants/breakpoints.dart';
import 'package:e_commerce/core/widgets/app_button.dart';
import 'package:e_commerce/home/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppErrorWidget extends StatelessWidget {
  final String error, buttonLabel;
  const AppErrorWidget(
      {super.key, required this.error, required this.buttonLabel});

  @override
  Widget build(BuildContext context) => Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
              maxWidth: Breakpoints.tabletWidth, minHeight: double.infinity),
          child: Padding(
            padding: const EdgeInsets.all(50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  error,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const SizedBox(height: 14),
                AppButton(
                  onPressed: () async {
                    await context.read<HomeCubit>().fetchProducts();
                  },
                  label: Text(buttonLabel,
                      style: Theme.of(context).textTheme.bodyMedium),
                ),
              ],
            ),
          ),
        ),
      );
}
