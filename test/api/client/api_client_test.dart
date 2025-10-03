import 'package:dio/dio.dart';
import 'package:elevate_tracking_app/api/client/api_client.dart';
import 'package:elevate_tracking_app/api/models/requests/apply_request_dto.dart';
import 'package:elevate_tracking_app/api/models/responses/apply_response_dto.dart';
import 'package:elevate_tracking_app/api/models/responses/vehicles_response.dart';
import 'package:elevate_tracking_app/core/constants/end_points.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mockito/annotations.dart';

import '../../dummy/profile_info_dummy.dart';
import '../../fixture/apply_fixture.dart';

@GenerateMocks([ApiClient])
void main() {
  late Dio dio;
  late DioAdapter dioAdapter;
  late ApiClient apiClient;
  setUpAll(() {
    dio = Dio(BaseOptions(baseUrl: "https://fakeapi.com"));
    dioAdapter = DioAdapter(dio: dio);
    apiClient = ApiClient(dio);
  });

  group("Group ApplyResponseDto", () {
    //ARRANGE
    late Dio dio;
    late DioAdapter dioAdapter;
    late ApiClient apiClient;

    setUp(() {
      dio = Dio(BaseOptions(baseUrl: "https://flower.elevateegy.com/"));
      dioAdapter = DioAdapter(dio: dio);
      apiClient = ApiClient(dio);
    });
    test("test should be return ApplyResponseDto", () async {
      //ARRANGE
      final ApplyRequestDto requestDto =
          await ApplyFixture.fakeApiClintRequestDto();
      final ApplyResponseDto responseDto = ApplyFixture.fakeResponseDto();
      dioAdapter.onPost(
        "api/v1/drivers/apply",
        (server) => server.reply(200, responseDto.toJson()),
        data: Matchers.any,
      );
      //ACT
      final result = await apiClient.apply(await requestDto.toFormData());
      //ASSERT
      expect(result, isA<ApplyResponseDto>());
      expect(result.message, equals(responseDto.message));
      expect(result.driver.firstName, equals(responseDto.driver.firstName));
    });
    test("test should be return VehiclesResponse ", () async {
      //ARRANGE
      final VehiclesResponse responseDto = ApplyFixture.fakeVehiclesResponse();
      dioAdapter.onGet(
        "api/v1/vehicles",
        (server) => server.reply(200, responseDto.toJson()),
      );
      //ACT
      final result = await apiClient.getAllVehicles();
      //ASSERT
      expect(result, isA<VehiclesResponse>());
      expect(result.message, equals(responseDto.message));
      expect(result.vehicles?.first.id, equals(responseDto.vehicles?.first.id));
    });
  });

  group("test profile method", () {
    test("logout returns LogoutResponseDto", () async {
      // Arrange (Mock server response)
      final mockJson = ProfileInfoDummy.fakeLogoutResponseDto();

      dioAdapter.onGet(
        Endpoints.logout,
        (server) => server.reply(200, mockJson),
      );

      // Act
      final result = await apiClient.logout();

      // Assert
      expect(result.message, equals(mockJson.message));
    });
  });
}
