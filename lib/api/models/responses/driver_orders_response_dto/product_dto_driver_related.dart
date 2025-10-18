import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_dto_driver_related.g.dart';

@JsonSerializable()
class ProductDtoDriverRelated extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final double? price;

  const ProductDtoDriverRelated({this.id,this.price});

  factory ProductDtoDriverRelated.fromJson(Map<String, dynamic> json) =>
      _$ProductDtoDriverRelatedFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDtoDriverRelatedToJson(this);

  @override
  List<Object?> get props => [id, price];
}
