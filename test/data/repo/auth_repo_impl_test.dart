import 'package:dio/dio.dart';
import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/data/data_source/auth_local_data_source.dart';
import 'package:elevate_tracking_app/data/data_source/auth_remote_data_source.dart';
import 'package:elevate_tracking_app/data/repo/auth_repo_impl.dart';
import 'package:elevate_tracking_app/domain/entites/login_entity.dart';
import 'package:elevate_tracking_app/domain/entites/logout_response_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy/login_dummy_data.dart';
import '../../dummy/profile_info_dummy.dart';
import 'auth_repo_impl_test.mocks.dart';

@GenerateMocks([AuthRemoteDataSource, AuthLocalDataSource])
void main() {
  group("test AuthRepoImpl", () {
    late MockAuthRemoteDataSource mockAuthRemoteDataSource;
    late MockAuthLocalDataSource mockAuthLocalDataSource;
    late AuthRepoImpl authRepoImpl;
    setUp(() {
      mockAuthRemoteDataSource = MockAuthRemoteDataSource();
      mockAuthLocalDataSource = MockAuthLocalDataSource();
      authRepoImpl = AuthRepoImpl(
        mockAuthRemoteDataSource,
        mockAuthLocalDataSource,
      );
    });

    group("test login", () {
      final loginRequestEntity = LoginDummyData().fakeLoginRequestEntity;

      test(
        "when call login should return LoginEntity with right data",
        () async {
          final expectedEntity = LoginDummyData().fakeLoginEntity;
          final expectedResult = ApiSuccessResult<LoginEntity>(expectedEntity);

          provideDummy<ApiResult<LoginEntity>>(expectedResult);
          when(
            mockAuthRemoteDataSource.login(loginRequestEntity),
          ).thenAnswer((_) async => expectedResult);

          final result = await authRepoImpl.login(loginRequestEntity);

          verify(mockAuthRemoteDataSource.login(loginRequestEntity)).called(1);
          verify(
            mockAuthLocalDataSource.saveUserToken(token: expectedEntity.token),
          ).called(1);
          verify(
            mockAuthLocalDataSource.saveUserRememberMe(
              loginRequestEntity: loginRequestEntity,
            ),
          ).called(1);

          expect(result, isA<ApiSuccessResult<LoginEntity>>());
          result as ApiSuccessResult<LoginEntity>;
          expect(result.data, expectedEntity);
        },
      );

      test("when login failed should return error result", () async {
        final expectedError = "fake-error";
        final expectedResult = ApiErrorResult<LoginEntity>(expectedError);

        provideDummy<ApiResult<LoginEntity>>(expectedResult);
        when(
          mockAuthRemoteDataSource.login(loginRequestEntity),
        ).thenAnswer((_) async => expectedResult);

        final result = await authRepoImpl.login(loginRequestEntity);

        verify(mockAuthRemoteDataSource.login(loginRequestEntity)).called(1);
        verify(
          mockAuthLocalDataSource.saveUserRememberMe(
            loginRequestEntity: loginRequestEntity,
          ),
        ).called(1);

        expect(result, isA<ApiErrorResult<LoginEntity>>());
        result as ApiErrorResult<LoginEntity>;
        expect(result.errorMessage, expectedError);
      });
    });
  });
  group("test logout", () {
    late MockAuthRemoteDataSource mockAuthRemoteDataSource;
    late MockAuthLocalDataSource mockAuthLocalDataSource;
    late AuthRepoImpl authRepoImpl;
    final fakeLogoutResponseEntity =
        ProfileInfoDummy.fakeLogoutResponseEntity();
    final DioException fakeDioException = DioException(
      requestOptions: RequestOptions(),
      message: "fake_message",
    );
    final Exception fakeException = Exception();
    setUp(() {
      mockAuthRemoteDataSource = MockAuthRemoteDataSource();
      mockAuthLocalDataSource = MockAuthLocalDataSource();
      authRepoImpl = AuthRepoImpl(
        mockAuthRemoteDataSource,
        mockAuthLocalDataSource,
      );
      provideDummy<ApiResult<LogoutResponseEntity>>(
        ApiSuccessResult<LogoutResponseEntity>(fakeLogoutResponseEntity),
      );
      provideDummy<ApiResult<LogoutResponseEntity>>(
        ApiErrorResult<LogoutResponseEntity>(fakeException),
      );
    });
    test("logout success ApiResult LogoutResponseEntity", () async {
      final expectResult = ApiSuccessResult<LogoutResponseEntity>(
        fakeLogoutResponseEntity,
      );
      when(
        mockAuthRemoteDataSource.logout(),
      ).thenAnswer((_) async => expectResult);

      final result = await authRepoImpl.logout();
      expect(result, isA<ApiSuccessResult<LogoutResponseEntity>>());
      expect(
        (result as ApiSuccessResult<LogoutResponseEntity>).data.message,
        equals(fakeLogoutResponseEntity.message),
      );

      verify(mockAuthRemoteDataSource.logout()).called(1);
      verify(mockAuthLocalDataSource.userLogout()).called(1);
    });
    test("logout failure ApiResult DioError", () async {
      final expectResult = ApiErrorResult<LogoutResponseEntity>(
        fakeDioException,
      );
      when(
        mockAuthRemoteDataSource.logout(),
      ).thenAnswer((_) async => expectResult);

      final result = await authRepoImpl.logout();
      expect(result, isA<ApiErrorResult<LogoutResponseEntity>>());
      expect(
        (result as ApiErrorResult<LogoutResponseEntity>).errorMessage,
        contains(fakeDioException.message),
      );

      verify(mockAuthRemoteDataSource.logout()).called(1);
      verify(mockAuthLocalDataSource.userLogout()).called(1);
    });
    test("logout failure ApiResult Exception", () async {
      final expectResult = ApiErrorResult<LogoutResponseEntity>(fakeException);
      when(
        mockAuthRemoteDataSource.logout(),
      ).thenAnswer((_) async => expectResult);

      final result = await authRepoImpl.logout();
      expect(result, isA<ApiErrorResult<LogoutResponseEntity>>());
      expect(
        (result as ApiErrorResult<LogoutResponseEntity>).error,
        equals(fakeException),
      );

      verify(mockAuthRemoteDataSource.logout()).called(1);
      verify(mockAuthLocalDataSource.userLogout()).called(1);
    });
  });
}
