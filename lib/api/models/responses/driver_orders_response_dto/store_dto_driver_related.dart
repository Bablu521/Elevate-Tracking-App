import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'store_dto_driver_related.g.dart';

@JsonSerializable()
class StoreDtoDriverRelated extends Equatable {
  final String? name;
  final String? image;
  final String? address;
  final String? phoneNumber;
  final String? latLong;

  const StoreDtoDriverRelated({
    this.name,
    this.image,
    this.address,
    this.phoneNumber,
    this.latLong,
  });

  factory StoreDtoDriverRelated.fromJson(Map<String, dynamic> json) =>
      _$StoreDtoDriverRelatedFromJson(json);

  Map<String, dynamic> toJson() => _$StoreDtoDriverRelatedToJson(this);

  @override
  List<Object?> get props => [name, image, address, phoneNumber, latLong];
}
