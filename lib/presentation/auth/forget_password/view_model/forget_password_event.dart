sealed class ForgetPasswordEvents {}

class ForgetPasswordEvent extends ForgetPasswordEvents {}
class VerifyResetCodeEvent extends ForgetPasswordEvents {}
class ResetPasswordEvent extends ForgetPasswordEvents {}