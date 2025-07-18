import 'package:e_commerce/core/router/temp_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TempScreen extends StatelessWidget {
  const TempScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TempCubit(),
      child: BlocBuilder<TempCubit, TempState>(
        builder: (context, state) {
          final cubit = context.read<TempCubit>();
          return Scaffold(
            body: Center(
              child: Wrap(
                children: [
                  ChoiceChip.elevated(
                    label: Text('test1'),
                    selected: cubit.selected2,
                    onSelected: (value) {},
                  ),
                  ChoiceChip.elevated(
                    label: Text('test2'),
                    selected: cubit.selected,
                    onSelected: (value) {
                      cubit.toggleSelected(value);
                    },
                  ),
                  ChoiceChip.elevated(label: Text('test3'), selected: false),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
