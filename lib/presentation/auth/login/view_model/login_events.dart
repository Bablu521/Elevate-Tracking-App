sealed class LoginEvents {}

class RequestLoginEvent extends LoginEvents {}
class RememberMeEvent extends LoginEvents {
  final bool isRememberMe;
  RememberMeEvent(this.isRememberMe);
}
class LoadSavedUserDataEvent extends LoginEvents {}
class LoginButtonStatusEvent extends LoginEvents {}
class TogglePasswordVisibilityEvent extends LoginEvents {}
