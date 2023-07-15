class APIConstants {
  static const String baseURI = 'http://192.168.0.102:8000/';
  // static const String baseURI = 'https://garbagegrabber.azurewebsites.net/';

  static const String customerlogin = '/api/customer/login/';
  static const String customersignUp = '/api/customer/register/';
  static const String customerOtpValidate = '/api/customer/validate_email/';
  static const String customerEmailVerification =
      '/api/customer/send_email_verification/';

  static const String sendfromData = '/api/customer/profile/';
  static const String tokenRefresh = '/api/token/refresh/';
  static const String getaccountdetails = '/api/customer/fetch_accountdetails/';
  static const String customerprofile = '/api/customer/customer_profile/';
  static const String productdetails = '/api/customer/products/';
  static const String hompagedata = '/api/customer/homepage_data';
  static const String pickups = '/api/customer/pickups/';
  static const String transactions = '/api/customer/transactions';
  static const String verifyappointment = '/api/customer/verify_appointment/';
  static const String registerappointment = '/api/customer/appointments/';
  static const String createCustomerStripe =
      'https://api.stripe.com/v1/customers';
  static const String paymentIntentAPI =
      'https://api.stripe.com/v1/payment_intents/';
}
