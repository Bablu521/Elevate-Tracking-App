import 'package:equatable/equatable.dart';

class VehiclesEntity extends Equatable{
  final String id;
  final String type;
  final String image;

  const VehiclesEntity({
    required this.id,
    required this.type,
    required this.image,
  });
  
  @override
  List<Object?> get props => [id,type,image];
}
