import 'package:equatable/equatable.dart';

class ShippingAddressEntity extends Equatable {
  final String? street;
  final String? city;
  final String? phone;
  final String? lat;
  final String? long;

  const ShippingAddressEntity({
    this.street,
    this.city,
    this.phone,
    this.lat,
    this.long,
  });

  Map<String, dynamic> toMap() {
    return {
      'street': street,
      'city': city,
      'phone': phone,
      'lat': lat,
      'long': long,
    };
  }

  factory ShippingAddressEntity.fromMap(Map<String, dynamic> map) {
    return ShippingAddressEntity(
      street: map['street'] as String?,
      city: map['city'] as String?,
      phone: map['phone'] as String?,
      lat: map['lat'] as String?,
      long: map['long'] as String?,
    );
  }

  @override
  List<Object?> get props => [street, city, phone, lat, long];
}
