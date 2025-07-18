// class Product {
//   final String id;
//   final DateTime addedAt;
//   final String name;
//   final String description;
//   final double price;
//   final String category;
//   final List<String> imagesUrl;
//   final List<String> colors;
//   final List<String> sizes;
//
//   Product(
//       {required this.id,
//       required this.addedAt,
//       required this.name,
//       required this.description,
//       required this.price,
//       required this.category,
//       required this.imagesUrl,
//       required this.colors,
//       required this.sizes});
//
//   factory Product.fromJson(Map<String, dynamic> product) => Product(
//         id: product['id'],
//         addedAt: DateTime.parse(product['added_at']),
//         name: product['name'],
//         description: product['description'],
//         price: (product['price'] as num).toDouble(),
//         category: product['category_id'],
//         imagesUrl:
//             (product['images_url'] as List).map((e) => e.toString()).toList(),
//         colors: (product['colors'] as List).map((e) => e.toString()).toList(),
//         sizes: (product['sizes'] as List).map((e) => e.toString()).toList(),
//       );
// }
