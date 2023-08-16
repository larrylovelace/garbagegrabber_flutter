class AppointmentData {
  late final List<Appointment> activeAppointments;
  final List<Appointment> inactiveAppointments;

  AppointmentData({
    required this.activeAppointments,
    required this.inactiveAppointments,
  });

  factory AppointmentData.fromJson(Map<String, dynamic> json) {
    List<dynamic> activeAppointmentsData = json['active'];
    List<Appointment> activeAppointments = activeAppointmentsData
        .map((item) => Appointment.fromJson(item))
        .toList();

    List<dynamic> inactiveAppointmentsData = json['past'];
    List<Appointment> inactiveAppointments = inactiveAppointmentsData
        .map((item) => Appointment.fromJson(item))
        .toList();

    return AppointmentData(
      activeAppointments: activeAppointments,
      inactiveAppointments: inactiveAppointments,
    );
  }
}

class Appointment {
  final int id;
  final int quantity;
  final String currency;
  final String transactionId;
  final DateTime paymentAt;
  final Product product;
  final String appointmentDateStart;
  final String appointmentDateEnd;
  final String appointmentTimeStart;
  final String appointmentTimeEnd;
  final double totalPayment;
  final bool isActive;
  final List<Pickup> pickups; // New property for pickups

  Appointment({
    required this.id,
    required this.quantity,
    required this.currency,
    required this.transactionId,
    required this.paymentAt,
    required this.product,
    required this.appointmentDateStart,
    required this.appointmentDateEnd,
    required this.appointmentTimeStart,
    required this.appointmentTimeEnd,
    required this.totalPayment,
    required this.isActive,
    required this.pickups, // Initialize the pickups property
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    List<dynamic> pickupsData = json['pickups'];
    List<Pickup> pickups =
        pickupsData.map((item) => Pickup.fromJson(item)).toList();

    return Appointment(
      id: json['id'],
      quantity: json['quantity'],
      currency: json['currency'],
      transactionId: json['transaction_id'],
      paymentAt: DateTime.parse(json['payment_at']),
      product: Product.fromJson(json['product']),
      appointmentDateStart: json['appointment_date_start'],
      appointmentDateEnd: json['appointment_date_end'],
      appointmentTimeStart: json['appointment_time_start'],
      appointmentTimeEnd: json['appointment_time_end'],
      totalPayment: json['total_payment'],
      isActive: json['is_active'],
      pickups: pickups, // Assign the pickups property
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

class Pickup {
  final int id;
  final DateTime pickupDate;
  final DateTime? pickedDateTime;

  final int customer;
  final int appointment;

  Pickup({
    required this.id,
    required this.pickupDate,
    this.pickedDateTime,
    required this.customer,
    required this.appointment,
  });

  factory Pickup.fromJson(Map<String, dynamic> json) {
    return Pickup(
      id: json['id'],
      pickupDate: DateTime.parse(json['pickup_date']),
      pickedDateTime:
          json['picked_on'] != null ? DateTime.parse(json['picked_on']) : null,
      customer: json['customer'],
      appointment: json['appointment'],
    );
  }
}

class UpcomingPickup {
  final int pickupId;
  final DateTime pickupDate;

  UpcomingPickup({
    required this.pickupId,
    required this.pickupDate,
  });

  factory UpcomingPickup.fromJson(Map<String, dynamic> json) {
    return UpcomingPickup(
      pickupId: json['pickup_id'],
      pickupDate: DateTime.parse(json['pickup_date']),
    );
  }
}
