class APIConstants {
  // static const String baseURI =
  //     'https://garbagegrabberdocker-cir5g5yodq-uc.a.run.app';
  static const baseURI = 'http://192.168.0.101:8000';
  static const String customerlogin = '/api/account/customer/login/';
  static const String customersignUp = '/api/account/customer/register/';
  static const String customerOtpValidate = '/api/account/validate_email/';
  static const String customerEmailVerification =
      '/api/account/send_email_verification/';

  static const String sendFormData = '/api/customer/profile/';
  static const String tokenRefresh = '/api/token/refresh/';
  static const String getaccountdetails = '/api/customer/fetch_accountdetails/';
  static const String addressDetails = '/api/customer/profile/address';
  static const String hompagedata = '/api/customer/homepage';
  static const String pickups = '/api/customer/pickups/';
  static const String transactions = '/api/customer/transactions';
  static const String verifyappointment = '/api/customer/verify_appointment/';
  static const String registerappointment = '/api/customer/appointments/';
  static const String createCustomerStripe =
      'https://api.stripe.com/v1/customers';
  static const String paymentIntentAPI =
      'https://api.stripe.com/v1/payment_intents/';
  static const String deleteCustomer = '/api/account/delete/';
  static const String deleteCustomerVerify = '/api/account/delete/verify/';
  static const String resendEmailDeleteCustomer =
      '/api/account/delete/verify/resend/';
}
