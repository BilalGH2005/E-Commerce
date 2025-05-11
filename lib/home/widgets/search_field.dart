import 'package:e_commerce/core/utils/localization.dart';
import 'package:e_commerce/home/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<HomeCubit, HomeState>(
        buildWhen: (_, state) => state is SearchStateChanged,
        builder: (context, state) {
          final cubit = context.read<HomeCubit>();
          return TextField(
            autofocus: true,
            onTapOutside: (PointerDownEvent event) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            onChanged: (newValue) => cubit.searchProducts(newValue),
            controller: cubit.searchController,
            style: Theme.of(context).textTheme.displaySmall,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  cubit.searchController.clear();
                  cubit.searchProducts('');
                },
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(45)),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(45)),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              hintText: localization(context).searchHere,
            ),
          );
        },
      );
}
