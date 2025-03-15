import 'package:e_commerce/home/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/widgets/reusable_button.dart';

class ReusableErrorWidget extends StatelessWidget {
  final String error, buttonLabel;
  const ReusableErrorWidget(
      {super.key, required this.error, required this.buttonLabel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            error,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 14),
          ReusableButton(
            onPressed: () async {
              await context.read<HomeCubit>().fetchProducts();
            },
            label: Text(buttonLabel,
                style: Theme.of(context).textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }
}
