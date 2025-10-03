
import 'package:equatable/equatable.dart';

class UpdateProfileInfoRequestEntity extends Equatable {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;

  const UpdateProfileInfoRequestEntity({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
  });

  @override
  List<Object?> get props => [firstName, lastName, email, phone];
}
