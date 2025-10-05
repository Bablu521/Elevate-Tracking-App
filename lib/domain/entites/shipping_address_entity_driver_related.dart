import 'package:equatable/equatable.dart';

class ShippingAddressEntityDriverRelated extends Equatable {
  final String? street;
  final String? city;
  final String? phone;
  final String? lat;
  final String? long;

  const ShippingAddressEntityDriverRelated({
    this.street,
    this.city,
    this.phone,
    this.lat,
    this.long,
  });

  @override
  List<Object?> get props => [street, city, phone, lat, long];
}
