class UpcomingPickup {
  String upcomingPickup;
  int id;
  Product product;

  UpcomingPickup({
    required this.upcomingPickup,
    required this.id,
    required this.product,
  });

  factory UpcomingPickup.fromJson(Map<String, dynamic> json) {
    return UpcomingPickup(
      upcomingPickup: json['upcoming_pickup'],
      id: json['id'],
      product: Product.fromJson(json['product']),
    );
  }
}

class Product {
  int id;
  String name;
  double price;
  String plan;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.plan,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'].toDouble(),
      plan: json['plan'],
    );
  }
}
