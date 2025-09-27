import '../../../../domain/entities/email_verification_entity.dart';
import '../../../../domain/entities/forget_password_entity.dart';
import '../../../../domain/entities/requests/email_verification_request_entity.dart';
import '../../../../domain/entities/requests/forget_password_request_entity.dart';
import '../../../../domain/entities/requests/reset_password_request_entity.dart';
import '../../../../domain/entities/reset_password_entity.dart';
import '../../../models/requests/auth/forget_password/email_verification_request.dart';
import '../../../models/requests/auth/forget_password/forget_password_request.dart';
import '../../../models/requests/auth/forget_password/reset_password_request.dart';
import '../../../models/responses/auth/forget_password/email_verification_response.dart';
import '../../../models/responses/auth/forget_password/forget_password_response.dart';
import '../../../models/responses/auth/forget_password/reset_password_response.dart';

extension ForgetPasswordMapper on ForgetPasswordResponse {
  ForgetPasswordEntity toEntity() {
    return ForgetPasswordEntity(message: message, info: info);
  }
}

extension ForgetPasswordRequestMapper on ForgetPasswordRequestEntity {
  ForgetPasswordRequest toRequest() {
    return ForgetPasswordRequest(email: email);
  }
}

extension ResetPasswordMapper on ResetPasswordResponse {
  ResetPasswordEntity toEntity() {
    return ResetPasswordEntity(message: message);
  }
}

extension ResetPasswordRequestMapper on ResetPasswordRequestEntity {
  ResetPasswordRequest toRequest() {
    return ResetPasswordRequest(email: email, newPassword: newPassword);
  }
}

extension EmailVerificationMapper on EmailVerificationResponse {
  EmailVerificationEntity toEntity() {
    return EmailVerificationEntity(status: status);
  }
}

extension EmailVerificationRequestMapper on EmailVerificationRequestEntity {
  EmailVerificationRequest toRequest() {
    return EmailVerificationRequest(resetCode: resetCode);
  }
}
