import 'package:elevate_tracking_app/api/models/responses/logout_response_dto.dart';
import 'package:elevate_tracking_app/domain/entites/logout_response_entity.dart';

extension LogoutResponseMapper on LogoutResponseDto {
  LogoutResponseEntity toEntity() {
    return LogoutResponseEntity(
      message: message,
    );
  }
}
