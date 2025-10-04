import 'package:json_annotation/json_annotation.dart';
part 'store_dto.g.dart';

@JsonSerializable()
class StoreDTO {
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "image")
  final String? image;
  @JsonKey(name: "address")
  final String? address;
  @JsonKey(name: "phoneNumber")
  final String? phoneNumber;
  @JsonKey(name: "latLong")
  final String? latLong;

  StoreDTO ({
    this.name,
    this.image,
    this.address,
    this.phoneNumber,
    this.latLong,
  });

  factory StoreDTO.fromJson(Map<String, dynamic> json) {
    return _$StoreDTOFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$StoreDTOToJson(this);
  }
}