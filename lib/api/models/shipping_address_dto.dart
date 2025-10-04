import 'package:json_annotation/json_annotation.dart';

part 'shipping_address_dto.g.dart';

@JsonSerializable()
class ShippingAddressDTO {
  @JsonKey(name: "street")
  final String? street;
  @JsonKey(name: "city")
  final String? city;
  @JsonKey(name: "phone")
  final String? phone;
  @JsonKey(name: "lat")
  final String? lat;
  @JsonKey(name: "long")
  final String? long;

  ShippingAddressDTO ({
    this.street,
    this.city,
    this.phone,
    this.lat,
    this.long,
  });

  factory ShippingAddressDTO.fromJson(Map<String, dynamic> json) {
    return _$ShippingAddressDTOFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ShippingAddressDTOToJson(this);
  }
}


