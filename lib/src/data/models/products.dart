import 'package:hive/hive.dart';
part 'products.g.dart';

@HiveType(typeId: 0)
class Products extends HiveObject {
  @HiveField(0)
  final String firstname;
  @HiveField(1)
  final String lastname;
  @HiveField(2)
  final String email;
  @HiveField(3)
  final String phonenumber;
  @HiveField(4)
  final String qrcodeno;

  @HiveField(5)
  final List<ProductData> productDatas;
  @HiveField(6)
  final List<UpcomingPickupData> upComingPickupData;

  Products({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.phonenumber,
    required this.qrcodeno,
    required this.productDatas,
    required this.upComingPickupData,
  });
}

@HiveType(typeId: 1)
class ProductData extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final double price;

  @HiveField(3)
  final String plan;

  ProductData({
    required this.id,
    required this.name,
    required this.price,
    required this.plan,
  });
}

@HiveType(typeId: 2)
class UpcomingPickupData extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String plan;
  @HiveField(2)
  final String upcomingPickupDate;
  @HiveField(3)
  final String remainingDays;
  @HiveField(4)
  final List<PickupDates> pickUpDates;
  UpcomingPickupData(
      {required this.name,
      required this.plan,
      required this.upcomingPickupDate,
      required this.remainingDays,
      required this.pickUpDates,
      required});
}

@HiveType(typeId: 3)
class PickupDates extends HiveObject {
  @HiveField(0)
  final String pickUpDate;
  PickupDates({required this.pickUpDate});
}
