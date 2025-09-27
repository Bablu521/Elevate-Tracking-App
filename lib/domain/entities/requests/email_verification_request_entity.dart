import 'package:equatable/equatable.dart';

class EmailVerificationRequestEntity extends Equatable {
  final String? resetCode;

  const EmailVerificationRequestEntity({this.resetCode});

  @override
  List<Object?> get props => [resetCode];
}
