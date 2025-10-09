import 'package:equatable/equatable.dart';

class LiveLocationEntity extends Equatable {
  final String? lat;
  final String? long;
  final String? address;

  const LiveLocationEntity({
    this.lat,
    this.long,
    this.address,
  });

  Map<String, dynamic> toMap() {
    return {
      'lat': lat,
      'long': long,
      'address': address,
    };
  }

  factory LiveLocationEntity.fromMap(Map<String, dynamic> map) {
    return LiveLocationEntity(
      lat: map['lat'] as String,
      long: map['long'] as String,
      address: map['address'] as String,
    );
  }

  @override
  List<Object?> get props => [lat, long, address];
}