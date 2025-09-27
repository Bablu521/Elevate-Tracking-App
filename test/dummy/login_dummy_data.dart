import 'package:elevate_tracking_app/api/mapper/login_mapper.dart';
import 'package:elevate_tracking_app/api/models/requests/login_request.dart';
import 'package:elevate_tracking_app/api/models/responses/login_response.dart';
import 'package:elevate_tracking_app/domain/entities/login_entity.dart';
import 'package:elevate_tracking_app/domain/entities/requests/login_request_entity.dart';

class LoginDummyData {
  LoginRequestEntity get fakeLoginRequestEntity =>
      const LoginRequestEntity(email: "fake-email", password: "fake-password");

  LoginRequest get fakeLoginRequest => fakeLoginRequestEntity.toRequest();

  LoginResponse get fakeLoginResponse =>
      LoginResponse(message: "fake-message", token: "fake-token");

  LoginEntity get fakeLoginEntity => fakeLoginResponse.toEntity();
}
