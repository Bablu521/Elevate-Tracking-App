abstract class Endpoints {
  static const String login = "api/v1/drivers/signin";
  static const String apply = "api/v1/drivers/apply";
  static const String vehicle = "api/v1/vehicles";
  static const String countryLocalData = "assets/data/country.json";
  static const String forgetPassword="api/v1/drivers/forgotPassword";
  static const String verifyReset="api/v1/drivers/verifyResetCode";
  static const String resetPassword="api/v1/drivers/resetPassword";
  static const String profile = "api/v1/drivers/profile-data";
  static const String editProfile = "api/v1/drivers/editProfile";
  static const String uploadProfilePhoto = "api/v1/drivers/upload-photo";
  static const String logout = "api/v1/drivers/logout";
  static const orders = "api/v1/orders/pending-orders";
  static const driverOrders = "api/v1/orders/driver-orders";
  static const startOrder = "api/v1/orders/start";
}

