import 'package:json_annotation/json_annotation.dart';

part 'start_order_items_dto.g.dart';

@JsonSerializable()
class StartOrderItemsDto {
  @JsonKey(name: "product")
  final String? product;
  @JsonKey(name: "price")
  final int? price;
  @JsonKey(name: "quantity")
  final int? quantity;
  @JsonKey(name: "_id")
  final String? id;

  StartOrderItemsDto({this.product, this.price, this.quantity, this.id});

  factory StartOrderItemsDto.fromJson(Map<String, dynamic> json) {
    return _$StartOrderItemsDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$StartOrderItemsDtoToJson(this);
  }
}
