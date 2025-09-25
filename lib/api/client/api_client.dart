import 'package:dio/dio.dart';
import 'package:elevate_tracking_app/api/models/email_verification_dto.dart';
import 'package:elevate_tracking_app/api/models/email_verification_request_dto.dart';
import 'package:elevate_tracking_app/api/models/forget_password_request.dart';
import 'package:elevate_tracking_app/api/models/forget_password_response.dart';
import 'package:elevate_tracking_app/api/models/reset_password_request_dto.dart';
import 'package:elevate_tracking_app/api/models/reset_password_response_dto.dart';
import 'package:elevate_tracking_app/core/constants/end_points.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@injectable
@RestApi()
abstract class ApiClient {
  @factoryMethod
  factory ApiClient(Dio dio) = _ApiClient;

  @POST(Endpoints.forgetPassword)
  Future<ForgetPasswordResponseDto> forgetPassword(
    @Body() ForgetPasswordRequestDto body,
  );

  @POST(Endpoints.verifyReset)
  Future<EmailVerificationDto>emailVerification(
      @Body() EmailVerificationRequestDto body
      );

   @PUT(Endpoints.resetPassword)
   Future<ResetPasswordResponseDto>resetPassword(
       @Body() ResetPasswordRequestDto body
       );

}
