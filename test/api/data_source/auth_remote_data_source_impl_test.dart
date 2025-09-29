import 'package:dio/dio.dart';
import 'package:elevate_tracking_app/api/client/api_client.dart';
import 'package:elevate_tracking_app/api/data_source/auth_remote_data_source_impl.dart';
import 'package:elevate_tracking_app/api/mapper/login_mapper.dart';
import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/domain/entites/login_entity.dart';
import 'package:elevate_tracking_app/domain/entites/logout_response_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy/login_dummy_data.dart';
import '../../dummy/profile_info_dummy.dart';
import 'auth_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  group("test AuthRemoteDataSourceImpl", () {
    late MockApiClient mockApiClient;
    late AuthRemoteDataSourceImpl dataSource;

    setUp(() {
      mockApiClient = MockApiClient();
      dataSource = AuthRemoteDataSourceImpl(mockApiClient);
    });

    group("test login", () {
      final loginRequestEntity = LoginDummyData().fakeLoginRequestEntity;

      test(
        "when call login should return LoginEntity with right data",
        () async {
          final expectedResult = LoginDummyData().fakeLoginResponse;
          when(
            mockApiClient.login(loginRequestEntity.toRequest()),
          ).thenAnswer((_) async => expectedResult);

          final result = await dataSource.login(loginRequestEntity);

          verify(mockApiClient.login(loginRequestEntity.toRequest())).called(1);

          expect(result, isA<ApiSuccessResult<LoginEntity>>());
          result as ApiSuccessResult<LoginEntity>;
          expect(result.data, expectedResult.toEntity());
        },
      );

      test("when login failed should return error result", () async {
        final expectedError = "fake-error";
        when(
          mockApiClient.login(loginRequestEntity.toRequest()),
        ).thenThrow(Exception(expectedError));
        final result = await dataSource.login(loginRequestEntity);
        verify(mockApiClient.login(loginRequestEntity.toRequest())).called(1);
        expect(result, isA<ApiErrorResult<LoginEntity>>());
        result as ApiErrorResult<LoginEntity>;
        expect(result.errorMessage, contains(expectedError));
      });
    });
  });
  group("test logout", () {
    late MockApiClient mockApiClient;
    late AuthRemoteDataSourceImpl dataSource;
    final fakeLogoutResponseDto = ProfileInfoDummy.fakeLogoutResponseDto();
    final DioException fakeDioException = DioException(
      requestOptions: RequestOptions(),
      message: "fake_message",
    );
    final Exception fakeException = Exception();
    setUp(() {
      mockApiClient = MockApiClient();
      dataSource = AuthRemoteDataSourceImpl(mockApiClient);
    });
    test("logout success", () async {
      //ARRANGE
      when(
        mockApiClient.logout(),
      ).thenAnswer((_) async => fakeLogoutResponseDto);
      //ACT
      final result = await dataSource.logout();
      //ASSERT
      expect(result, isA<ApiSuccessResult<LogoutResponseEntity>>());
      expect(
        (result as ApiSuccessResult<LogoutResponseEntity>).data.message,
        equals(fakeLogoutResponseDto.message),
      );
      verify(mockApiClient.logout()).called(1);
    });
    test("logout dio exception", () async {
      //ARRANGE
      when(mockApiClient.logout()).thenThrow(fakeDioException);
      //ACT
      final result = await dataSource.logout();
      //ASSERT
      expect(result, isA<ApiErrorResult<LogoutResponseEntity>>());
      expect(
        (result as ApiErrorResult<LogoutResponseEntity>).errorMessage,
        equals(contains(fakeDioException.message)),
      );
      verify(mockApiClient.logout()).called(1);
    });
    test("apply exception", () async {
      //ARRANGE
      when(mockApiClient.logout()).thenThrow(fakeException);
      //ACT
      final result = await dataSource.logout();
      //ASSERT
      expect(result, isA<ApiErrorResult<LogoutResponseEntity>>());
      expect(
        (result as ApiErrorResult<LogoutResponseEntity>).error,
        equals(fakeException),
      );
      verify(mockApiClient.logout()).called(1);
    });
  });
}
