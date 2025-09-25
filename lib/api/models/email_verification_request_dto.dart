import 'package:json_annotation/json_annotation.dart';

part 'email_verification_request_dto.g.dart';

@JsonSerializable()
class EmailVerificationRequestDto {
  @JsonKey(name: "resetCode")
  final String? resetCode;

  EmailVerificationRequestDto ({
    this.resetCode,
  });

  factory EmailVerificationRequestDto.fromJson(Map<String, dynamic> json) {
    return _$EmailVerificationRequestDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$EmailVerificationRequestDtoToJson(this);
  }
}


