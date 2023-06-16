class APIConstants {
  static const String baseURI = 'http://192.168.0.101:8000/';
  // static const String baseURI = 'https://garbagegrabber.azurewebsites.net/';

  static const String customerlogin = '/api/customer/login/';
  static const String customersignUp = '/api/customer/register/';
  static const String customerOtpValidate = '/api/customer/validate_email/';
  static const String customerEmailVerification =
      '/api/customer/send_email_verification/';

  static const String sendfromData = '/api/customer/profile/';
}
