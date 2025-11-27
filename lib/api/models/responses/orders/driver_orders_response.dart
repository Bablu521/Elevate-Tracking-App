import 'package:elevate_tracking_app/api/models/driver_order_dto.dart';
import 'package:elevate_tracking_app/api/models/meta_data_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'driver_orders_response.g.dart';

@JsonSerializable()
class DriverOrdersResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "metadata")
  final MetaDataDTO? metadata;
  @JsonKey(name: "orders")
  final List<DriverOrderDTO>? orders;

  DriverOrdersResponse ({
    this.message,
    this.metadata,
    this.orders,
  });

  factory DriverOrdersResponse.fromJson(Map<String, dynamic> json) {
    return _$DriverOrdersResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DriverOrdersResponseToJson(this);
  }
}
















