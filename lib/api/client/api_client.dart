import 'package:dio/dio.dart';
import 'package:elevate_tracking_app/api/models/requests/auth/update_profile_info_request_dto.dart';
import 'package:elevate_tracking_app/api/models/requests/login_request.dart';
import 'package:elevate_tracking_app/api/models/responses/apply_response_dto.dart';
import 'package:elevate_tracking_app/api/models/responses/driver_orders_response_dto/driver_orders_response_dto_driver_related.dart';
import 'package:elevate_tracking_app/api/models/responses/login_response.dart';
import 'package:elevate_tracking_app/api/models/responses/vehicles_response.dart';
import 'package:elevate_tracking_app/core/constants/end_points.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import '../models/requests/auth/forget_password/email_verification_request.dart';
import '../models/requests/auth/forget_password/forget_password_request.dart';
import '../models/requests/auth/forget_password/reset_password_request.dart';
import '../models/requests/change_password_request_dto.dart';
import '../models/responses/auth/forget_password/email_verification_response.dart';
import '../models/responses/auth/forget_password/forget_password_response.dart';
import '../models/responses/auth/forget_password/reset_password_response.dart';
import 'package:elevate_tracking_app/api/models/responses/profile_info_response_dto/profile_info_response_dto.dart';
import 'package:elevate_tracking_app/api/models/responses/upload_profile_image_response_dto/upload_profile_image_response_dto.dart';
import 'package:elevate_tracking_app/api/models/responses/vehicle_response_dto/vehicle_response_dto.dart';
import 'package:elevate_tracking_app/core/constants/const_keys.dart';
import 'package:elevate_tracking_app/api/models/responses/logout_response_dto.dart';

import '../models/responses/change_password_response_dto.dart';
import '../models/responses/orders/driver_orders_response.dart';
import '../models/responses/orders/orders_response.dart';
import '../models/responses/orders/start_order_response.dart';

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

  @GET(Endpoints.profile)
  Future<ProfileInfoResponseDto> getLoggedDriverData();

  @PUT(Endpoints.editProfile)
  Future<ProfileInfoResponseDto> editProfile(
      @Body() UpdateProfileInfoRequestDto updateProfileInfoRequestDto,
      );

  @PUT(Endpoints.uploadProfilePhoto)
  @MultiPart()
  Future<UploadProfileImageResponseDto> uploadProfilePhoto(
      @Part(name: ConstKeys.photo) MultipartFile photo,
      );

  @GET('${Endpoints.vehicle}/{id}')
  Future<VehicleResponseDto> getVehicle(@Path("id") String id);

  @GET(Endpoints.logout)
  Future<LogoutResponseDto> logout();

  @PUT(Endpoints.editProfile)
  Future<ProfileInfoResponseDto> updateVehicleInfo(@Body() FormData request);

  @GET(Endpoints.orders)
  Future<OrdersResponse> getOrders(@Query("page") int? page);

  @GET(Endpoints.driverOrders)
  Future<DriverOrdersResponse> getDriverOrders();

  @PUT("${Endpoints.startOrder}/{orderId}")
  Future<StartOrderResponse> startOrder(@Path("orderId") String orderId);

  @PATCH(Endpoints.changePassword)
  Future<ChangePasswordResponseDto> changePassword(
      @Body() ChangePasswordRequestDto body,
      );

  @GET(Endpoints.getAllDriverOrders)
  Future<DriverOrdersResponseDtoDriverRelated>getAllDriverOrders();

}
