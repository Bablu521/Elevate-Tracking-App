import 'package:elevate_tracking_app/api/client/api_client.dart';
import 'package:elevate_tracking_app/api/data_source/auth_remote_data_source_impl.dart';
import 'package:elevate_tracking_app/api/mapper/login_mapper.dart';
import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/domain/entites/login_entity.dart';
import 'package:elevate_tracking_app/domain/entites/response/change_password_response_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy/change_password_dummy_data.dart';
import '../../dummy/login_dummy_data.dart';
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

    group ("change password test",(){
      final changePasswordRequestEntity =  ChangePasswordDummyData().fakeChangePasswordRequestEntity;
      test( "when call change password test  it should return change password with data " ,
              () async {
         final expectResult= ChangePasswordDummyData().fakeChangePasswordResponse;
         when(mockApiClient.changePassword(any)).thenAnswer(( _ ) async => expectResult );

         final result= await dataSource.changePassword(changePasswordRequestEntity);

         verify(mockApiClient.changePassword(any)).called(1);
         expect(result, isA<ApiSuccessResult<ChangePasswordResponseEntity>>());
         result as ApiSuccessResult<ChangePasswordResponseEntity>;
         expect(result.data.message, expectResult.message);
         expect(result.data.token, expectResult.token);

          });

      test("when changePassword failed it should return error result ",() async {
       final  expectedError = "fake-error";
        when(mockApiClient.changePassword(any)).thenThrow(Exception(expectedError));
        final result = await  dataSource.changePassword(changePasswordRequestEntity);

        verify(mockApiClient.changePassword(any)).called(1);
        expect(result, isA<ApiErrorResult<ChangePasswordResponseEntity>>());
        result as ApiErrorResult<ChangePasswordResponseEntity>;
        expect(result.errorMessage, contains(expectedError));
      });
    });

  });
}
