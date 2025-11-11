import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_dto_driver_related.g.dart';

@JsonSerializable()
class UserDtoDriverRelated extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? gender;
  final String? phone;
  final String? photo;
  final String? passwordChangedAt;
  final String? passwordResetCode;
  final String? passwordResetExpires;
  final bool? resetCodeVerified;

  const UserDtoDriverRelated({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.phone,
    this.photo,
    this.passwordChangedAt,
    this.passwordResetCode,
    this.passwordResetExpires,
    this.resetCodeVerified,
  });

  factory UserDtoDriverRelated.fromJson(Map<String, dynamic> json) =>
      _$UserDtoDriverRelatedFromJson(json);

  Map<String, dynamic> toJson() => _$UserDtoDriverRelatedToJson(this);

  @override
  List<Object?> get props => [
    id,
    firstName,
    lastName,
    email,
    gender,
    phone,
    photo,
    passwordChangedAt,
    passwordResetCode,
    passwordResetExpires,
    resetCodeVerified,
  ];
}
