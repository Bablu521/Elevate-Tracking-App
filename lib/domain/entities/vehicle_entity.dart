import 'package:equatable/equatable.dart';

class VehicleEntity extends Equatable {
  final String? id;
  final String? type;
  final String? image;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  const VehicleEntity({
    this.id,
    this.type,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  @override
  List<Object?> get props => [id, type, image, createdAt, updatedAt, v];
}
