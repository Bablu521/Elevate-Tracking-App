import 'package:bloc_test/bloc_test.dart';
import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/core/constants/const_keys.dart';
import 'package:elevate_tracking_app/domain/entites/login_entity.dart';
import 'package:elevate_tracking_app/domain/use_cases/login_use_case.dart';
import 'package:elevate_tracking_app/presentation/auth/login/view_model/login_events.dart';
import 'package:elevate_tracking_app/presentation/auth/login/view_model/login_view_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy/login_dummy_data.dart';
import 'login_view_model_test.mocks.dart';

@GenerateMocks([LoginUseCase, FlutterSecureStorage])
void main() {
  group("test LoginViewModel", () {
    late MockLoginUseCase mockLoginUseCase;
    late MockFlutterSecureStorage mockSecureStorage;
    late LoginViewModel loginViewModel;
    late LoginState state;
    setUp(() {
      mockLoginUseCase = MockLoginUseCase();
      mockSecureStorage = MockFlutterSecureStorage();
      loginViewModel = LoginViewModel(mockLoginUseCase, mockSecureStorage);
      state = const LoginState();
    });

    group("test RequestLoginEvent", () {
      final loginRequestEntity = LoginDummyData().fakeLoginRequestEntity;
      final expectedEntity = LoginDummyData().fakeLoginEntity;
      final expectedResult = ApiSuccessResult<LoginEntity>(expectedEntity);

      provideDummy<ApiResult<LoginEntity>>(expectedResult);

      blocTest<LoginViewModel, LoginState>(
        "call doIntent with RequestLoginEvent then load and succeeded",
        build: () => loginViewModel,
        act: (bloc) {
          when(
            mockLoginUseCase(loginRequestEntity),
          ).thenAnswer((_) async => expectedResult);
          bloc.emailController.text = loginRequestEntity.email;
          bloc.passwordController.text = loginRequestEntity.password;
          return bloc.doIntent(RequestLoginEvent());
        },
        expect: () => <LoginState>[
          state.copyWith(isLoading: true),
          state.copyWith(isLoading: false, isLoggedIn: true),
        ],
        verify: (_) {
          verify(mockLoginUseCase(loginRequestEntity)).called(1);
        },
      );

      final expectedError = "fake-error";
      final expectedErrorResult = ApiErrorResult<LoginEntity>(expectedError);

      provideDummy<ApiResult<LoginEntity>>(expectedErrorResult);

      blocTest<LoginViewModel, LoginState>(
        "call doIntent with RequestLoginEvent then load and failed",
        build: () => loginViewModel,
        act: (bloc) {
          when(
            mockLoginUseCase(loginRequestEntity),
          ).thenAnswer((_) async => expectedErrorResult);
          bloc.emailController.text = loginRequestEntity.email;
          bloc.passwordController.text = loginRequestEntity.password;
          return bloc.doIntent(RequestLoginEvent());
        },
        expect: () => <LoginState>[
          state.copyWith(isLoading: true),
          state.copyWith(isLoading: false, errorMessage: expectedError),
        ],
        verify: (_) {
          verify(mockLoginUseCase(loginRequestEntity)).called(1);
        },
      );
    });

    group("test RememberMeEvent", () {
      final expectedResult = true;

      blocTest<LoginViewModel, LoginState>(
        "call doIntent with RememberMeEvent then should update isRememberMe and write to storage",
        build: () => loginViewModel,
        act: (bloc) {
          bloc.isRememberMe.value = false;
          return bloc.doIntent(RememberMeEvent());
        },
        expect: () => <LoginState>[],
        verify: (viewModel) {
          verify(
            mockSecureStorage.write(
              key: ConstKeys.keyRememberMe,
              value: expectedResult.toString(),
            ),
          ).called(1);
          expect(viewModel.isRememberMe.value, expectedResult);
        },
      );
    });

    group("test LoadSavedUserDataEvent", () {
      final expectedEmail = "fake-email";
      final expectedPassword = "fake-password";
      final expectedResult = true;

      blocTest<LoginViewModel, LoginState>(
        "call doIntent with LoadSavedUserDataEvent should load saved email and password if rememberMe is true",
        build: () => loginViewModel,
        act: (bloc) {
          when(
            mockSecureStorage.read(key: ConstKeys.keyRememberMe),
          ).thenAnswer((_) async => expectedResult.toString());
          when(
            mockSecureStorage.read(key: ConstKeys.kUserLogin),
          ).thenAnswer((_) async => expectedEmail);
          when(
            mockSecureStorage.read(key: ConstKeys.kUserPassword),
          ).thenAnswer((_) async => expectedPassword);
          return bloc.doIntent(LoadSavedUserDataEvent());
        },
        expect: () => <LoginState>[],
        verify: (viewModel) {
          verify(
            mockSecureStorage.read(key: ConstKeys.keyRememberMe),
          ).called(1);
          verify(mockSecureStorage.read(key: ConstKeys.kUserLogin)).called(1);
          verify(
            mockSecureStorage.read(key: ConstKeys.kUserPassword),
          ).called(1);
          expect(viewModel.isRememberMe.value, expectedResult);
          expect(viewModel.emailController.text, expectedEmail);
          expect(viewModel.passwordController.text, expectedPassword);
        },
      );

      final expectedFalseResult = false;

      blocTest<LoginViewModel, LoginState>(
        "call doIntent with LoadSavedUserDataEvent should load saved email and password if rememberMe is false",
        build: () => loginViewModel,
        act: (bloc) {
          when(
            mockSecureStorage.read(key: ConstKeys.keyRememberMe),
          ).thenAnswer((_) async => expectedFalseResult.toString());
          return bloc.doIntent(LoadSavedUserDataEvent());
        },
        expect: () => <LoginState>[],
        verify: (viewModel) {
          verify(
            mockSecureStorage.read(key: ConstKeys.keyRememberMe),
          ).called(1);
          expect(viewModel.isRememberMe.value, expectedFalseResult);
        },
      );
    });

    group("test LoginButtonStatusEvent", () {
      final expectedEmail = "fake-email";
      final expectedPassword = "fake-password";

      blocTest<LoginViewModel, LoginState>(
        "call doIntent with LoginButtonStatusEvent should return true if email and password is not empty",
        build: () => loginViewModel,
        act: (bloc) {
          bloc.emailController.text = expectedEmail;
          bloc.passwordController.text = expectedPassword;
          return bloc.doIntent(LoginButtonStatusEvent());
        },
        expect: () => <LoginState>[],
        verify: (viewModel) {
          expect(viewModel.isButtonEnabled.value, isTrue);
        },
      );

      blocTest<LoginViewModel, LoginState>(
        "call doIntent with LoginButtonStatusEvent should return false if email and password is empty",
        build: () => loginViewModel,
        act: (bloc) {
          return bloc.doIntent(LoginButtonStatusEvent());
        },
        expect: () => <LoginState>[],
        verify: (viewModel) {
          expect(viewModel.isButtonEnabled.value, isFalse);
        },
      );
    });

    group("test TogglePasswordVisibilityEvent", () {
      final expectedResult = false;

      blocTest<LoginViewModel, LoginState>(
        "call doIntent with TogglePasswordVisibilityEvent should toggle isPasswordVisible state if false to true",
        build: () => loginViewModel,
        act: (bloc) {
          bloc.isPasswordVisible.value = expectedResult;
          return bloc.doIntent(TogglePasswordVisibilityEvent());
        },
        expect: () => <LoginState>[],
        verify: (viewModel) {
          expect(viewModel.isPasswordVisible.value, isTrue);
        },
      );

      final expectedTrueResult = true;

      blocTest<LoginViewModel, LoginState>(
        "call doIntent with TogglePasswordVisibilityEvent should toggle isPasswordVisible state if true to false",
        build: () => loginViewModel,
        act: (bloc) {
          bloc.isPasswordVisible.value = expectedTrueResult;
          return bloc.doIntent(TogglePasswordVisibilityEvent());
        },
        expect: () => <LoginState>[],
        verify: (viewModel) {
          expect(viewModel.isPasswordVisible.value, isFalse);
        },
      );
    });
  });
}
