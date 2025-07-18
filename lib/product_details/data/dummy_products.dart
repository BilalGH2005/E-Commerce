import '../../shop/data/models/filtered_products_model.dart';

final dummyProduct = Product(
  id: '550e8400-e29b-41d4-a716-446655440000',
  addedAt: DateTime.parse('2024-01-15 09:30:00+00'),
  name: 'MacBook Pro 16-inch',
  description: '16-inch laptop with M2 Pro chip- 32GB RAM- 1TB SSD',
  price: 2499.99,
  category: Category(
      id: 'sd',
      name: 't-shirt',
      discount: 25,
      discountExpirationDate: DateTime.now()),
  imagesUrls: [
    "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/mbp16-spacegray-select-202301",
    "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/mbp16-spacegray-gallery1-202301"
  ],
  colors: [Color(id: 'd', hexCode: 'dsd', name: 'sd')],
  sizes: [Size(id: 'ds', name: 'sdd')],
);

final dummyProductsList = [
  dummyProduct,
  dummyProduct,
  dummyProduct,
  dummyProduct,
  dummyProduct,
  dummyProduct,
  dummyProduct,
  dummyProduct,
  dummyProduct,
  dummyProduct,
  dummyProduct,
  dummyProduct,
];
