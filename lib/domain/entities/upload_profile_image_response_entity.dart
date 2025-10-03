import 'package:equatable/equatable.dart';

class UploadProfileImageResponseEntity extends Equatable {
  final String? message;

  const UploadProfileImageResponseEntity({this.message});

  @override
  List<Object?> get props => [message];
}
