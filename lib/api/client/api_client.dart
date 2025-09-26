import 'package:dio/dio.dart';
import 'package:elevate_tracking_app/api/models/responses/apply_response_dto.dart';
import 'package:elevate_tracking_app/api/models/responses/vehicles_response.dart';
import 'package:elevate_tracking_app/core/constants/end_points.dart';
import 'package:elevate_tracking_app/api/models/requests/login_request.dart';
import 'package:elevate_tracking_app/api/models/responses/login_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

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
}
