import 'package:equatable/equatable.dart';

class CountryEntity extends Equatable {
  final String name;
  final String flag;
  final String currency;
  final String flagImage;
  const CountryEntity({
    required this.name,
    required this.flagImage,
    required this.flag,
    required this.currency,
  });

  @override
  List<Object?> get props => [name, flag, currency];
}
