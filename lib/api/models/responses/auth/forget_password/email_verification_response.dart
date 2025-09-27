import 'package:json_annotation/json_annotation.dart';

part 'email_verification_response.g.dart';

@JsonSerializable()
class EmailVerificationResponse {
  @JsonKey(name: "status")
  final String? status;

  EmailVerificationResponse ({
    this.status,
  });

  factory EmailVerificationResponse.fromJson(Map<String, dynamic> json) {
    return _$EmailVerificationResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$EmailVerificationResponseToJson(this);
  }
}


