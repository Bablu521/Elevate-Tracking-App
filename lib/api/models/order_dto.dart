import 'package:elevate_tracking_app/api/models/shipping_address_dto.dart';
import 'package:elevate_tracking_app/api/models/store_dto.dart';
import 'package:elevate_tracking_app/api/models/user_dto.dart';
import 'package:json_annotation/json_annotation.dart';

import 'order_item_dto.dart';
part 'order_dto.g.dart';

@JsonSerializable()
class OrderDTO {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "user")
  final UserDTO? user;
  @JsonKey(name: "orderItems")
  final List<OrderItemDTO>? orderItems;
  @JsonKey(name: "totalPrice")
  final int? totalPrice;
  @JsonKey(name: "shippingAddress")
  final ShippingAddressDTO? shippingAddress;
  @JsonKey(name: "paymentType")
  final String? paymentType;
  @JsonKey(name: "isPaid")
  final bool? isPaid;
  @JsonKey(name: "isDelivered")
  final bool? isDelivered;
  @JsonKey(name: "state")
  final String? state;
  @JsonKey(name: "createdAt")
  final String? createdAt;
  @JsonKey(name: "updatedAt")
  final String? updatedAt;
  @JsonKey(name: "orderNumber")
  final String? orderNumber;
  @JsonKey(name: "__v")
  final int? v;
  @JsonKey(name: "store")
  final StoreDTO? store;

  OrderDTO ({
    this.id,
    this.user,
    this.orderItems,
    this.totalPrice,
    this.shippingAddress,
    this.paymentType,
    this.isPaid,
    this.isDelivered,
    this.state,
    this.createdAt,
    this.updatedAt,
    this.orderNumber,
    this.v,
    this.store,
  });

  factory OrderDTO.fromJson(Map<String, dynamic> json) {
    return _$OrderDTOFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$OrderDTOToJson(this);
  }
}