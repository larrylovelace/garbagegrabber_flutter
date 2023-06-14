import 'package:garbage_grabber/pages/setup/login.dart';
import 'package:garbage_grabber/pages/setup/otp_screen.dart';
import 'package:garbage_grabber/pages/setup/signup.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const String login = '/login';
  static const String register = '/register';
  static const String otpscreen = '/otpscreen';

  static final List<GetPage> routes = [
    // GetPage(
    //   name: splash,
    //   page: () => const SplashScreen(),
    //   binding: SplashBinding(),
    // ),
    GetPage(
      name: login,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
      transition:
          Transition.fadeIn, // Set a transition animation for login screen
    ),
    GetPage(
      name: register,
      page: () => const RegisterScreen(),
      binding: RegisterBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: otpscreen,
      page: () => OtpScreen(email: Get.parameters['email'].toString()),
      binding: OtpScreenBinding(),
      transition: Transition.fadeIn,
    ),
  ];
}

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    // Dependencies for the Login screen can be added here
  }
}

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    // Dependencies for the Register screen can be added here
  }
}

class OtpScreenBinding extends Bindings {
  @override
  void dependencies() {
    // Dependencies for the Register screen can be added here
  }
}
