class AddressDetailsModel {
  final int apartmentNumber;
  final int unitNumber;
  final int floorNumber;
  final String streetAddress;
  final String apartmentComplexName;
  final String city;
  final int zipcode;
  final String state;

  AddressDetailsModel({
    required this.apartmentNumber,
    required this.unitNumber,
    required this.floorNumber,
    required this.streetAddress,
    required this.apartmentComplexName,
    required this.city,
    required this.zipcode,
    required this.state,
  });

  factory AddressDetailsModel.fromMap(Map<String, dynamic> map) {
    return AddressDetailsModel(
      apartmentNumber: map['appartment_number'],
      unitNumber: map['unit_number'],
      floorNumber: map['floor_number'],
      streetAddress: map['street_address'],
      apartmentComplexName: map['appartment_complex_name'],
      city: map['city'],
      zipcode: map['zipcode'],
      state: map['state'],
    );
  }
}
