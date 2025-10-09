import 'package:elevate_tracking_app/domain/entites/product_entity.dart';
import 'package:equatable/equatable.dart';

class OrderItemEntity extends Equatable {
  final ProductEntity? product;
  final int? price;
  final int? quantity;
  final String? id;

  const OrderItemEntity({this.product, this.price, this.quantity, this.id});

  Map<String, dynamic> toMap() {
    return {
      'product': product?.toMap(),
      'price': price,
      'quantity': quantity,
      'id': id,
    };
  }

  factory OrderItemEntity.fromMap(Map<String, dynamic> map) {
    return OrderItemEntity(
      product: ProductEntity.fromMap(Map<String, dynamic>.from(map['product'])),
      price: map['price'] as int?,
      quantity: map['quantity'] as int?,
      id: map['id'] as String?,
    );
  }

  @override
  List<Object?> get props => [product, price, quantity, id];
}
