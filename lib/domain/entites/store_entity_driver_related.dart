import 'package:equatable/equatable.dart';

class StoreEntityDriverRelated extends Equatable {
  final String? name;
  final String? image;
  final String? address;
  final String? phoneNumber;
  final String? latLong;

  const StoreEntityDriverRelated({
    this.name,
    this.image,
    this.address,
    this.phoneNumber,
    this.latLong,
  });

  @override
  List<Object?> get props => [name, image, address, phoneNumber, latLong];
}
