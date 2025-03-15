import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/admin_cubit.dart';

class CustomDropDownButton extends StatelessWidget {
  const CustomDropDownButton({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocBuilder<AdminCubit, AdminState>(
      builder: (context, state) {
        final cubit = context.read<AdminCubit>();
        return SizedBox(
          height: 55,
          width: size.width * 0.35,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSurface,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                menuWidth: size.width * 0.35,
                alignment: Alignment.center,
                isExpanded: true,
                dropdownColor: Theme.of(context).colorScheme.onSurface,
                style: Theme.of(context).textTheme.labelSmall,
                iconDisabledColor: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(10),
                value: cubit.selectedValue,
                onChanged: (newValue) => cubit.dropDownButtonValue(newValue),
                items: ['Play Station', 'Mobile', 'Desktop', 'Others']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    alignment: Alignment.center,
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}
