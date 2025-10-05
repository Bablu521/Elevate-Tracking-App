import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'metadata_dto_driver_related.dart';
import 'driver_order_dto_driver_related.dart';

part 'driver_orders_response_dto_driver_related.g.dart';

@JsonSerializable()
class DriverOrdersResponseDtoDriverRelated extends Equatable {
  final String? message;
  final MetadataDtoDriverRelated? metadata;
  final List<DriverOrderDtoDriverRelated>? orders;

  const DriverOrdersResponseDtoDriverRelated({
    this.message,
    this.metadata,
    this.orders,
  });

  factory DriverOrdersResponseDtoDriverRelated.fromJson(Map<String, dynamic> json) =>
      _$DriverOrdersResponseDtoDriverRelatedFromJson(json);

  Map<String, dynamic> toJson() => _$DriverOrdersResponseDtoDriverRelatedToJson(this);

  @override
  List<Object?> get props => [message, metadata, orders];
}
