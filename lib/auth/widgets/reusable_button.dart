import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/auth_cubit.dart';

class ReusableButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  const ReusableButton(
      {super.key, required this.onPressed, required this.label});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthCubitState>(
      builder: (context, state) {
        final isLoading = context.watch<AuthCubit>().authStatus == 0;
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: Size(double.infinity, 55),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4 /*10*/),
            ),
          ),
          onPressed: isLoading ? onPressed : null,
          child: isLoading
              ? Text(
                  label,
                  style: TextStyle(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                )
              : CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primary,
                ),
        );
      },
    );
  }
}
