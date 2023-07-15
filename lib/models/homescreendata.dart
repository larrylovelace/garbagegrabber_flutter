class HomeScreenData {
  final CustomerDetails customerDetails;
  final List<AllProducts> allProducts;
  final String upcomingPickupDate;

  HomeScreenData({
    required this.customerDetails,
    required this.allProducts,
    required this.upcomingPickupDate,
  });

  factory HomeScreenData.fromJson(Map<String, dynamic> json) {
    final customerData = json['customer_data'];
    final allProductsData = json['all_products'];

    return HomeScreenData(
      customerDetails: CustomerDetails.fromJson(customerData),
      allProducts: List<AllProducts>.from(
        allProductsData.map((product) => AllProducts.fromJson(product)),
      ),
      upcomingPickupDate: json['upcoming_pickup_date'],
    );
  }
}

class CustomerDetails {
  final String email;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String qrCodeIdentifier;

  CustomerDetails({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.qrCodeIdentifier,
  });

  factory CustomerDetails.fromJson(Map<String, dynamic> json) {
    return CustomerDetails(
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      phoneNumber: json['phone_number'],
      qrCodeIdentifier: json['qr_code_identifier'],
    );
  }
}

class AllProducts {
  final int id;
  final String name;
  final double price;
  final String plan;

  AllProducts({
    required this.id,
    required this.name,
    required this.price,
    required this.plan,
  });

  factory AllProducts.fromJson(Map<String, dynamic> json) {
    return AllProducts(
      id: json['id'],
      name: json['name'],
      price: json['price'].toDouble(),
      plan: json['plan'],
    );
  }
}
