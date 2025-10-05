import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'shipping_address_dto_driver_related.g.dart';

@JsonSerializable()
class ShippingAddressDtoDriverRelated extends Equatable {
  final String? street;
  final String? city;
  final String? phone;
  final String? lat;
  final String? long;

  const ShippingAddressDtoDriverRelated({
    this.street,
    this.city,
    this.phone,
    this.lat,
    this.long,
  });

  factory ShippingAddressDtoDriverRelated.fromJson(Map<String, dynamic> json) =>
      _$ShippingAddressDtoDriverRelatedFromJson(json);

  Map<String, dynamic> toJson() => _$ShippingAddressDtoDriverRelatedToJson(this);

  @override
  List<Object?> get props => [street, city, phone, lat, long];
}
