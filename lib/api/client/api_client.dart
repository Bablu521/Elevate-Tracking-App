import 'package:dio/dio.dart';
import 'package:elevate_tracking_app/api/models/requests/login_request.dart';
import 'package:elevate_tracking_app/api/models/responses/login_response.dart';
import 'package:elevate_tracking_app/api/models/responses/orders/driver_orders_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../core/constants/end_points.dart';
import '../models/responses/orders/orders_response.dart';

part 'api_client.g.dart';

@injectable
@RestApi()
abstract class ApiClient {
  @factoryMethod
  factory ApiClient(Dio dio) = _ApiClient;

  @POST(EndPoints.login)
  Future<LoginResponse> login(@Body() LoginRequest loginRequest);

  @GET(EndPoints.orders)
  Future<OrdersResponse> getOrders();

  @GET(EndPoints.driverOrders)
  Future<DriverOrdersResponse> getDriverOrders();
}
