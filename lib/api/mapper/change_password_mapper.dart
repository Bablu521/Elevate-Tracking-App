import '../../domain/entites/requests/change_password_request_entity.dart';
import '../../domain/entites/response/change_password_response_entity.dart';
import '../models/requests/change_password_request_dto.dart';
import '../models/responses/change_password_response_dto.dart';

extension ChangePasswordMapper on ChangePasswordResponseDto{
  ChangePasswordResponseEntity toEntity() {
    return ChangePasswordResponseEntity(
        message: message,
        token: token
    );
  }
}

extension ChangePasswordRequestMapper on ChangePasswordRequestEntity{

  ChangePasswordRequestDto fromDomain(){
    return ChangePasswordRequestDto(
        newPassword: newPassword,
        password: password,

    );
  }
}