part of 'login_view_model.dart';

final class LoginState extends Equatable {
  final bool isLoading;
  final bool isLoggedIn;
  final String? errorMessage;

  const LoginState({this.isLoading = false, this.isLoggedIn = false, this.errorMessage});

  LoginState copyWith({
    bool? isLoading,
    bool? isLoggedIn,
    String? errorMessage,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, isLoggedIn, errorMessage];
}
