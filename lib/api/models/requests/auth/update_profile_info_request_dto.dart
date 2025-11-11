import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'update_profile_info_request_dto.g.dart';

@JsonSerializable()
class UpdateProfileInfoRequestDto extends Equatable {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;

  const UpdateProfileInfoRequestDto({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
  });

  factory UpdateProfileInfoRequestDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileInfoRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateProfileInfoRequestDtoToJson(this);

  @override
  List<Object?> get props => [firstName, lastName, email, phone];
}
