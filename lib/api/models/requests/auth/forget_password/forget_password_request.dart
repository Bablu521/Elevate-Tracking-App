import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'forget_password_request.g.dart';

@JsonSerializable()
class ForgetPasswordRequest extends Equatable {
  @JsonKey(name: "email")
  final String? email;

  const ForgetPasswordRequest ({
    this.email,
  });

  factory ForgetPasswordRequest.fromJson(Map<String, dynamic> json) {
    return _$ForgetPasswordRequestFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ForgetPasswordRequestToJson(this);
  }

  @override
  List<Object?> get props => [email];
}


