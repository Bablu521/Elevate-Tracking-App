import 'package:dio/dio.dart';
import 'package:elevate_tracking_app/api/client/api_client.dart';
import 'package:elevate_tracking_app/api/models/requests/apply_request_dto.dart';
import 'package:elevate_tracking_app/api/models/responses/apply_response_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart'
    show DioAdapter, Matchers;

import '../../fixture/apply_fixture.dart';

void main() {
  group("Group ApplyResponseDto", () {
    //ARRANGE
    late Dio dio;
    late DioAdapter dioAdapter;
    late ApiClient apiClient;

    setUp(() {
      dio = Dio(BaseOptions(baseUrl: "https://flower.elevateegy.com/api"));
      dioAdapter = DioAdapter(dio: dio);
      apiClient = ApiClient(dio);
    });
    test("test should be return ApplyResponseDto", () async {
      //ARRANGE
      final ApplyRequestDto requestDto =
          await ApplyFixture.fakeApiClintRequestDto();
      final ApplyResponseDto responseDto = ApplyFixture.fakeResponseDto();
      dioAdapter.onPost(
        "v1/drivers/apply",
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
  });
}
