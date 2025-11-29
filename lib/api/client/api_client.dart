import 'package:dio/dio.dart';
import 'package:elevate_tracking_app/api/models/requests/login_request.dart';
import 'package:elevate_tracking_app/api/models/responses/change_password_response_dto.dart';
import 'package:elevate_tracking_app/api/models/responses/login_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../core/constants/end_points.dart';
import '../models/requests/change_password_request_dto.dart';

part 'api_client.g.dart';

@injectable
@RestApi()
abstract class ApiClient {
  @factoryMethod
  factory ApiClient(Dio dio) = _ApiClient;

  @POST(EndPoints.login)
  Future<LoginResponse> login(@Body() LoginRequest loginRequest);


  @PATCH(EndPoints.changePassword)
  Future<ChangePasswordResponseDto> changePassword(
      @Body() ChangePasswordRequestDto body,
      );


}
