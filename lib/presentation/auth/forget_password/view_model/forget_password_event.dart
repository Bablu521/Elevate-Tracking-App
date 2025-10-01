sealed class ForgetPasswordEvents {}

class ForgetPasswordEvent extends ForgetPasswordEvents {
  final String? email;
  ForgetPasswordEvent({this.email});
}
class VerifyResetCodeEvent extends ForgetPasswordEvents {}
class ResetPasswordEvent extends ForgetPasswordEvents {}