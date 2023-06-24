import 'package:hive/hive.dart';

part 'products.g.dart';

@HiveType(typeId: 0)
class Products extends HiveObject {
  @HiveField(0)
  final String firstname;

  @HiveField(1)
  final List<ProductData> productDatas;

  Products({
    required this.firstname,
    required this.productDatas,
  });
}

@HiveType(typeId: 1)
class ProductData extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final double price;

  @HiveField(3)
  final String plan;

  ProductData({
    required this.id,
    required this.name,
    required this.price,
    required this.plan,
  });
}
