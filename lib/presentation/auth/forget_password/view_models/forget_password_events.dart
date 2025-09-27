sealed class ForgetPasswordEvents {}

class ForgetPasswordEvent extends ForgetPasswordEvents {}
class EmailVerificationEvent extends ForgetPasswordEvents {}
class ResetPasswordEvent extends ForgetPasswordEvents {}