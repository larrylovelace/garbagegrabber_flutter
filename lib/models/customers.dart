class UserData {
  final String email;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String qrCodeIdentifier;

  UserData({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.qrCodeIdentifier,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      phoneNumber: json['phone_number'],
      qrCodeIdentifier: json['qr_code_identifier'],
    );
  }
}
