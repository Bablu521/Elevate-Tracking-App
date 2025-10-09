import 'package:equatable/equatable.dart';

class StoreEntity extends Equatable {
  final String? name;
  final String? image;
  final String? address;
  final String? phoneNumber;
  final String? latLong;

  const StoreEntity({
    this.name,
    this.image,
    this.address,
    this.phoneNumber,
    this.latLong,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'address': address,
      'phoneNumber': phoneNumber,
      'latLong': latLong,
    };
  }

  factory StoreEntity.fromMap(Map<String, dynamic> map) {
    return StoreEntity(
      name: map['name'] as String?,
      image: map['image'] as String?,
      address: map['address'] as String?,
      phoneNumber: map['phoneNumber'] as String?,
      latLong: map['latLong'] as String?,
    );
  }

  @override
  List<Object?> get props => [name, image, address, phoneNumber, latLong];
}
