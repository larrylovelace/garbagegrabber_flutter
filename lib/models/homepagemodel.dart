class CustomerData {
  CustomerDataCustomerData? customerData;
  List<AllProducts>? allProducts;

  CustomerData({this.customerData, this.allProducts});

  CustomerData.fromJson(Map<String, dynamic> json) {
    customerData = json['customer_data'] != null ? CustomerDataCustomerData.fromJson(json['customer_data']) : null;
    if (json['all_products'] != null) {
      allProducts = <AllProducts>[];
      json['all_products'].forEach((v) {
        allProducts!.add(AllProducts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (customerData != null) {
      data['customer_data'] = customerData!.toJson();
    }
    if (allProducts != null) {
      data['all_products'] = allProducts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomerDataCustomerData {
  String? email;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? qrCodeIdentifier;
  UpcomingPickup? upcomingPickup;

  CustomerDataCustomerData({this.email, this.firstName, this.lastName, this.phoneNumber, this.qrCodeIdentifier, this.upcomingPickup});

  CustomerDataCustomerData.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phoneNumber = json['phone_number'];
    qrCodeIdentifier = json['qr_code_identifier'];
    upcomingPickup = json['upcoming_pickup'] != null ? UpcomingPickup.fromJson(json['upcoming_pickup']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['phone_number'] = phoneNumber;
    data['qr_code_identifier'] = qrCodeIdentifier;
    if (upcomingPickup != null) {
      data['upcoming_pickup'] = upcomingPickup!.toJson();
    }
    return data;
  }
}

class UpcomingPickup {
  String? upcomingPickup;
  int? id;
  Product? product;

  UpcomingPickup({this.upcomingPickup, this.id, this.product});

  UpcomingPickup.fromJson(Map<String, dynamic> json) {
    upcomingPickup = json['upcoming_pickup'];
    id = json['id'];
    product = json['product'] != null ? Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['upcoming_pickup'] = upcomingPickup;
    data['id'] = id;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    return data;
  }
}

class Product {
  int? id;
  String? name;
  double? price;
  String? plan;

  Product({this.id, this.name, this.price, this.plan});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    plan = json['plan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['plan'] = plan;
    return data;
  }
}

class AllProducts {
  int? id;
  String? name;
  double? price;
  String? plan;

  AllProducts({this.id, this.name, this.price, this.plan});

  AllProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    plan = json['plan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['plan'] = plan;
    return data;
  }
}
