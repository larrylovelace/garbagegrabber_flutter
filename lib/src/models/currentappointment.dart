class CurrentAppointment {
  final int quantity;
  final String currency;
  final String transactionId;
  final DateTime paymentAt;
  final Product product;
  final String appointmentDateStart;
  final String appointmentTimeStart;
  final String appointmentTimeEnd;
  final List<Pickup> pickups;
  final double totalPayment;

  CurrentAppointment({
    required this.quantity,
    required this.currency,
    required this.transactionId,
    required this.paymentAt,
    required this.product,
    required this.appointmentDateStart,
    required this.appointmentTimeStart,
    required this.appointmentTimeEnd,
    required this.pickups,
    required this.totalPayment,
  });

  factory CurrentAppointment.fromJson(Map<String, dynamic> json) {
    List<dynamic> pickupsData = json['pickups'];
    List<Pickup> pickups = pickupsData.map((item) => Pickup.fromJson(item)).toList();

    return CurrentAppointment(
      quantity: json['quantity'],
      currency: json['currency'],
      transactionId: json['transaction_id'],
      paymentAt: DateTime.parse(json['payment_at']),
      product: Product.fromJson(json['product']),
      appointmentDateStart: json['appointment_date_start'],
      appointmentTimeStart: json['appointment_time_start'],
      appointmentTimeEnd: json['appointment_time_end'],
      pickups: pickups,
      totalPayment: json['total_payment'],
    );
  }
}

class Pickup {
  final int id;
  final String pickupDate;
  final DateTime? pickedDateTime;
  final bool picked;
  final bool confirmed;
  final int customer;
  final int appointment;

  Pickup({
    required this.id,
    required this.pickupDate,
    this.pickedDateTime,
    required this.picked,
    required this.confirmed,
    required this.customer,
    required this.appointment,
  });

  factory Pickup.fromJson(Map<String, dynamic> json) {
    return Pickup(
      id: json['id'],
      pickupDate: json['pickup_date'],
      pickedDateTime: json['picked_date_time'] != null ? DateTime.parse(json['picked_date_time']) : null,
      picked: json['picked'],
      confirmed: json['confirmed'],
      customer: json['customer'],
      appointment: json['appointment'],
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
