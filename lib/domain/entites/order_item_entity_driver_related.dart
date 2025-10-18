import 'package:elevate_tracking_app/domain/entites/product_entity_driver_related.dart';
import 'package:equatable/equatable.dart';

class OrderItemEntityDriverRelated extends Equatable {
  final String? id;
  final ProductEntityDriverRelated? product;
  final double? price;
  final int? quantity;

  const OrderItemEntityDriverRelated({
    this.id,
    this.product,
    this.price,
    this.quantity,
  });

  @override
  List<Object?> get props => [id, product, price, quantity];
}
