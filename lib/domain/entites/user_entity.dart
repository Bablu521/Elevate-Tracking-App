import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? gender;
  final String? phone;
  final String? photo;
  final String? passwordChangedAt;

  const UserEntity({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.phone,
    this.photo,
    this.passwordChangedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'gender': gender,
      'phone': phone,
      'photo': photo,
      'passwordChangedAt': passwordChangedAt,
    };
  }

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
      id: map['id'] as String?,
      firstName: map['firstName'] as String?,
      lastName: map['lastName'] as String?,
      email: map['email'] as String?,
      gender: map['gender'] as String?,
      phone: map['phone'] as String?,
      photo: map['photo'] as String?,
      passwordChangedAt: map['passwordChangedAt'] as String?,
    );
  }

  @override
  List<Object?> get props =>
      [
        id,
        firstName,
        lastName,
        email,
        gender,
        phone,
        photo,
        passwordChangedAt,
      ];
}
