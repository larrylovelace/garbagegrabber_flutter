// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductsAdapter extends TypeAdapter<Products> {
  @override
  final int typeId = 0;

  @override
  Products read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Products(
      firstname: fields[0] as String,
      lastname: fields[1] as String,
      email: fields[2] as String,
      phonenumber: fields[3] as String,
      qrcodeno: fields[4] as String,
      productDatas: (fields[5] as List).cast<ProductData>(),
      upComingPickupData: (fields[6] as List).cast<UpcomingPickupData>(),
    );
  }

  @override
  void write(BinaryWriter writer, Products obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.firstname)
      ..writeByte(1)
      ..write(obj.lastname)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.phonenumber)
      ..writeByte(4)
      ..write(obj.qrcodeno)
      ..writeByte(5)
      ..write(obj.productDatas)
      ..writeByte(6)
      ..write(obj.upComingPickupData);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ProductDataAdapter extends TypeAdapter<ProductData> {
  @override
  final int typeId = 1;

  @override
  ProductData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductData(
      id: fields[0] as int,
      name: fields[1] as String,
      price: fields[2] as double,
      plan: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ProductData obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.plan);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class UpcomingPickupDataAdapter extends TypeAdapter<UpcomingPickupData> {
  @override
  final int typeId = 2;

  @override
  UpcomingPickupData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UpcomingPickupData(
      name: fields[0] as String,
      plan: fields[1] as String,
      upcomingPickupDate: fields[2] as String,
      remainingDays: fields[3] as String,
      pickUpDates: (fields[4] as List).cast<PickupDates>(),
    );
  }

  @override
  void write(BinaryWriter writer, UpcomingPickupData obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.plan)
      ..writeByte(2)
      ..write(obj.upcomingPickupDate)
      ..writeByte(3)
      ..write(obj.remainingDays)
      ..writeByte(4)
      ..write(obj.pickUpDates);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UpcomingPickupDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PickupDatesAdapter extends TypeAdapter<PickupDates> {
  @override
  final int typeId = 3;

  @override
  PickupDates read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PickupDates(
      pickUpDate: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PickupDates obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.pickUpDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PickupDatesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
