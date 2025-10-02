import 'package:elevate_tracking_app/domain/entites/product_entity.dart';

class OrderItemEntity {
  final ProductEntity? product;
  final int? price;
  final int? quantity;
  final String? id;

  OrderItemEntity({this.product, this.price, this.quantity, this.id});
}
