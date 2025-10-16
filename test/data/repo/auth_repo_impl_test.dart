import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/data/data_source/auth_local_data_source.dart';
import 'package:elevate_tracking_app/data/data_source/auth_remote_data_source.dart';
import 'package:elevate_tracking_app/data/repo/auth_repo_impl.dart';
import 'package:elevate_tracking_app/domain/entites/login_entity.dart';
import 'package:elevate_tracking_app/domain/entites/requests/change_password_request_entity.dart';
import 'package:elevate_tracking_app/domain/entites/response/change_password_response_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../dummy/change_password_dummy_data.dart';
import '../../dummy/login_dummy_data.dart';
import 'auth_repo_impl_test.mocks.dart';

@GenerateMocks([AuthRemoteDataSource , AuthLocalDataSource])
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

      test(
        "when login failed should return error result",
            () async {
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
        },
      );

    });
    group("changePassword test",(){

     final changePasswordRequestEntity= ChangePasswordRequestEntity(newPassword: "123", password: "1234");
     test("when call changePassword it should return changePassword entity with right data " , () async {
       final expectedEntity = ChangePasswordDummyData().fakeChangePasswordResponseEntity;
       final expectedResult = ApiSuccessResult<ChangePasswordResponseEntity>(expectedEntity );

     provideDummy<ApiResult<ChangePasswordResponseEntity>> ( expectedResult);
     when(mockAuthRemoteDataSource.changePassword(any)).thenAnswer( (_) async => expectedResult);

     final result = await authRepoImpl.changePassword(changePasswordRequestEntity);

     verify(mockAuthRemoteDataSource.changePassword(any)).called(1);
     expect(result, isA<ApiSuccessResult<ChangePasswordResponseEntity>>());
     result as ApiSuccessResult<ChangePasswordResponseEntity>;
     expect(result.data , expectedEntity);


      });
     test("when changePassword failed it should return error data",()async{

       final expectError="fake-error";

       provideDummy<ApiResult<ChangePasswordResponseEntity>>(
         ApiErrorResult<ChangePasswordResponseEntity>(expectError),
       );
       when(mockAuthRemoteDataSource.changePassword(any))
           .thenAnswer((_) async => ApiErrorResult<ChangePasswordResponseEntity>(expectError));
       final result= await authRepoImpl.changePassword(changePasswordRequestEntity);

       verify(mockAuthRemoteDataSource.changePassword(any)).called(1);
       expect(result, isA<ApiErrorResult<ChangePasswordResponseEntity>>());
       result as ApiErrorResult<ChangePasswordResponseEntity>;
       expect(result.errorMessage, contains(expectError));
     });
    });
  });
}
