import 'package:elevate_tracking_app/core/api_result/api_result.dart';
import 'package:elevate_tracking_app/domain/use_cases/login_use_case.dart';
import 'package:elevate_tracking_app/presentation/auth/login/view_model/login_events.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/constants/const_keys.dart';
import '../../../../domain/entities/login_entity.dart';
import '../../../../domain/entities/requests/login_request_entity.dart';

part 'login_state.dart';

@injectable
class LoginViewModel extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;
  final FlutterSecureStorage _secureStorage;

  LoginViewModel(this._loginUseCase, this._secureStorage)
    : super(const LoginState());

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  ValueNotifier<bool> isRememberMe = ValueNotifier(false);
  ValueNotifier<bool> isButtonEnabled = ValueNotifier(false);
  ValueNotifier<bool> isPasswordVisible = ValueNotifier(false);

  void doIntent(LoginEvents events) {
    switch (events) {
      case RequestLoginEvent():
        _login();
      case RememberMeEvent():
        _changeRememberMeState();
      case LoadSavedUserDataEvent():
        _loadSavedUserData();
      case LoginButtonStatusEvent():
        _changeButtonStatus();
      case TogglePasswordVisibilityEvent():
        _togglePasswordVisibility();
    }
  }

  Future<void> _loadSavedUserData() async {
    final isRememberMeStorage = await _secureStorage.read(
      key: ConstKeys.keyRememberMe,
    );
    if (isRememberMeStorage == ConstKeys.trueKey) {
      final email = await _secureStorage.read(key: ConstKeys.kUserLogin);
      final password = await _secureStorage.read(key: ConstKeys.kUserPassword);
      emailController.text = email ?? "";
      passwordController.text = password ?? "";
      isRememberMe.value = true;
      _changeButtonStatus();
    }
  }

  Future<void> _login() async {
    emit(const LoginState(isLoading: true));
    final result = await _loginUseCase(
      LoginRequestEntity(
        email: emailController.text,
        password: passwordController.text,
      ),
    );
    switch (result) {
      case ApiSuccessResult<LoginEntity>():
        emit(state.copyWith(isLoading: false, isLoggedIn: true));
      case ApiErrorResult<LoginEntity>():
        emit(
          state.copyWith(isLoading: false, errorMessage: result.errorMessage),
        );
    }
  }

  Future<void> _changeRememberMeState() async {
    isRememberMe.value = !isRememberMe.value;
    await _secureStorage.write(
      key: ConstKeys.keyRememberMe,
      value: isRememberMe.value.toString(),
    );
  }

  void _togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void _changeButtonStatus() {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      isButtonEnabled.value = true;
    } else {
      isButtonEnabled.value = false;
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
