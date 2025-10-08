import 'package:elevate_tracking_app/domain/entities/product_entity.dart';
import 'package:equatable/equatable.dart';

class OrderItemEntity extends Equatable {
  final ProductEntity? product;
  final int? price;
  final int? quantity;
  final String? id;

  const OrderItemEntity({this.product, this.price, this.quantity, this.id});

  @override
  List<Object?> get props => [product, price, quantity, id];
}
