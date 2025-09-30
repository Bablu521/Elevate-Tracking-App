import 'package:dio/dio.dart';
import 'package:elevate_tracking_app/api/models/requests/auth/update_profile_info_request_dto.dart';
import 'package:elevate_tracking_app/api/models/requests/login_request.dart';
import 'package:elevate_tracking_app/api/models/responses/login_response.dart';
import 'package:elevate_tracking_app/api/models/responses/profile_info_response_dto/profile_info_response_dto.dart';
import 'package:elevate_tracking_app/api/models/responses/upload_profile_image_response_dto/upload_profile_image_response_dto.dart';
import 'package:elevate_tracking_app/api/models/responses/vehicle_response_dto/vehicle_response_dto.dart';
import 'package:elevate_tracking_app/core/constants/const_keys.dart';
import 'package:elevate_tracking_app/api/models/responses/logout_response_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import '../../core/constants/end_points.dart';

part 'api_client.g.dart';

@injectable
@RestApi()
abstract class ApiClient {
  @factoryMethod
  factory ApiClient(Dio dio) = _ApiClient;

  @POST(EndPoints.login)
  Future<LoginResponse> login(@Body() LoginRequest loginRequest);

  @GET(EndPoints.profile)
  Future<ProfileInfoResponseDto> getLoggedDriverData();

  @PUT(EndPoints.editProfile)
  Future<ProfileInfoResponseDto> editProfile(
    @Body() UpdateProfileInfoRequestDto updateProfileInfoRequestDto,
  );

  @PUT(EndPoints.uploadProfilePhoto)
  @MultiPart()
  Future<UploadProfileImageResponseDto> uploadProfilePhoto(
    @Part(name: ConstKeys.photo) MultipartFile photo,
  );

  @GET('${EndPoints.vehicle}/{id}')
  Future<VehicleResponseDto> getVehicle(@Path("id") String id);

  @GET(EndPoints.logout)
  Future<LogoutResponseDto> logout();

}
