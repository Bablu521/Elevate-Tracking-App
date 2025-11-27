import 'package:elevate_tracking_app/api/models/product_dto.dart';
import 'package:json_annotation/json_annotation.dart';
part 'order_item_dto.g.dart';

@JsonSerializable()
class OrderItemDTO {
  @JsonKey(name: "product")
  final ProductDTO? product;
  @JsonKey(name: "price")
  final int? price;
  @JsonKey(name: "quantity")
  final int? quantity;
  @JsonKey(name: "_id")
  final String? id;

  OrderItemDTO ({
    this.product,
    this.price,
    this.quantity,
    this.id,
  });

  factory OrderItemDTO.fromJson(Map<String, dynamic> json) {
    return _$OrderItemDTOFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$OrderItemDTOToJson(this);
  }
}