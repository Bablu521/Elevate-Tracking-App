import 'package:elevate_tracking_app/api/models/start_order_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'start_order_response.g.dart';

@JsonSerializable()
class StartOrderResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "orders")
  final StartOrderDto? orders;

  StartOrderResponse ({
    this.message,
    this.orders,
  });

  factory StartOrderResponse.fromJson(Map<String, dynamic> json) {
    return _$StartOrderResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$StartOrderResponseToJson(this);
  }
}




