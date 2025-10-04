import 'package:elevate_tracking_app/api/models/order_dto.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../meta_data_dto.dart';

part 'orders_response.g.dart';

@JsonSerializable()
class OrdersResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "metadata")
  final MetaDataDTO? metadata;
  @JsonKey(name: "orders")
  final List<OrderDTO>? orders;

  OrdersResponse ({
    this.message,
    this.metadata,
    this.orders,
  });

  factory OrdersResponse.fromJson(Map<String, dynamic> json) {
    return _$OrdersResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$OrdersResponseToJson(this);
  }
}














