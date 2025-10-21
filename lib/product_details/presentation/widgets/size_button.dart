// import 'package:flutter/material.dart';
//
// class SizeButton extends StatelessWidget {
//   const SizeButton({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return ChoiceChip.elevated(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(30),
//       ),
//       label: Text(size.name),
//       selected: cubit.draftFilters.sizeId == size.id,
//       onSelected: (selected) {
//         final newSizeId = selected ? size.id : null;
//         final newFilters =
//         cubit.draftFilters.copyWith(sizeId: newSizeId);
//         cubit.updateFilter(newFilters);
//       },
//     ),
//   }
// }
