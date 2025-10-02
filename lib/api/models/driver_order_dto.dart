import 'package:elevate_tracking_app/api/models/order_dto.dart';
import 'package:elevate_tracking_app/api/models/store_dto.dart';
import 'package:json_annotation/json_annotation.dart';
part 'driver_order_dto.g.dart';

@JsonSerializable()
class DriverOrderDTO {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "driver")
  final String? driver;
  @JsonKey(name: "order")
  final OrderDTO? order;
  @JsonKey(name: "__v")
  final int? v;
  @JsonKey(name: "createdAt")
  final String? createdAt;
  @JsonKey(name: "updatedAt")
  final String? updatedAt;
  @JsonKey(name: "store")
  final StoreDTO? store;

  DriverOrderDTO ({
    this.id,
    this.driver,
    this.order,
    this.v,
    this.createdAt,
    this.updatedAt,
    this.store,
  });

  factory DriverOrderDTO.fromJson(Map<String, dynamic> json) {
    return _$DriverOrderDTOFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DriverOrderDTOToJson(this);
  }
}