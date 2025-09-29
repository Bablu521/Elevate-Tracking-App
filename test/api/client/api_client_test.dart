import 'package:dio/dio.dart';
import 'package:elevate_tracking_app/api/client/api_client.dart';
import 'package:elevate_tracking_app/core/constants/end_points.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mockito/annotations.dart';

import '../../dummy/profile_info_dummy.dart';

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
  group("test profile method", () {
    test("logout returns LogoutResponseDto", () async {
      // Arrange (Mock server response)
      final mockJson = ProfileInfoDummy.fakeLogoutResponseDto();

      dioAdapter.onGet(
        EndPoints.logout,
        (server) => server.reply(200, mockJson),
      );

      // Act
      final result = await apiClient.logout();

      // Assert
      expect(result.message, equals(mockJson.message));
    });
  });
}
