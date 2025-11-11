import 'package:elevate_tracking_app/api/data_source/auth_local_data_source_impl.dart';
import 'package:elevate_tracking_app/core/constants/const_keys.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy/login_dummy_data.dart';
import 'auth_local_data_source_impl_test.mocks.dart';

@GenerateMocks([FlutterSecureStorage])
void main() {
  group("test AuthLocalDataSourceImpl", () {
    late MockFlutterSecureStorage mockStorage;
    late AuthLocalDataSourceImpl dataSource;

    setUp(() {
      mockStorage = MockFlutterSecureStorage();
      dataSource = AuthLocalDataSourceImpl(mockStorage);
    });

    group("saveUserRememberMe", () {
      final loginRequestEntity = LoginDummyData().fakeLoginRequestEntity;

      test("should save email & password when remember me is true", () async {
        when(
          mockStorage.read(key: ConstKeys.keyRememberMe),
        ).thenAnswer((_) async => ConstKeys.trueKey);

        await dataSource.saveUserRememberMe(
          loginRequestEntity: loginRequestEntity,
        );

        verify(mockStorage.read(key: ConstKeys.keyRememberMe)).called(1);
        verify(
          mockStorage.write(
            key: ConstKeys.kUserLogin,
            value: loginRequestEntity.email,
          ),
        ).called(1);
        verify(
          mockStorage.write(
            key: ConstKeys.kUserPassword,
            value: loginRequestEntity.password,
          ),
        ).called(1);
      });

      test(
        "should delete email & password when remember me is not true",
        () async {
          when(
            mockStorage.read(key: ConstKeys.keyRememberMe),
          ).thenAnswer((_) async => "false");

          await dataSource.saveUserRememberMe(
            loginRequestEntity: loginRequestEntity,
          );

          verify(mockStorage.read(key: ConstKeys.keyRememberMe)).called(1);
          verify(mockStorage.delete(key: ConstKeys.kUserLogin)).called(1);
          verify(mockStorage.delete(key: ConstKeys.kUserPassword)).called(1);
        },
      );
    });

    group("saveUserToken", () {
      test("should write token to storage", () async {
        const token = "fake-token";

        await dataSource.saveUserToken(token: token);

        verify(
          mockStorage.write(key: ConstKeys.keyUserToken, value: token),
        ).called(1);
      });
    });
  });
  group("test logout", () {
    late MockFlutterSecureStorage mockStorage;
    late AuthLocalDataSourceImpl dataSource;
    setUp(() {
      mockStorage = MockFlutterSecureStorage();
      dataSource = AuthLocalDataSourceImpl(mockStorage);
    });
    test("should save token correctly", () async {
      // Arrange
      // Act
      await dataSource.userLogout();

      // Assert
      verify(mockStorage.delete(key: ConstKeys.keyUserToken)).called(1);
    });
  });
}
