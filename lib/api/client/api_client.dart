import 'package:dio/dio.dart';
import 'package:elevate_tracking_app/api/models/requests/login_request.dart';
import 'package:elevate_tracking_app/api/models/responses/apply_response_dto.dart';
import 'package:elevate_tracking_app/api/models/responses/login_response.dart';
import 'package:elevate_tracking_app/api/models/responses/vehicles_response.dart';
import 'package:elevate_tracking_app/core/constants/end_points.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

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

  @POST(Endpoints.apply)
  Future<ApplyResponseDto> apply(@Body() FormData request);

  @GET(Endpoints.vehicle)
  Future<VehiclesResponse> getAllVehicles();

  @POST(Endpoints.login)
  Future<LoginResponse> login(@Body() LoginRequest loginRequest);

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
