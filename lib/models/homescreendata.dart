class CustomerData {
  final String email;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String qrCodeIdentifier;

  CustomerData({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.qrCodeIdentifier,
  });

  factory CustomerData.fromJson(Map<String, dynamic> json) {
    return CustomerData(
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      phoneNumber: json['phone_number'],
      qrCodeIdentifier: json['qr_code_identifier'],
    );
  }
}

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

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'].toDouble(),
      plan: json['plan'],
    );
  }
}

class HomeScreenData {
  final CustomerData customerData;
  final List<Product> allProducts;
  final String upcomingPickupDate;

  HomeScreenData({
    required this.customerData,
    required this.allProducts,
    required this.upcomingPickupDate,
  });

  factory HomeScreenData.fromJson(Map<String, dynamic> json) {
    final customerDataJson = json['customer_data'] as Map<String, dynamic>;
    final allProductsJson = json['all_products'] as List<dynamic>;

    final customerData = CustomerData.fromJson(customerDataJson);

    final allProducts = allProductsJson.map((productJson) {
      return Product.fromJson(productJson as Map<String, dynamic>);
    }).toList();

    return HomeScreenData(
      customerData: customerData,
      allProducts: allProducts,
      upcomingPickupDate: json['upcoming_pickup_date'],
    );
  }
}
