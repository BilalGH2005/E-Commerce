import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'THIS IS SEARCH SCREEN (PLACEHOLDER)',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
