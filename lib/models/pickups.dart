class Appointment {
  int id;
  String pickupDate;
  DateTime pickedDateTime;
  bool picked;
  bool confirmed;
  int customer;
  int appointment;

  Appointment({
    required this.id,
    required this.pickupDate,
    required this.pickedDateTime,
    required this.picked,
    required this.confirmed,
    required this.customer,
    required this.appointment,
  });
  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'],
      pickupDate: json['pickup_date'],
      pickedDateTime: json['picked_date_time'] != null
          ? DateTime.parse(json['picked_date_time'])
          : DateTime(0), // or assign a default value if necessary
      picked: json['picked'],
      confirmed: json['confirmed'],
      customer: json['customer'],
      appointment: json['appointment'],
    );
  }
}
