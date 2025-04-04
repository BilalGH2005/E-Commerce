class Product {
  final int id;
  final DateTime addedAt;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String category;

  Product({
    required this.id,
    required this.addedAt,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
  });

  factory Product.fromProducts(Map<String, dynamic> product) => Product(
        id: product['id'],
        addedAt: DateTime.parse(product['added_at']),
        name: product['name'],
        description: product['description'],
        price: product['price'].toDouble(),
        imageUrl: product['image_url'],
        category: product['category'],
      );
}
