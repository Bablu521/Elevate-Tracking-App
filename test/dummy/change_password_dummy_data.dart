import 'package:elevate_tracking_app/api/mapper/change_password_mapper.dart';
import 'package:elevate_tracking_app/api/models/requests/change_password_request_dto.dart';
import 'package:elevate_tracking_app/api/models/responses/change_password_response_dto.dart';
import 'package:elevate_tracking_app/domain/entites/requests/change_password_request_entity.dart';
import 'package:elevate_tracking_app/domain/entites/response/change_password_response_entity.dart';

class ChangePasswordDummyData{


  ChangePasswordRequestEntity get fakeChangePasswordRequestEntity =>
      ChangePasswordRequestEntity(password: "123",newPassword: "1234");

  ChangePasswordRequestDto get fakeChangePasswordRequest => fakeChangePasswordRequestEntity.fromDomain();


  ChangePasswordResponseEntity get fakeChangePasswordResponseEntity =>

      ChangePasswordResponseEntity(message: "mo",token: "mon");

  ChangePasswordResponseDto get fakeChangePasswordResponse => fakeChangePasswordResponseEntity.toDto();
}