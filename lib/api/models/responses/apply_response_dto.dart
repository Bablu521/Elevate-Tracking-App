import 'package:elevate_tracking_app/api/models/responses/driver_dto.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'apply_response_dto.g.dart';


@JsonSerializable()
class ApplyResponseDto extends Equatable {
  final String message;
  final DriverDto driver;
  final String token;

  const ApplyResponseDto({
    required this.message,
    required this.driver,
    required this.token,
  });

  factory ApplyResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ApplyResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ApplyResponseDtoToJson(this);

  @override
  List<Object?> get props => [message, driver, token];
}
