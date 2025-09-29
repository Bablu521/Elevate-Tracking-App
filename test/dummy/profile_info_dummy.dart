import 'package:elevate_tracking_app/api/mapper/profile_info_mapper.dart';
import 'package:elevate_tracking_app/api/models/responses/logout_response_dto.dart';
import 'package:elevate_tracking_app/domain/entites/logout_response_entity.dart';

abstract class ProfileInfoDummy {
  static LogoutResponseDto fakeLogoutResponseDto() {
    return const LogoutResponseDto(message: "success");
  }

  static LogoutResponseEntity fakeLogoutResponseEntity() {
    return fakeLogoutResponseDto().toEntity();
  }
}
