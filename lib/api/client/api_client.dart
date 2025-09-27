import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../core/constants/end_points.dart';
import '../models/requests/auth/forget_password/email_verification_request.dart';
import '../models/requests/auth/forget_password/forget_password_request.dart';
import '../models/requests/auth/forget_password/reset_password_request.dart';
import '../models/responses/auth/forget_password/email_verification_response.dart';
import '../models/responses/auth/forget_password/forget_password_response.dart';
import '../models/responses/auth/forget_password/reset_password_response.dart';

part 'api_client.g.dart';

@injectable
@RestApi()
abstract class ApiClient {
  @factoryMethod
  factory ApiClient(Dio dio) = _ApiClient;

  @POST(Endpoints.forgetPassword)
  Future<ForgetPasswordResponse> forgetPassword(
    @Body() ForgetPasswordRequest body,
  );

  @POST(Endpoints.verifyReset)
  Future<EmailVerificationResponse> emailVerification(
    @Body() EmailVerificationRequest body,
  );

  @PUT(Endpoints.resetPassword)
  Future<ResetPasswordResponse> resetPassword(
    @Body() ResetPasswordRequest body,
  );
}
