class Product {
  final int id;
  final String name;
  final double price;
  final String plan;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.plan,
  });
}

class UpcomingPickup {
  final String upcomingPickup;
  final int id;
  final Product product;

  UpcomingPickup({
    required this.upcomingPickup,
    required this.id,
    required this.product,
  });
} 