import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'country_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class CountryDto extends Equatable {
  final String? isoCode;
  final String? name;
  final String? phoneCode;
  final String? flag;
  final String? currency;
  final String? latitude;
  final String? longitude;
  final List<Timezone>? timezones;
  final String? flagUrl; // ✅ جديد

  const CountryDto({
    this.isoCode,
    this.name,
    this.phoneCode,
    this.flag,
    this.currency,
    this.latitude,
    this.longitude,
    this.timezones,
    this.flagUrl, // ✅ جديد
  });

  factory CountryDto.fromJson(Map<String, dynamic> json) =>
      _$CountryDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CountryDtoToJson(this);

  @override
  List<Object?> get props => [
        isoCode,
        name,
        phoneCode,
        flag,
        currency,
        latitude,
        longitude,
        timezones,
        flagUrl, // ✅ جديد
      ];
}

@JsonSerializable()
class Timezone extends Equatable {
  final String? zoneName;
  final int? gmtOffset;
  final String? gmtOffsetName;
  final String? abbreviation;
  final String? tzName;

  const Timezone({
    this.zoneName,
    this.gmtOffset,
    this.gmtOffsetName,
    this.abbreviation,
    this.tzName,
  });

  factory Timezone.fromJson(Map<String, dynamic> json) =>
      _$TimezoneFromJson(json);

  Map<String, dynamic> toJson() => _$TimezoneToJson(this);

  @override
  List<Object?> get props => [
        zoneName,
        gmtOffset,
        gmtOffsetName,
        abbreviation,
        tzName,
      ];
}
