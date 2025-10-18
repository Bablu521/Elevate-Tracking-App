import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'product_dto_driver_related.dart';

part 'order_item_dto_driver_related.g.dart';

@JsonSerializable()
class OrderItemDtoDriverRelated extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final ProductDtoDriverRelated? product;
  final double? price;
  final int? quantity;

  const OrderItemDtoDriverRelated({
    this.id,
    this.product,
    this.price,
    this.quantity,
  });

  factory OrderItemDtoDriverRelated.fromJson(Map<String, dynamic> json) =>
      _$OrderItemDtoDriverRelatedFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemDtoDriverRelatedToJson(this);

  @override
  List<Object?> get props => [id, product, price, quantity];
}
