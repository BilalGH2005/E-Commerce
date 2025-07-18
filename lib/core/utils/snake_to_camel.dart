extension SnakeToCamel on String {
  String get snakeToCamel {
    return split('_')
        .map((word) {
          if (word.isEmpty) return '';
          return word[0].toUpperCase() + word.substring(1).toLowerCase();
        })
        .join()
        .replaceFirstMapped(
          RegExp(r'^[A-Z]'),
          (match) => match.group(0)!.toLowerCase(),
        );
  }
}
