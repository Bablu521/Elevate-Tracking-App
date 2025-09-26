sealed class LoginEvents {}

class RequestLoginEvent extends LoginEvents {}
class RememberMeEvent extends LoginEvents {}
class LoadSavedUserDataEvent extends LoginEvents {}
class LoginButtonStatusEvent extends LoginEvents {}
class TogglePasswordVisibilityEvent extends LoginEvents {}
