import 'package:elevate_tracking_app/api/models/requests/login_request.dart';
import 'package:elevate_tracking_app/api/models/responses/login_response.dart';

import '../../domain/entities/login_entity.dart';
import '../../domain/entities/requests/login_request_entity.dart';

extension LoginRequestMapper on LoginRequestEntity {
  LoginRequest toRequest() {
    return LoginRequest(email: email, password: password);
  }
}

extension LoginResponseMapper on LoginResponse {
  LoginEntity toEntity() {
    return LoginEntity(message: message ?? "", token: token ?? "");
  }
}
