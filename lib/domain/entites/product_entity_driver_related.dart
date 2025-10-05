import 'package:equatable/equatable.dart';

class ProductEntityDriverRelated extends Equatable {
  final String? id;
  final double? price;

  const ProductEntityDriverRelated({this.id,this.price});

  @override
  List<Object?> get props => [id, price];
}
