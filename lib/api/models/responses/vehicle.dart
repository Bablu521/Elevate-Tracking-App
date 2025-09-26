import 'package:json_annotation/json_annotation.dart';
part 'vehicle.g.dart';

@JsonSerializable()
class Vehicle {
  @JsonKey(name: '_id')
  final String? id;
  final String? type;
  final String? image;
  final String? createdAt;
  final String? updatedAt;
  @JsonKey(name: '__v')
  final int? v;

  Vehicle({
    this.id,
    this.type,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) =>
      _$VehicleFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleToJson(this);
}
