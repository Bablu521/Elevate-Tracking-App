import 'package:json_annotation/json_annotation.dart';

part 'email_verification_dto.g.dart';

@JsonSerializable()
class EmailVerificationDto {
  @JsonKey(name: "status")
  final String? status;

  EmailVerificationDto ({
    this.status,
  });

  factory EmailVerificationDto.fromJson(Map<String, dynamic> json) {
    return _$EmailVerificationDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$EmailVerificationDtoToJson(this);
  }
}


