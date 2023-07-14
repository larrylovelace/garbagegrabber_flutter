class StoreData {
  final String formattedAddress;
  final double latitude;
  final double longitude;

  StoreData({
    required this.formattedAddress,
    required this.latitude,
    required this.longitude,
  });

  factory StoreData.fromJson(Map<String, dynamic> json) {
    final geometry = json['results'][0]['geometry']['location'];

    return StoreData(
      formattedAddress: json['results'][0]['formatted_address'],
      latitude: geometry['lat'],
      longitude: geometry['lng'],
    );
  }


}
