import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'order_dto_driver_related.dart';
import 'store_dto_driver_related.dart';

part 'driver_order_dto_driver_related.g.dart';

@JsonSerializable()
class DriverOrderDtoDriverRelated extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String? driver;
  final OrderDtoDriverRelated? order;
  final StoreDtoDriverRelated? store;
  final int? v;
  final String? createdAt;
  final String? updatedAt;

  const DriverOrderDtoDriverRelated({
    this.id,
    this.driver,
    this.order,
    this.store,
    this.v,
    this.createdAt,
    this.updatedAt,
  });

  factory DriverOrderDtoDriverRelated.fromJson(Map<String, dynamic> json) =>
      _$DriverOrderDtoDriverRelatedFromJson(json);

  Map<String, dynamic> toJson() => _$DriverOrderDtoDriverRelatedToJson(this);

  @override
  List<Object?> get props => [
    id,
    driver,
    order,
    store,
    v,
    createdAt,
    updatedAt,
  ];
}
